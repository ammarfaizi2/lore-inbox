Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265352AbUAJVZI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 16:25:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265391AbUAJVZI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 16:25:08 -0500
Received: from vaino.wakkanet.fi ([212.83.117.4]:62609 "EHLO vaino.wakkanet.fi")
	by vger.kernel.org with ESMTP id S265352AbUAJVZD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 16:25:03 -0500
Date: Sat, 10 Jan 2004 23:23:43 +0200 (EET)
From: Kai Vehmanen <kai.vehmanen@wakkanet.fi>
X-X-Sender: kaiv@vaino.wakkanet.fi
To: linux-kernel@vger.kernel.org
Subject: 2.4.20- boot freezes; works on 2.4.19
Message-ID: <Pine.LNX.4.44.0401101856210.18078-100000@vaino.wakkanet.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With kernel 2.4.20 and newer (tested all 2.4 kernels until the new
2.4.24), my machine hangs during the boot sequence, right _after_ local
filesystems cheched and _before_ they are succesfully mounted.

This happens every time, and always at the same place. 2.4.19 (and
earlier, have ran various kernels since 2.2.xx on this machine) have never
frozen during boot. I know this sounds crazy, but I've tested dozens of
times and the problem occurs systematically each and every time. 2.4.19
otoh has not froze even once.

Now what makes this more curious is that if I do a cold-boot (press the
reset-button after boot freezes), the second boot goes through fine, and
once up, system works like a charm. The freeze-on-boot error only occurs
if I do a sw-reboot, or after power-up.

When the boot seq freezes, the console still works (I can type "foobar"
and see the results), but kernel does not respond to any commands
(ctrl-alt-del does not work, neither does SysReq). And no oopses either.
As the system is not yet fully up, I cannot gather any other info
about the system state.

Anyone else seen this problem? Ideas where to start testing? The
2.4.19->2.4.20 patch is quite large (5MB gzipped!), so manually going
through all the changesets would take me forever (2 boots per try :(). 
I haven't yet tested 2.6.

Hw-details:
- Abit BP6 motherboad with 2x466Mhz Celerons, 384MB of mem 
- the integrated HPT366 IDE interface _not_ used
- 80GB samsumg IDE-drive as /dev/hda

Sw-details
- vanilla 2.4 kernels, no patches applied, no tainting drivers
- kernels compiled with gcc-2.95.3
- base system is a heavily modified redhat-6.1
- / and /boot are ext2, /home is /ext3, all mounted
  during boot
- kernel .config exactly the same in all tests (minus
  new/removed features between kernel versions)
- tried with "acpi=off" and "nosmp" kernel params but no help

--
 http://www.eca.cx
 Audio software for Linux!

