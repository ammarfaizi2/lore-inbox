Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261864AbULLXyx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261864AbULLXyx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Dec 2004 18:54:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262088AbULLXyx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Dec 2004 18:54:53 -0500
Received: from out014pub.verizon.net ([206.46.170.46]:62626 "EHLO
	out014.verizon.net") by vger.kernel.org with ESMTP id S261864AbULLXyu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Dec 2004 18:54:50 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: dummy help on io
Date: Sun, 12 Dec 2004 18:54:48 -0500
User-Agent: KMail/1.7
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412121854.48898.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out014.verizon.net from [151.205.42.94] at Sun, 12 Dec 2004 17:54:49 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings;

I've ordered the device drivers book from O-Reilly but it will be
a few days getting here.

I'm trying to mod the GPL'd archive PIO.tar.gz, so it will build a
driver for a pci card with 3 each 82C55's on it, and I *think* I'd
have it working with the first of the 3 chips if I could figure
out what to do about using the call "iopl(3);" on installing
the driver, and conversely an "iopl(0);" at rmmod time.

I'm told this is required to gain access perms to addresses above
0x3FF.  The call "ioperm" is used below that I've been told.

Unforch, an "insmod PIO io=0xf100" (where the card is addressed
at currently) is spitting out an "unresolved symbol" error for the
iopl call.

Being a rank beginner at "pc" hardware, can someone give me a
checklist of things I've probably left out please?

Kernel is 2.4.25-adeos.  With the module "rtai" inserted when emc
is running for realtime control purposes.

The card is pure hardware, no bios, only address decoding that
can set the base address anyplace in the first 64k of address
space in a step of 4 sequence from 0xnn00-0xnn0C for the 4
ports of chip 1, 0xnn10-1C for chip 2, etc, where the nn is the
dipswitch setting.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.30% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.


