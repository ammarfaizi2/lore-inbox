Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932491AbVJYX7e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932491AbVJYX7e (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Oct 2005 19:59:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932492AbVJYX7d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Oct 2005 19:59:33 -0400
Received: from zproxy.gmail.com ([64.233.162.201]:24490 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932491AbVJYX7d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Oct 2005 19:59:33 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=RbdNs5Jn9vI3mvy8TMla71+kDaK90wZNHmprfNeOGhuRJBlunm8A72iLUzmmxUuGT9mZRLq9jJexZOVtagtTV1ekWF84pwbdWmwGSbcvj5euq17KLCrRr53IC5UjZxRsyyOskiOcpY891i7hfJ0yjBowj3T82RDpbsV27RN+l5g=
Message-ID: <435EC6CB.5020804@gmail.com>
Date: Tue, 25 Oct 2005 18:59:07 -0500
From: John Benes <smartcat99s@gmail.com>
User-Agent: Thunderbird 1.5 (Windows/20051025)
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Call for PIIX4 chipset testers
References: <Pine.LNX.4.64.0510251042420.10477@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0510251042420.10477@g5.osdl.org>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 	Intel Corporation 82371AB/EB/MB PIIX4 ISA
> 
> can you please test out this patch and report what it says in dmesg?
> Preferably
> together with the output of "cat /proc/ioport" and "/sbin/lspci -xxx".

>From a virtual machine running:
Linux pompeii 2.6.14-rc5-ck1-rome #3 PREEMPT Tue Oct 25 18:07:02 CDT
2005 i686 GNU/Linux


dmesg:
PCI quirk: region 1000-103f claimed by PIIX4 ACPI
PCI quirk: region 1040-105f claimed by PIIX4 SMB
PIIX4: IDE controller at PCI slot 0000:00:07.1
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later


/proc/iopoorts:
0000-001f : dma1
0020-0021 : pic1
0040-0043 : timer0
0050-0053 : timer1
0060-006f : keyboard
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
02f8-02ff : serial
0376-0376 : ide1
03c0-03df : vga+
  03c0-03df : vesafb
03f8-03ff : serial
0cf8-0cff : PCI conf1
1000-103f : 0000:00:07.3
  1000-103f : motherboard
    1000-1003 : PM1a_EVT_BLK
    1004-1005 : PM1a_CNT_BLK
    1008-100b : PM_TMR
    100c-100f : GPE0_BLK
    1010-1015 : ACPI CPU throttle
1040-105f : 0000:00:07.3
  1040-104f : motherboard
1060-107f : 0000:00:07.2
  1060-107f : uhci_hcd
1080-10ff : 0000:00:10.0
1400-147f : 0000:00:11.0
  1400-141f : pcnet32_probe_pci
1480-14bf : 0000:00:12.0
14c0-14cf : 0000:00:0f.0
14d0-14df : 0000:00:07.1
  14d8-14df : ide1

lspci -xxx:
0000:00:07.0 ISA bridge: Intel Corporation 82371AB/EB/MB PIIX4 ISA (rev 08)
00: 86 80 10 71 07 00 80 02 08 00 01 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 ad 15 76 19
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 10 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 80 8b 8a 89 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:00:07.1 IDE interface: Intel Corporation 82371AB/EB/MB PIIX4 IDE
(rev 01)
00: 86 80 11 71 05 00 80 02 01 8a 01 01 00 40 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: d1 14 00 00 00 00 00 00 00 00 00 00 ad 15 76 19
30: 00 00 00 00 00 00 00 00 00 00 00 00 ff 00 00 00
40: 00 00 07 a3 00 00 00 00 04 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:00:07.2 USB Controller: Intel Corporation 82371AB/EB/MB PIIX4 USB
00: 86 80 12 71 05 00 80 02 00 00 03 0c 00 40 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 61 10 00 00 00 00 00 00 00 00 00 00 ad 15 76 19
30: 00 00 00 00 00 00 00 00 00 00 00 00 09 04 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 10 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 20 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:00:07.3 Bridge: Intel Corporation 82371AB/EB/MB PIIX4 ACPI (rev 08)
00: 86 80 13 71 01 00 80 02 08 00 80 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 ad 15 76 19
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 01 10 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 50 05 00 00 00 00 00 77 00 00 02 00 00 00 80
60: 00 00 00 22 00 fe 21 98 00 00 00 00 00 00 00 00
70: 00 00 00 00 2e 00 01 00 00 00 00 00 2e 00 01 00
80: 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 41 10 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
