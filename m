Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261156AbULJUxF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261156AbULJUxF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Dec 2004 15:53:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261158AbULJUxE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Dec 2004 15:53:04 -0500
Received: from out008pub.verizon.net ([206.46.170.108]:44481 "EHLO
	out008.verizon.net") by vger.kernel.org with ESMTP id S261156AbULJUw7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Dec 2004 15:52:59 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Advice on high mem ioports needed
Date: Fri, 10 Dec 2004 15:52:57 -0500
User-Agent: KMail/1.7
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412101552.58133.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out008.verizon.net from [151.205.42.94] at Fri, 10 Dec 2004 14:52:58 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings;

I'm trying to cobble up a kernel driver for a card with 3 each
8255's on it, to be used as machine control.

I have supposedly modified it for the 4 byte jumps this card uses
between port addresses, and the compile and insmod both seem
to work w/o errors when the insmod is given the argument of
io=0xf100 (where the cards address is set to via dipswitches) as
long as I don't try to register more than the first of 3 chips on
this board.

But, running a demo program using port_a  of chip 0 thats supposed
to cause a motor to step once per second has no effect on the 8255 in
question, while a reboot to dos, and a dos based exersize program
works just fine.

I think the code I'm fooling with (google for PIO-tar.gz) assumes
its working below the 0x3FF barrier, but this card responds to
accesses in the 0xF100-0xF12F range.  I *think* this might be my
problem..

I've looked up the iopl call, but so far no "blinding flash of
knowledge" has come my way.  Is there a resource available that can
enlighten me on this subject?  Something that starts at square one
as I'm a total dummy vis-a-vis pci bus management functions.

The kernel running is the one from emc's Brain Dead Install, 
version rc46, kernel=2.4.25-adeos, so the advice should be valid
for later 2.4 kernels as I've been told that the 2.6 stuff has a whole 
new api.

Thanks for any pointers that can be thrown my way.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.30% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.

