Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262207AbVBBCfN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262207AbVBBCfN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 21:35:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262212AbVBBCfN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 21:35:13 -0500
Received: from rproxy.gmail.com ([64.233.170.199]:45632 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262207AbVBBCfA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 21:35:00 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=o61fxOzAmBRR7amNeqS/qpQZYImPcdog67RHMNtr6TuEMgsLeBMucOTioy2gZ6nj89Y+qlCIwNTk+tmA30v31pt4RK9ZTPfH3Y/E0BF8EGLz1wgd1GF7ZqXdhb5InE2BLEXVUzzP7FPR5upHd/80T/FvDrEM09Pw1ySVNApSZww=
Message-ID: <9871ee5f05020118343effed7@mail.gmail.com>
Date: Tue, 1 Feb 2005 21:34:59 -0500
From: Timothy Miller <theosib@gmail.com>
Reply-To: Timothy Miller <theosib@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: ALSA HELP: Crackling and popping noises with via82xx
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've mentioned this problem before.  It seemed to go away around the
2.6.8 timeframe, but when I started using 2.6.9, it came back.   I'm
using 2.6.10, and it's still happening.

Basically, I get random poppling and crackling noises out of my
speakers.  Sometimes it's silent, and sometimes, it crackles and pops
for minutes at a time.  It's really disturbing, really, because it
happens suddenly, sometimes very loudly, and usually when I'm
concentrating.  :)

Normal sound playback works, but sometimes, it's distorted.  Also note
that I'm having the same problems both on my KT400 board (Athlon XP)
at home and worse problems with the same driver on a Dell box at work
with a P4 and a chipset I'll have to tell you about when I get to work
if you need to know.

Here's some background from my earlier posts:

http://lkml.org/lkml/2004/7/5/2
http://www.ussg.iu.edu/hypermail/linux/kernel/0407.2/0064.html
http://forums.gentoo.org/viewtopic.php?t=193711

I have an ABIT KD7, which has the KT400 chipset. I have determined
that the applicable
driver is "via82xx".  Note that the links mention MIDI.  Don't get
confused by that.  I care ONLY about getting rid of the noises.

lspci says:

0000:00:00.0 Host bridge: VIA Technologies, Inc. VT8377 [KT400/KT600
AGP] Host Bridge
0000:00:01.0 PCI bridge: VIA Technologies, Inc. VT8235 PCI Bridge
0000:00:0b.0 RAID bus controller: 3ware Inc 3ware Inc 3ware
7xxx/8xxx-series PATA/SATA-RAID (rev 01)
0000:00:0d.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro
100] (rev 0c)
0000:00:10.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB
1.1 Controller (rev 80)
0000:00:10.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB
1.1 Controller (rev 80)
0000:00:10.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB
1.1 Controller (rev 80)
0000:00:10.3 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 82)
0000:00:11.0 ISA bridge: VIA Technologies, Inc. VT8235 ISA Bridge
0000:00:11.1 IDE interface: VIA Technologies, Inc.
VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06)
0000:00:11.5 Multimedia audio controller: VIA Technologies, Inc.
VT8233/A/8235/8237 AC97 Audio Controller (rev 50)
0000:00:12.0 Ethernet controller: VIA Technologies, Inc. VT6102
[Rhine-II] (rev 74)
0000:01:00.0 VGA compatible controller: ATI Technologies Inc RV280
[Radeon 9200 SE] (rev 01)
0000:01:00.1 Display controller: ATI Technologies Inc RV280 [Radeon
9200 SE] (Secondary) (rev 01)


Here are the uncommented bits of /etc/modules.d/alsa:

options snd  device_mode=0666
alias snd-card-0 snd-via82xx
alias sound-slot-0 snd-card-0
alias sound-service-0-0 snd-mixer-oss
alias sound-service-0-1 snd-seq-oss
alias sound-service-0-3 snd-pcm-oss
alias sound-service-0-8 snd-seq-oss
alias sound-service-0-12 snd-pcm-oss
alias /dev/mixer snd-mixer-oss
alias /dev/dsp snd-pcm-oss
alias /dev/midi snd-seq-oss
options snd cards_limit=1


Please help!
