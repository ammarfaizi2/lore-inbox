Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281156AbRKEOR0>; Mon, 5 Nov 2001 09:17:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281158AbRKEORQ>; Mon, 5 Nov 2001 09:17:16 -0500
Received: from as3-4-2.bi.s.bonet.se ([217.215.34.150]:41385 "EHLO
	zodiac.debian.net") by vger.kernel.org with ESMTP
	id <S281156AbRKEORA>; Mon, 5 Nov 2001 09:17:00 -0500
From: Mikael Hedin <mikael.hedin@irf.se>
To: linux-kernel@vger.kernel.org
Reply-to: mikael.hedin@irf.se, linux-kernel@vger.kernel.org
Subject: Disk corruption with VIA KT266 chipset
X-Mailer: VM 6.92 under 21.4 (patch 4) "Artificial Intelligence" XEmacs Lucid
Message-Id: <E160kYc-0004Ol-00@zodiac.debian.net>
Date: Mon, 05 Nov 2001 15:16:58 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Please cc me on replies, I only read the list archives]

Hi,

I have a Soltek KT75DRV motherboard, with the VIA KT266 chipset, and
in particular the VIA 8233 southbridge.  I use two IDE disks (one
ATA100, one ATA33) with UDMA enabled and stock linux-2.4.13.  

With heavy disk use, I get random corruptions.  E.g. "cp -a /usr /mnt;
diff -ruq /usr /mnt" shows a couple of files that differ.  OTOH, "cp
-a linux linux2; diff -ruq linux linux2" use to run fine as many times
as you like.  Thus I suspect the error is prone to show up on large
files transfers over DMA.

I talked to Vojtech Pavlik, and we concluded the problem is the
transfer between the VIA8233 and the memory (memtest86 show no
errors.)

I've replaced the motherboard once, without much difference, so it's
probably not plain broken.

Not using DMA solves the problem, but of course it's not what I want,
I get hdparm -t reading around 2 MB/s :-(

I'd be happy to try out any solution, I already had to reinstall the
system a couple of times due to this.

Regards,

Micce

BTW The sound (ALSA driver) of this board is horrible, but that might
be as intended by Soltek;)

-- 
Mikael Hedin, MSc                   +46 (0)980 79176
Swedish Institute of Space Physics  +46 (0)8 344979 (home)
Box 812, S-981 28 KIRUNA, Sweden    +46 (0)70 5891533 (mobile)
[gpg key fingerprint = 387F A8DB DC2A 50E3 FE26  30C4 5793 29D3 C01B 2A22]

Nu lubbar vi på fjället hela dan och trivs med det
			Jesse James '71

militia explosion World Trade Center assassination Mossad $400 million
in gold bullion COSCO FSF domestic disruption Monica Lewinsky genetic
security jihad terrorist Area 51
