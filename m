Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932193AbWCAQHS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932193AbWCAQHS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 11:07:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932402AbWCAQHS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 11:07:18 -0500
Received: from 213-140-2-68.ip.fastwebnet.it ([213.140.2.68]:11440 "EHLO
	aa001msg.fastwebnet.it") by vger.kernel.org with ESMTP
	id S932193AbWCAQHQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 11:07:16 -0500
Date: Wed, 1 Mar 2006 17:07:18 +0100
From: Paolo Ornati <ornati@fastwebnet.it>
To: Paolo Ornati <ornati@fastwebnet.it>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Kernel BUG at mm/slab.c:2564 - 2.6.16-rc5-g7b14e3b5
Message-ID: <20060301170718.6f97b9d8@localhost>
In-Reply-To: <20060301160656.370e1ee0@localhost>
References: <20060301160656.370e1ee0@localhost>
X-Mailer: Sylpheed-Claws 2.0.0-rc4 (GTK+ 2.8.8; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Mar 2006 16:06:56 +0100
Paolo Ornati <ornati@fastwebnet.it> wrote:

> I'm going to reboot ;)

Some more info...

1) System

AMD Athlon64 3200+
2 x 256MB DDR400 (Corsair Value)
Asus A8VSE Deluxe

0000:00:00.0 Host bridge: VIA Technologies, Inc. VT8385 [K8T800 AGP] Host Bridge (rev 01)
0000:00:01.0 PCI bridge: VIA Technologies, Inc. VT8237 PCI bridge [K8T800/K8T890 South]
0000:00:0a.0 Ethernet controller: Marvell Technology Group Ltd. 88E8001 Gigabit Ethernet Controller (rev 13)
0000:00:0e.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)
0000:00:0f.0 RAID bus controller: VIA Technologies, Inc. VIA VT6420 SATA RAID Controller (rev 80)
0000:00:0f.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06)
0000:00:10.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 81)
0000:00:10.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 81)
0000:00:10.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 81)
0000:00:10.3 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 81)
0000:00:10.4 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 86)
0000:00:11.0 ISA bridge: VIA Technologies, Inc. VT8237 ISA bridge [KT600/K8T800/K8T890 South]
0000:00:11.5 Multimedia audio controller: VIA Technologies, Inc. VT8233/A/8235/8237 AC97 Audio Controller (rev 60)
0000:00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] HyperTransport Technology Configuration
0000:00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Address Map
0000:00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] DRAM Controller
0000:00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Miscellaneous Control
0000:01:00.0 VGA compatible controller: ATI Technologies Inc RV280 [Radeon 9200 SE] (rev 01)
0000:01:00.1 Display controller: ATI Technologies Inc RV280 [Radeon 9200 SE] (Secondary) (rev 01)


2) partitions:
/	ext3
/var	reiserfs

After the reboot I've checked the reiserfs partition and found errors
fixable only with "reiserfsck --rebuild-tree".


3) memory corruption?
With this PC I've experienced sporadically memory corruption many months
ago... but they are gone away disabling Memory Interleaving in the BIOS
(tested with memtest86+). Maybe it only fails less often...


4) Frequency scaling: the only thing I've recently enabled is frequence
scaling (with "ondemand" governor).

-- 
	Paolo Ornati
	Linux 2.6.16-rc5-g7b14e3b5 on x86_64
