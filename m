Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264126AbTEGRKc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 13:10:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264129AbTEGRKc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 13:10:32 -0400
Received: from axion.xs4all.nl ([213.84.8.90]:3112 "EHLO axion.demon.nl")
	by vger.kernel.org with ESMTP id S264126AbTEGRK2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 13:10:28 -0400
Date: Wed, 7 May 2003 19:22:57 +0200
From: Monchi Abbad <kernel@axion.demon.nl>
To: linux-kernel@vger.kernel.org
Subject: dvb-tuner ves1820 not working since linux-2.5.68
Message-ID: <20030507172257.GB783@axion.demon.nl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Bn2rw/3z4jIqBvZU"
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Bn2rw/3z4jIqBvZU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

>From kernel 2.5.68 on when dvb tuner driver ves1820 is compiled in the kernel freezes up upon init of ves1820 driver. When compiled as module the system doesn't freeze but the driver segfaults on load (see attachments). In kernel 2.5.67-bk3 no problems.

Monchi.
--

--Bn2rw/3z4jIqBvZU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=module_ves1820_segfault

root@tivo:~# modprobe ves1820
Unable to handle kernel paging request at virtual address a06300c1
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c0003064>]    Not tainted
EFLAGS: 00010282
eax: 00000000   ebx: c981a1cc   ecx: c01a8991   edx: 00002180
esi: c9d52560   edi: c981a000   ebp: c981a024   esp: c7857f0c
ds: 007b   es: 007b   ss: 0068
Process modprobe (pid: 334, threadinfo=c7856000 task=c79b6d60)
Stack: c9d52580 c981a024 c03740a0 c981a000 00000003 c03740e0 00000000 00000000 
       cb0d9c80 00000000 09000000 c9d52560 c7856000 c981a000 c03c8aa0 cb0d9a2d 
       cb0d961c c9d52560 09006948 cb0d9c80 c940c240 00000001 c9d52560 c024382a 
Call Trace: [<cb0d9c80>]  [<cb0d9a2d>]  [<cb0d961c>]  [<cb0d9c80>]  [<c024382a>]  [<c0243989>]  [<c0243b7b>]  [<cb0d9d80>]  [<cb0db014>]  [<cb0d9d80>]  [<cb0d99c0>]  [<cb0d9a44>]  [<c01358f6>]  [<c010ae87>] 
Code: 63 90 c1 00 63 a0 c1 00 63 b0 c1 00 63 c0 c1 00 63 d0 c1 00 
 Segmentation fault
root@tivo:~# 

--Bn2rw/3z4jIqBvZU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=built_in_ves1820_segfault

Linux video capture interface: v1.00
saa7146: register extension 'dvb'.
PCI: Enabling device 00:12.0 (0204 -> 0206)
PCI: Found IRQ 11 for device 00:12.0
PCI: Sharing IRQ 11 with 00:09.0
saa7146: found saa7146 @ mem 0xcb008c00 (revision 1, irq 11) (0x110a,0x0000).
saa7146_vv: saa7146 (0): registered device video0 [v4l2]
DVB: registering new adapter (Siemens cable card PCI rev1.5).
drivers/media/dvb/frontends/ves1820.c: setup for tuner spXXXX
DVB: registering frontend 0:0 (VES1820 based DVB-C frontend)...
Unable to handle kernel paging request at virtual address a06300c1
 printing eip:
c0003064
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c0003064>]    Not tainted
EFLAGS: 00010292
eax: 00000000   ebx: c9de21cc   ecx: c01a8991   edx: 00002180
esi: c9d52540   edi: c9de2000   ebp: c9de2024   esp: c9fc3e14
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 1, threadinfo=c9fc2000 task=c9fc0040)
Stack: c9d52560 c9de2024 c0377200 c9de2000 00000003 c0377240 00000000 00000000 
       c03cc900 00000000 09000000 c9d52540 c9fc4000 c9de2000 c03cc7a0 c0246d9d 
       c024698c c9d52540 09006948 c03cc900 c9d52660 c9d52540 c9d52540 c0244faa 
Call Trace: [<c0246d9d>]  [<c024698c>]  [<c0244faa>]  [<c0245147>]  [<c024520c>]  [<c024f18f>]  [<c024f010>]  [<c0251ca0>]  [<c0251d83>]  [<c01cf9f1>]  [<c021c2df>]  [<c021c3b3>]  [<c021c60b>]  [<c0123dbf>]  [<c021c98c>]  [<c01cfae4>]  [<c0252021>]  [<c03ff11a>]  [<c03e461d>]  [<c03e4689>]  [<c010508f>]  [<c0105060>]  [<c01091d9>] 
Code: 63 90 c1 00 63 a0 c1 00 63 b0 c1 00 63 c0 c1 00 63 d0 c1 00 
 <0>Kernel panic: Attempted to kill init!

--Bn2rw/3z4jIqBvZU--
