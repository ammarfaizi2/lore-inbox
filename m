Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263033AbTEBRuT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 May 2003 13:50:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263032AbTEBRuT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 May 2003 13:50:19 -0400
Received: from smtp.inet.fi ([192.89.123.192]:29365 "EHLO smtp.inet.fi")
	by vger.kernel.org with ESMTP id S263026AbTEBRuF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 May 2003 13:50:05 -0400
From: Kimmo Sundqvist <rabbit80@mbnet.fi>
Organization: Unorganized
To: linux-kernel@vger.kernel.org
Subject: 2.5.68-mm4 and 3c900 is a horror
Date: Fri, 2 May 2003 21:02:01 +0300
User-Agent: KMail/1.5.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200305022102.01420.rabbit80@mbnet.fi>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.5.68-mm4, but something less extreme from now on

There are many kinds of these... the trouble seems to be with the Ethernet 
card, a 3com 3c900.

May  2 20:34:10 minjami kernel: irq 19: nobody cared!
May  2 20:34:10 minjami kernel: Call Trace:
May  2 20:34:10 minjami kernel:  [handle_IRQ_event+151/244] 
handle_IRQ_event+0x97/0xf4
May  2 20:34:10 minjami kernel:  [do_IRQ+190/344] do_IRQ+0xbe/0x158
May  2 20:34:10 minjami kernel:  [default_idle+0/52] default_idle+0x0/0x34
May  2 20:34:10 minjami kernel:  [common_interrupt+24/32] 
common_interrupt+0x18/0x20
May  2 20:34:10 minjami kernel:  [default_idle+0/52] default_idle+0x0/0x34
May  2 20:34:10 minjami kernel:  [default_idle+43/52] default_idle+0x2b/0x34
May  2 20:34:10 minjami kernel:  [cpu_idle+55/72] cpu_idle+0x37/0x48
May  2 20:34:10 minjami kernel:  [start_secondary+114/116] 
start_secondary+0x72/0x74
May  2 20:34:11 minjami kernel:  [release_console_sem+103/228] 
release_console_sem+0x67/0xe4
May  2 20:34:11 minjami kernel:  [printk+363/400] printk+0x16b/0x190

Another:

May  2 20:34:11 minjami kernel: handlers:
May  2 20:34:11 minjami kernel: [<f894cdc0>] (boomerang_interrupt+0x0/0x424 
[3c59x])
May  2 20:34:13 minjami kernel: irq 19: nobody cared!
May  2 20:34:13 minjami kernel: Call Trace:
May  2 20:34:13 minjami kernel:  [handle_IRQ_event+151/244] 
handle_IRQ_event+0x97/0xf4
May  2 20:34:13 minjami kernel:  [do_IRQ+190/344] do_IRQ+0xbe/0x158
May  2 20:34:13 minjami kernel:  [default_idle+0/52] default_idle+0x0/0x34
May  2 20:34:13 minjami kernel:  [rest_init+0/104] _stext+0x0/0x68
May  2 20:34:13 minjami kernel:  [common_interrupt+24/32] 
common_interrupt+0x18/0x20
May  2 20:34:13 minjami kernel:  [default_idle+0/52] default_idle+0x0/0x34
May  2 20:34:13 minjami kernel:  [rest_init+0/104] _stext+0x0/0x68
May  2 20:34:13 minjami kernel:  [default_idle+44/52] default_idle+0x2c/0x34
May  2 20:34:13 minjami kernel:  [cpu_idle+55/72] cpu_idle+0x37/0x48
May  2 20:34:13 minjami kernel:  [rest_init+101/104] _stext+0x65/0x68
May  2 20:34:13 minjami kernel:  [start_kernel+330/336] 
start_kernel+0x14a/0x150

Another:

May  2 20:34:14 minjami kernel: irq 19: nobody cared!
May  2 20:34:14 minjami kernel: Call Trace:
May  2 20:34:14 minjami kernel:  [handle_IRQ_event+151/244] 
handle_IRQ_event+0x97/0xf4
May  2 20:34:14 minjami kernel:  [do_IRQ+190/344] do_IRQ+0xbe/0x158
May  2 20:34:14 minjami kernel:  [common_interrupt+24/32] 
common_interrupt+0x18/0x20

Another:

