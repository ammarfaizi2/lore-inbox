Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275439AbTHJA3m (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Aug 2003 20:29:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275440AbTHJA3m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Aug 2003 20:29:42 -0400
Received: from out006pub.verizon.net ([206.46.170.106]:17306 "EHLO
	out006.verizon.net") by vger.kernel.org with ESMTP id S275439AbTHJA3k
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Aug 2003 20:29:40 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: None that appears to be detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: nvidia gforce2 MMX 32meg failure
Date: Sat, 9 Aug 2003 20:29:39 -0400
User-Agent: KMail/1.5.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308092029.39597.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out006.verizon.net from [151.205.63.55] at Sat, 9 Aug 2003 19:29:39 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greets;

I just tried to boot 2.6.0-test3, without the advansys driver in the 
kernel, intending to test it, but then recalled that the patches 
applied to the unpacked 
	NVIDIA-Linux-x86-1.0-4496-pkg2
src tree, the 
	NVIDIA_kernel-1.0-4496-2.5.diff,
hadn't made it work for test2, so I tried that first.

This script was executed to build the nvidia install, as per the 
instructions in the patch:
------------------
#!/bin/bash
cd usr/src/nv
make
cd ../../..
make install
------------------
Which appears to build as expected.

That still fails during startx, at about the point where the nvidia 
splash screen should be seen, requireing a hardware reset to recover.  
I've saved the XFree86.0.log, so what list do I send it for a 
pathology report and a new prescription/patch?

Obviously, back on a 2.4.22-rc2 kernel boot.  I'll try the advansys 
modprobe next.

Side comment:  When I shutdown x, and then reboot after sending this 
msg, the fact that I've been running a 2.6 kernel will probably be 
confirmed by the shutdown scripts being unable to unmount my /usr on 
/dev/hda8, and this will be the case until such time as I let e2fsk 
scan it, reporting no problems when it does.

To me, that says there is still something a bit fubar with the ide 
stuffs yet.

-- 
Cheers, Gene
AMD K6-III@500mhz 320M
Athlon1600XP@1400mhz  512M
99.27% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2003 by Maurice Eugene Heskett, all rights reserved.

