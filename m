Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266553AbUHOIrO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266553AbUHOIrO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 04:47:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266560AbUHOIrO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 04:47:14 -0400
Received: from host4-67.pool80117.interbusiness.it ([80.117.67.4]:7296 "EHLO
	dedasys.com") by vger.kernel.org with ESMTP id S266553AbUHOIrJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 04:47:09 -0400
To: linuxppc-dev@lists.linuxppc.org
Cc: j.s@lmu.de, linux-kernel@vger.kernel.org
Subject: 2.6.8 (or 7?) regression: sleep on older tibooks broken
From: davidw@dedasys.com (David N. Welton)
Date: 15 Aug 2004 10:45:24 +0200
Message-ID: <873c2ohjrv.fsf@dedasys.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I was previously using a stock 2.6.6 kernel without problems on my
tibook.  I upgraded to 2.6.8.1 and compiled using:

gcc (GCC) 3.3.4 (Debian 1:3.3.4-6sarge1)

and "Version: 2.14.90.0.7-8" of binutils, in Debian.

I saw there is a similar problem here:

http://lists.linuxppc.org/linuxppc-dev/200407/msg00092.html

but it's not the same problem... I removed the ohci_hcd module from
the kernel (it's present at boot), and sleep still doesn't happen.  I
don't even get the "breathing" light, and yet the computer still seems
warm after some time, seemingly indicative that it's not really asleep
or dead.  I can only restart it via the Ctrl-Command-Power
combination.

Logs don't say anything.

So - what got changed that could have caused this breakage?

Kernel configs and other info available on request.

@ashland [~] $ cat /proc/cpuinfo
processor       : 0
cpu             : 7410, altivec supported
temperature     : 1-76 C (uncalibrated)
clock           : 400MHz
revision        : 17.2 (pvr 800c 1102)
bogomips        : 796.67
machine         : PowerBook3,2
motherboard     : PowerBook3,2 MacRISC2 MacRISC Power Macintosh
detected as     : 71 (PowerBook Titanium)
pmac flags      : 0000000b
L2 cache        : 1024K unified
memory          : 256MB
pmac-generation : NewWorld

Thankyou,
-- 
David N. Welton
     Personal: http://www.dedasys.com/davidw/
Free Software: http://www.dedasys.com/freesoftware/
   Apache Tcl: http://tcl.apache.org/
       Photos: http://www.dedasys.com/photos/
