Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315919AbSIDWvf>; Wed, 4 Sep 2002 18:51:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315870AbSIDWvf>; Wed, 4 Sep 2002 18:51:35 -0400
Received: from hera.cwi.nl ([192.16.191.8]:29332 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S315746AbSIDWve>;
	Wed, 4 Sep 2002 18:51:34 -0400
From: Andries.Brouwer@cwi.nl
Date: Thu, 5 Sep 2002 00:56:00 +0200 (MEST)
Message-Id: <UTC200209042256.g84Mu0w15389.aeb@smtp.cwi.nl>
To: greg@kroah.com, mdharm-kernel@one-eyed-alien.net
Subject: Re: [linux-usb-devel] Feiya 5-in-1 Card Reader
Cc: Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Matt, is it ok with you for me to add this patch to the tree?

> I'd like to hold off a few more days while I try to find out what the
> 'secret sauce' that the other OSes use for a device like this.

Hmm. You do not confuse two situations, do you?
In the past few days I made two devices work.

One was a Feiya 5-in-1 CF / SM / SD card reader
(Vendor Id: 090c, Product Id: 1132, Revision 1.00).
It returned a capacity that is one too large, and becomes
very unhappy if one tries to read a sector past the end.
So, a flag was needed to tell that the result of READ CAPACITY
needs fixing.

The other was a Travelmate CF / SM / SD card reader
(Vendor Id: 3538, Product Id: 0001, Revision 2.05).
It became unhappy when MODE_SENSE asked for too much data.
A patch on sd.c solved this.

Andries
