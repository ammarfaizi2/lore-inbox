Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314584AbSGFPpa>; Sat, 6 Jul 2002 11:45:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315468AbSGFPp3>; Sat, 6 Jul 2002 11:45:29 -0400
Received: from tartu.cyber.ee ([193.40.6.68]:33810 "EHLO tartu.cyber.ee")
	by vger.kernel.org with ESMTP id <S314584AbSGFPp2>;
	Sat, 6 Jul 2002 11:45:28 -0400
From: Meelis Roos <mroos@linux.ee>
To: linux-kernel@vger.kernel.org
Subject: Re: Bttv errors with onboard video.
In-Reply-To: <sd255cb2.030@GroupWise>
User-Agent: tin/1.5.12-20020227 ("Toxicity") (UNIX) (Linux/2.4.18 (i586))
Message-Id: <E17QrmS-0000uM-00@roos.tartu-labor>
Date: Sat, 06 Jul 2002 18:47:28 +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

BS> I have a problem where the bttv module will not work in combination with onboard ATI video.  The onboard ATI video card works fine but I get nothing from the encoding card. If I use a Cirrus logic PCI video card the bttv module works fine with xawtv. I see these error in my logs. Any ideas?

I use Matrox G400 with bt878 tv card (Chronos Video Shuttle II). bttv0: irq:
SCERR risc_count=1764e020 errors happen about once a week. It looks like they
happen during console switches (fbtv running on tty1 and then switching to tty7
or tty8 where X's run). I have seen this aiee message together with resetting
chip once too but the logs have been rotated for now. But it looked very
similar. No stability problems along with this message.

Once these bttv irq messages were followed by a strange behaviour. I was moving
USB mouse while switching from fbtv to X and then strange symptoms began. First
I found that I can't use the keyboard any more, it does not function.  Switching
consoles and trying things I found that most interrupts had stopped working.
USB mouse worked. Likely the timer too. PS2 keyboard, PCI ethernet and onboard
PCI ide didn't get any interrupts. eth0 gave transmit timeout errors, hda had
DMA timeouts etc. IDE still worked somewhat (polling or something like that),
at least I found these errors from klogd written on the disk after boot.  Clean
boot was not possible since disk reading did not work.

VIA 686a, AMD Duron, 2.4.18,
00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133] (rev 03)
00:01.0 PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP]
00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 22)
00:07.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 10)
00:07.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 10)
00:07.3 USB Controller: VIA Technologies, Inc. UHCI USB (rev 10)
00:07.4 Host bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 30)
00:07.5 Multimedia audio controller: VIA Technologies, Inc. AC97 Audio Controller (rev 20)
00:08.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 (rev 10)
00:09.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 (rev 10)
00:0a.0 Multimedia audio controller: Ensoniq ES1371 [AudioPCI-97] (rev 08)
00:0c.0 Multimedia video controller: Brooktree Corporation Bt878 (rev 11)
00:0c.1 Multimedia controller: Brooktree Corporation Bt878 (rev 11)
01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G400 AGP (rev 05)

-- 
Meelis Roos (mroos@linux.ee)
