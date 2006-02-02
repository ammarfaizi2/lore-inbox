Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423405AbWBBJYL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423405AbWBBJYL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 04:24:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423411AbWBBJYL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 04:24:11 -0500
Received: from mail.charite.de ([160.45.207.131]:38102 "EHLO mail.charite.de")
	by vger.kernel.org with ESMTP id S1423405AbWBBJYK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 04:24:10 -0500
Date: Thu, 2 Feb 2006 10:23:58 +0100
From: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
To: linux-kernel@vger.kernel.org
Subject: 2.6.16-rc1-mm4: APIC error on CPU0: 40(40)
Message-ID: <20060202092358.GF821@charite.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I'm using 2.6.16-rc1-mm4 on a Medion Laptop. lame me for crap hardware.

Recent vanilla kernels were only usable when I gave them the boot options
"irqpoll noapic lapic", and even then I had problems with messages like:

Jan 25 20:04:37 knarzkiste kernel: irq 11: nobody cared (try booting with the "irqpoll" option)

With 2.6.16-rc1-mm3 and 2.6.16-rc1-mm4 I was able to boot the box with
no additional boot options and things seem to be working smoothly for
the first time ever.

Now on the other hand, I'm getting these:

Feb  3 06:54:15 knarzkiste kernel: APIC error on CPU0: 40(40)
Feb  3 07:06:43 knarzkiste kernel: APIC error on CPU0: 40(40)
Feb  3 08:21:16 knarzkiste kernel: APIC error on CPU0: 40(40)
Feb  3 09:50:49 knarzkiste kernel: APIC error on CPU0: 40(40)
Feb  3 09:52:18 knarzkiste kernel: APIC error on CPU0: 40(40)
Feb  3 10:30:38 knarzkiste kernel: set_rtc_mmss: can't update from 59 to 0
Feb  3 10:31:00 knarzkiste kernel: set_rtc_mmss: can't update from 59 to 1
Feb  3 10:31:01 knarzkiste kernel: set_rtc_mmss: can't update from 59 to 1
Feb  3 12:30:10 knarzkiste kernel: set_rtc_mmss: can't update from 59 to 0
Feb  3 13:07:33 knarzkiste kernel: APIC error on CPU0: 40(40)
Feb  3 14:27:13 knarzkiste kernel: APIC error on CPU0: 40(40)
Feb  3 14:30:04 knarzkiste kernel: set_rtc_mmss: can't update from 59 to 0
Feb  3 15:30:27 knarzkiste kernel: set_rtc_mmss: can't update from 59 to 0
Feb  3 16:42:44 knarzkiste kernel: APIC error on CPU0: 40(40)
Feb  3 16:45:30 knarzkiste kernel: APIC error on CPU0: 40(40)
Feb  3 17:14:01 knarzkiste kernel: APIC error on CPU0: 40(40)
Feb  3 17:48:09 knarzkiste kernel: APIC error on CPU0: 40(40)
Feb  3 18:30:44 knarzkiste kernel: set_rtc_mmss: can't update from 59 to 0
Feb  3 19:30:30 knarzkiste kernel: set_rtc_mmss: can't update from 59 to 0

# cat /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 15
model           : 36
model name      : AMD Turion(tm) 64 Mobile Technology ML-30
stepping        : 2
cpu MHz         : 1592.107
cache size      : 1024 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 syscall nx mmxext fxsr_opt lm 3dnowext 3dnow constant_tsc pni lahf_lm ts fid vid ttp tm stc
bogomips        : 3193.01

# lspci
0000:00:00.0 Host bridge: ATI Technologies Inc RS480 Host Bridge (rev 10)
0000:00:01.0 PCI bridge: ATI Technologies Inc RS480 PCI Bridge
0000:00:13.0 USB Controller: ATI Technologies Inc IXP SB400 USB Host Controller
0000:00:13.1 USB Controller: ATI Technologies Inc IXP SB400 USB Host Controller
0000:00:13.2 USB Controller: ATI Technologies Inc IXP SB400 USB2 Host Controller
0000:00:14.0 SMBus: ATI Technologies Inc IXP SB400 SMBus Controller (rev 10)
0000:00:14.1 IDE interface: ATI Technologies Inc Standard Dual Channel PCI IDE Controller ATI
0000:00:14.3 ISA bridge: ATI Technologies Inc IXP SB400 PCI-ISA Bridge
0000:00:14.4 PCI bridge: ATI Technologies Inc IXP SB400 PCI-PCI Bridge
0000:00:14.5 Multimedia audio controller: ATI Technologies Inc IXP SB400 AC'97 Audio Controller (rev 01)
0000:00:14.6 Modem: ATI Technologies Inc ATI SB400 - AC'97 Modem Controller (rev 01)
0000:00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] HyperTransport Technology Configuration
0000:00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Address Map
0000:00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] DRAM Controller
0000:00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Miscellaneous Control
0000:01:05.0 VGA compatible controller: ATI Technologies Inc ATI Radeon XPRESS 200M 5955 (PCIE)
0000:02:03.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)
0000:02:04.0 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev ac)
0000:02:04.1 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev ac)
0000:02:04.2 FireWire (IEEE 1394): Ricoh Co Ltd R5C552 IEEE 1394 Controller (rev 04)
0000:02:09.0 Network controller: RaLink RT2500 802.11g Cardbus/mini-PCI (rev 01)
0000:07:00.0 Multimedia controller: Philips Semiconductors SAA7134 Video Broadcast Decoder (rev 01)

-- 
Ralf Hildebrandt (i.A. des IT-Zentrums)         Ralf.Hildebrandt@charite.de
Charite - Universitätsmedizin Berlin            Tel.  +49 (0)30-450 570-155
Gemeinsame Einrichtung von FU- und HU-Berlin    Fax.  +49 (0)30-450 570-962
IT-Zentrum Standort CBF                 send no mail to spamtrap@charite.de
