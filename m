Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262290AbTCMNGp>; Thu, 13 Mar 2003 08:06:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262292AbTCMNGp>; Thu, 13 Mar 2003 08:06:45 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:45833 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262290AbTCMNGo>; Thu, 13 Mar 2003 08:06:44 -0500
Date: Thu, 13 Mar 2003 13:17:28 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@transmeta.com>
Subject: Patches, effort, motivation
Message-ID: <20030313131728.A4861@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm getting to the point of completely giving up kernel development
outside the ARM tree, which basically means leaving serial, pci, and
pcmcia to other people.

I have been trying for the last 5 days to get Linus to accept two
patches small patches:

1. a patch to register tty_devclass using postcore_initcall().

   This is necessary before I can push the next set of serial changes.
   Without it, the serial layer will oops in sysfs when it tries to
   register drivers.

2. a patch to restore the PCI device probing, so we don't probe
   all functions when we discover that function 0 is not present.
   This is the behaviour we had prior to 2.5.64.

Both of these patches have been sent to Linus several times over the
past 5 days, and each time they have been completely ignored without
explaination.

I have a huge pile of patches backing up here.  I'm at the point where
I'm going to give up updating them to bk-curr, and testing them before
sending each to Linus due to the number of patches.  Going around this
loop just takes too much of my time to make it worth while.

My backlog currently consists of:

	8 PCI patches (1 needs to be further cut up)
	10 PCMCIA patches (1 needs to be further cut up)
	1 tty_io.c patch
	16 serial csets

there are some dependencies between these patches, and getting the stuff
applied in the right order is absolutely paramount to ensure that things
don't break.

So, any suggestions on how to handle this better, and above all get Linus
to start applying stuff?

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

