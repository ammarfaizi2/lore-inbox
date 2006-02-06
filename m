Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932383AbWBFVm1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932383AbWBFVm1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 16:42:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932271AbWBFVm1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 16:42:27 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:64720 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932383AbWBFVm0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 16:42:26 -0500
Date: Mon, 6 Feb 2006 22:41:59 +0100
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>,
       Len Brown <len.brown@intel.com>
Cc: seife@suse.de
Subject: strange NAPA system: very slow network, no bttv
Message-ID: <20060206214159.GA14200@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I have very big black "notebook", with really small lid (and warning
labels all around)... and have some problems with it.

First minor problem: upon boot, fan state becames desynchronized with
what linux thinks; fan blows but cpu is cold. echo 0 > state; echo 3 >
state fixes that.

What is worse, networking is slow. *Very* slow. Both on internal lan
card and on hp100 I plugged into PCI. I'm getting 10KB/sec over 10Mbit
ethernet. (That's 1% !). With acpi=off, it gets better... I get
100KB/sec (10%). Ouch. ksoftirqd eats 100% cpu with acpi off.

There's some very wrong with bttv on this machine. Radio works, tv
tunning works and tv audio plays, but I can't get any picture:

root@hobit:~# cat /dev/video0
bttv0: reset, reinitialize
bttv0: PLL: 28636363 => 35468950 . ok
bttv0: timeout: drop=0 irq=195/237, risc=37cdf01c, bits: VSYNC HSYNC
OFLOW
cat: /dev/video0: Input/output error
root@hobit:~# time cat /dev/video0
bttv0: reset, reinitialize
bttv0: PLL: 28636363 => 35468950 . ok
bttv0: timeout: drop=0 irq=198/240, risc=37cdf01c, bits: VSYNC HSYNC
OFLOW
cat: /dev/video0: Input/output error
0.00user 0.00system 0.53 (0m0.533s) elapsed 0.75%CPU
root@hobit:~#

I was not able to get sata to work, so I'm running in some kind of
legacy mode. Disk is slow, but I do not think it is related to strange
problems. CPU frequency scaling seems to work okay, and both CPUs
perform quite well. It is very fast on kernel compilation.

Any ideas what could cause those strange symptoms?
								Pavel
-- 
Web maintainer for suspend.sf.net (www.sf.net/projects/suspend) wanted...
