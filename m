Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129136AbQKSE2o>; Sat, 18 Nov 2000 23:28:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129659AbQKSE2Y>; Sat, 18 Nov 2000 23:28:24 -0500
Received: from m-2-245.cable.hbciexpress.net ([63.239.62.245]:516 "HELO
	minnesota.bauerschmidt.eu.org") by vger.kernel.org with SMTP
	id <S129136AbQKSE2N>; Sat, 18 Nov 2000 23:28:13 -0500
Date: Sat, 18 Nov 2000 21:30:18 -0600
From: Roland Bauerschmidt <rb@debian.org>
To: linux-kernel@vger.kernel.org
Cc: Scott Murray <scottm@interlog.com>
Subject: trouble with OPL3-SAx soundchip
Message-ID: <20001118213018.A443@minnesota.bauerschmidt.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I am having trouble with the soundcard of my Thinkpad i1400, which has the
following soundchip:

roland@minnesota:~% cat /proc/isapnp | grep '^Card 1'
Card 1 'YMH0800:YAMAHA OPL3-SAx Audio System' PnP version 1.0

If have used both 2.2.17 with ALSA and 2.4.0-test11-pre7 with the OSS
module, both with the opl3sa2 modules. The problems I encounter are pretty
weird, and my only guess would be that there is something wrong in the
kernel drivers.

Using 2.2.17 and ALSA:
I can play MP3 files with mp3blaster or alsaplayer-oss without any problems.
If I use alsaplayer-alsa or xmms (both alsa and oss plugin), the notebook
freezes after playing round about 4 seconds. I just modprobed the
snd-card-opl3sa2 and snd-pcm-oss.

Using 2.4.0-test11-pre7:
I can load the modules successfully. Playing anything longer than a few
seconds, with any player, freezes the box. I loaded the modules with the
following parameters: irq=11 dma=0 dma2=3 io=0x220 mss_io=0x530

I don't think that it is hardware problem as it works in some circumstances
(i.e. 2.2.17+ALSA and mp3blaster). I am using Debian unstable here. The ALSA
Version I used was 0.5.8b. There were no information about this in any
logfiles. I would be glad to help you, to debug this further.

Roland


I got the parameters from the following:

roland@minnesota:~% head -n 6 /proc/isapnp
Card 1 'YMH0800:YAMAHA OPL3-SAx Audio System' PnP version 1.0
  Logical device 0 'YMH0021:Unknown'
    Device is active
    Active port 0x220,0x530,0x388,0x330,0x370
    Active IRQ 11 [0x2]
    Active DMA 0,3

-- 
Roland Bauerschmidt <rb@debian.org>
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
