Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262566AbTHUKQr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 06:16:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262565AbTHUKQr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 06:16:47 -0400
Received: from dns.toxicfilms.tv ([150.254.37.24]:14012 "EHLO
	dns.toxicfilms.tv") by vger.kernel.org with ESMTP id S262566AbTHUKQq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 06:16:46 -0400
Date: Thu, 21 Aug 2003 12:16:41 +0200 (CEST)
From: Maciej Soltysiak <solt@dns.toxicfilms.tv>
To: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
Cc: "H.Rosmanith (Kernel Mailing List)" <kernel@wildsau.idv.uni.linz.at>,
       linux-kernel@vger.kernel.org
Subject: Re: usb-storage: how to ruin your hardware(?)
In-Reply-To: <20030820185550.A24579@one-eyed-alien.net>
Message-ID: <Pine.LNX.4.51.0308211208290.22664@dns.toxicfilms.tv>
References: <200308210134.h7L1YmRE011754@wildsau.idv.uni.linz.at>
 <20030820185550.A24579@one-eyed-alien.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> P.P.S. The 'strange partition table' you saw probably wasn't a partition
> table at all -- it was likely the start of a VFAT filesystem.  I'm guessing
> that if you had just mounted /dev/sda (notice no partition number!), it
> would have worked.
I almost killed my USB 128mb flash (it's an mp3 player also).
I also noticed a strange partition and "fixed" it. And file transfers
where ok (VFAT, formatted), but suddenly it stopped playing audio. When I
redid the formatting as a plain DOS partition using fdisk command.
   o   create a new empty DOS partition table

MP3 started playing right.
It seems that many manufacturers rely on undocumented (yes, I haven't
found any pointers about partition table format, etc.) nuances
and settings.
Like your USB BAR's starting sector's data, that seemed to be garbage.

Maybe a message of caution should be displayed in usb-storage
configure help about attemtping to change partitions and/or filesystems on
USB storage devices.

Regards,
Maciej

