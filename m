Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267239AbTAFXw4>; Mon, 6 Jan 2003 18:52:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267243AbTAFXwt>; Mon, 6 Jan 2003 18:52:49 -0500
Received: from hera.cwi.nl ([192.16.191.8]:20694 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S267239AbTAFXwh>;
	Mon, 6 Jan 2003 18:52:37 -0500
From: Andries.Brouwer@cwi.nl
Date: Tue, 7 Jan 2003 01:00:47 +0100 (MET)
Message-Id: <UTC200301070000.h0700lx20735.aeb@smtp.cwi.nl>
To: Andries.Brouwer@cwi.nl, patmans@us.ibm.com
Subject: IDs
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net, mdharm-kernel@one-eyed-alien.net,
       zwane@holomorphy.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Instead of truncating the id, we need a new scsi_uid field allocated
> to whatever size required.

> And, a descriptive string put in the name, rather than the id, such as:
> scsi disk

[I changed the Subject line "Re: inquiry in scsi_scan.c" since people
are still discussing devices with a buggy INQUIRY response;
maybe unnecessarily - all details are well understood, and
patches fixing all problems have been posted, but in any case
it is best to separate both threads.]

Maybe I should ask you to explain more in detail what purpose
you have in mind. If I read your code and hear you talking
it sounds like you would like to have a string identifying
the device. But in many cases no such string exists.

Moreover, what precisely is "the device"?
If I have a Compact Flash card reader and read CF cards,
is the device the reader? Or the card? Or the combination?
If I have an Imation FlashGo! reader, and insert a SmartMedia
adapter, and read a SmartMedia card, is the device the reader,
the reader plus adapter, the card?

If the device is the reader, then it will have a different size,
partitioning and contents each time we see it.
If the device is the card, then we need a different driver
each time we see it.

What do you want to recognize with this ID, and why?


Andries