May  2 20:34:14 minjami kernel: handlers:
May  2 20:34:14 minjami kernel: [<f894cdc0>] (boomerang_interrupt+0x0/0x424 
[3c59x])
May  2 20:34:15 minjami kernel: irq 19: nobody cared!
May  2 20:34:15 minjami kernel: Call Trace:
May  2 20:34:15 minjami kernel:  [handle_IRQ_event+151/244] 
handle_IRQ_event+0x97/0xf4
May  2 20:34:15 minjami kernel:  [do_IRQ+190/344] do_IRQ+0xbe/0x158
May  2 20:34:15 minjami kernel:  [common_interrupt+24/32] 
common_interrupt+0x18/0x20
May  2 20:34:15 minjami kernel: handlers:
May  2 20:34:15 minjami kernel: [<f894cdc0>] (boomerang_interrupt+0x0/0x424 
[3c59x])
May  2 20:34:16 minjami kernel: irq 19: nobody cared!
May  2 20:34:16 minjami kernel: Call Trace:
May  2 20:34:16 minjami kernel:  [handle_IRQ_event+151/244] 
handle_IRQ_event+0x97/0xf4
May  2 20:34:16 minjami kernel:  [do_IRQ+190/344] do_IRQ+0xbe/0x158
May  2 20:34:16 minjami kernel:  [common_interrupt+24/32] 
common_interrupt+0x18/0x20
May  2 20:34:16 minjami kernel:  [do_softirq+91/200] do_softirq+0x5b/0xc8
May  2 20:34:16 minjami kernel:  [do_softirq+93/200] do_softirq+0x5d/0xc8
May  2 20:34:16 minjami kernel:  [smp_apic_timer_interrupt+322/340] 
smp_apic_timer_interrupt+0x142/0x154
May  2 20:34:16 minjami kernel:  [default_idle+0/52] default_idle+0x0/0x34
May  2 20:34:16 minjami kernel:  [rest_init+0/104] _stext+0x0/0x68
May  2 20:34:16 minjami kernel:  [apic_timer_interrupt+26/32] 
apic_timer_interrupt+0x1a/0x20
May  2 20:34:16 minjami kernel:  [default_idle+0/52] default_idle+0x0/0x34
May  2 20:34:16 minjami kernel:  [rest_init+0/104] _stext+0x0/0x68
May  2 20:34:16 minjami kernel:  [schedule+0/1344] schedule+0x0/0x540
May  2 20:34:16 minjami kernel:  [need_resched+39/50] need_resched+0x27/0x32
May  2 20:34:16 minjami kernel:  [default_idle+0/52] default_idle+0x0/0x34
May  2 20:34:16 minjami kernel:  [rest_init+0/104] _stext+0x0/0x68
May  2 20:34:16 minjami kernel:  [default_idle+44/52] default_idle+0x2c/0x34
May  2 20:34:16 minjami kernel:  [cpu_idle+55/72] cpu_idle+0x37/0x48
May  2 20:34:16 minjami kernel:  [rest_init+101/104] _stext+0x65/0x68
May  2 20:34:16 minjami kernel:  [start_kernel+330/336] 
start_kernel+0x14a/0x150

Another:

May  2 20:34:16 minjami kernel: handlers:
May  2 20:34:16 minjami kernel: [<f894cdc0>] (boomerang_interrupt+0x0/0x424 
[3c59x])
May  2 20:34:17 minjami kernel: irq 19: nobody cared!
May  2 20:34:17 minjami kernel: Call Trace:
May  2 20:34:17 minjami kernel:  [handle_IRQ_event+151/244] 
handle_IRQ_event+0x97/0xf4
May  2 20:34:17 minjami kernel:  [do_IRQ+190/344] do_IRQ+0xbe/0x158
May  2 20:34:17 minjami kernel:  [common_interrupt+24/32] 
common_interrupt+0x18/0x20

Another:

May  2 20:34:18 minjami kernel: handlers:
May  2 20:34:18 minjami kernel: [<f894cdc0>] (boomerang_interrupt+0x0/0x424 
[3c59x])
May  2 20:34:19 minjami kernel: irq 19: nobody cared!
May  2 20:34:19 minjami kernel: Call Trace:
May  2 20:34:19 minjami kernel:  [handle_IRQ_event+151/244] 
handle_IRQ_event+0x97/0xf4
May  2 20:34:19 minjami kernel:  [do_IRQ+190/344] do_IRQ+0xbe/0x158
May  2 20:34:19 minjami kernel:  [default_idle+0/52] default_idle+0x0/0x34
May  2 20:34:19 minjami kernel:  [common_interrupt+24/32] 
common_interrupt+0x18/0x20
May  2 20:34:19 minjami kernel:  [default_idle+0/52] default_idle+0x0/0x34
May  2 20:34:19 minjami kernel:  [default_idle+43/52] default_idle+0x2b/0x34
May  2 20:34:19 minjami kernel:  [cpu_idle+55/72] cpu_idle+0x37/0x48
May  2 20:34:19 minjami kernel:  [start_secondary+114/116] 
start_secondary+0x72/0x74
May  2 20:34:19 minjami kernel:  [release_console_sem+103/228] 
release_console_sem+0x67/0xe4
May  2 20:34:19 minjami kernel:  [printk+363/400] printk+0x16b/0x190

Another:

