Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316343AbSETUIa>; Mon, 20 May 2002 16:08:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316346AbSETUI3>; Mon, 20 May 2002 16:08:29 -0400
Received: from nycsmtp2out.rdc-nyc.rr.com ([24.29.99.227]:21924 "EHLO
	nycsmtp2out.rdc-nyc.rr.com") by vger.kernel.org with ESMTP
	id <S316343AbSETUI1>; Mon, 20 May 2002 16:08:27 -0400
Message-ID: <3CE9567A.7060804@linuxhq.com>
Date: Mon, 20 May 2002 16:03:06 -0400
From: John Weber <john.weber@linuxhq.com>
Organization: Linux Headquarters
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc2) Gecko/20020510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Linux 2.5.16 and ALSA
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have never been able to get ALSA sound working with linux 2.5...
sound works perfectly with the OSS YMFPCI driver enabled, and though I
have been told that the code is the same across both ALSA and OSS I have 
never been able to get ALSA working.

I have unmuted (of course), I have OSS API emulation enabled, I see 
interrupts being fired, apparently the ALSA subsystem can see the card 
(some /proc/asound/* output below).  I have also looked at the settings 
with the ALSA utilities, to double-check that ALSA is in fact 
recognizing... everything YMF744, AC97, etc checks out.

My applications just look like they are playing sound, while only a 
crack comes out of my speakers every once in a while.

Can anyone give me some pointers on how best to debug my problem?  I 
have enabled sound debug and verbose printk in the kernel, but I'm not 
clear on how to use the debug facility.

[root@boolean john]# cat /proc/asound/oss/sndstat
Sound Driver:3.8.1a-980706 (ALSA v0.9.0rc1 emulation code)
Kernel: Linux boolean 2.5.16-alsa #2 Mon May 20 14:56:21 EDT 2002 i686
Config options: 0

Installed drivers:
Type 10: ALSA emulation

Card config:
Yamaha DS-XG PCI (YMF744) at 0xc8826000, irq 11

Audio devices:
0: YMFPCI (DUPLEX)

Synth devices:
0: OPL3 FM

Midi devices:
0: MPU-401 (UART)

Timers:
7: system timer

Mixers:
0: mixer00

[root@boolean john]# cat /proc/interrupts |grep 11:
  11:      15128          XT-PIC  YMFPCI, Toshiba America Info Systems 
ToPIC95 PCI to Cardbus Bridge with ZV Support, Toshiba America Info 
Systems ToPIC95 PCI to Cardbus Bridge with ZV Support (#2)


  -o)  J o h n   W e b e r
  /\\ john.weber@linuxhq.com
_\/v http://www.linuxhq.com/people/weber/