May  2 20:34:33 minjami kernel: handlers:
May  2 20:34:33 minjami kernel: [<f894cdc0>] (boomerang_interrupt+0x0/0x424 
[3c59x])
May  2 20:34:34 minjami kernel: irq 19: nobody cared!
May  2 20:34:34 minjami kernel: Call Trace:
May  2 20:34:34 minjami kernel:  [handle_IRQ_event+151/244] 
handle_IRQ_event+0x97/0xf4
May  2 20:34:34 minjami kernel:  [do_IRQ+190/344] do_IRQ+0xbe/0x158
May  2 20:34:34 minjami kernel:  [common_interrupt+24/32] 
common_interrupt+0x18/0x20
May  2 20:34:34 minjami kernel:  [do_softirq+91/200] do_softirq+0x5b/0xc8
May  2 20:34:34 minjami kernel:  [do_softirq+93/200] do_softirq+0x5d/0xc8
May  2 20:34:34 minjami kernel:  [smp_apic_timer_interrupt+322/340] 
smp_apic_timer_interrupt+0x142/0x154
May  2 20:34:34 minjami kernel:  [default_idle+0/52] default_idle+0x0/0x34
May  2 20:34:34 minjami kernel:  [rest_init+0/104] _stext+0x0/0x68
May  2 20:34:34 minjami kernel:  [apic_timer_interrupt+26/32] 
apic_timer_interrupt+0x1a/0x20
May  2 20:34:34 minjami kernel:  [default_idle+0/52] default_idle+0x0/0x34
May  2 20:34:34 minjami kernel:  [rest_init+0/104] _stext+0x0/0x68
May  2 20:34:34 minjami kernel:  [default_idle+44/52] default_idle+0x2c/0x34
May  2 20:34:34 minjami kernel:  [cpu_idle+55/72] cpu_idle+0x37/0x48
May  2 20:34:34 minjami kernel:  [rest_init+101/104] _stext+0x65/0x68
May  2 20:34:34 minjami kernel:  [start_kernel+330/336] 
start_kernel+0x14a/0x150

22 perfectly good errors left un-copypasted.

Then my kern.log contained some screenfuls of 
^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@
^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@
^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@
^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@
^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@

(copied from "cat kern.log | less")

And then a list of files, which are from openoffice.org source directory 
/stg/src/openoffice.org-1.0.1/build-tree/oo_1.0.1_src/stoc/unxlngi4.pro/

Some 200 filenames, like: 
/stg/src/openoffice.org-1.0.1/build-tree/oo_1.0.1_src/stoc/unxlngi4.pro/slo/invadp_description.obj
/stg/src/openoffice.org-1.0.1/build-tree/oo_1.0.1_src/stoc/unxlngi4.pro/slo/invadp_version.o
/stg/src/openoffice.org-1.0.1/build-tree/oo_1.0.1_src/stoc/unxlngi4.pro/slo/invocation.o
/stg/src/openoffice.org-1.0.1/build-tree/oo_1.0.1_src/stoc/unxlngi4.pro/slo/invocation.obj
/stg/src/openoffice.org-1.0.1/build-tree/oo_1.0.1_src/stoc/unxlngi4.pro/slo/inv_description.o
/stg/src/openoffice.org-1.0.1/build-tree/oo_1.0.1_src/stoc/unxlngi4.pro/slo/inv_description.obj
/stg/src/openoffice.org-1.0.1/build-tree/oo_1.0.1_src/stoc/unxlngi4.pro/slo/inv_version.o
/stg/src/openoffice.org-1.0.1/build-tree/oo_1.0.1_src/stoc/unxlngi4.pro/slo/javaloader.o
/stg/src/openoffice.org-1.0.1/build-tree/oo_1.0.1_src/stoc/unxlngi4.pro/slo/javaloader.obj

(stg stands for storage, a 20GB partition with miscellaneous stuff)

After that it seems I got tired of waiting (the machine acted as if it was 
doing nothing, i.e. locked, reacting to nothing) and pushed the reset button.

How should I refine my error reporting?  I'll now go and see if all my 
ReiserFS partitions are ok.

Debian 3.0r1, gcc version 2.95.4 20011002 (Debian prerelease), Abit VP6 SMP 
motherboard with dual pIII 933MHz.

00:00.0 Host bridge: VIA Technologies, Inc. VT82C693A/694x [Apollo PRO133x] 
(rev c4)
00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598/694x [Apollo MVP3/Pro133x 
AGP]
00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 
40)
00:07.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06)
00:07.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 16)
00:07.3 USB Controller: VIA Technologies, Inc. UHCI USB (rev 16)
00:07.4 Bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 40)
00:0b.0 Multimedia audio controller: Ensoniq 5880 AudioPCI (rev 02)
00:0c.0 Ethernet controller: 3Com Corporation 3c900 Combo [Boomerang]
00:0e.0 Unknown mass storage controller: Triones Technologies, Inc. HPT366 / 
HPT370 (rev 03)
01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G200 AGP (rev 03)

-Kimmo S.
