Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284124AbRLRPzz>; Tue, 18 Dec 2001 10:55:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284136AbRLRPzq>; Tue, 18 Dec 2001 10:55:46 -0500
Received: from lacrosse.corp.redhat.com ([12.107.208.154]:24723 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S284124AbRLRPzf>; Tue, 18 Dec 2001 10:55:35 -0500
Message-ID: <3C1F66F4.6080903@redhat.com>
Date: Tue, 18 Dec 2001 10:55:32 -0500
From: Doug Ledford <dledford@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6+) Gecko/20011211
X-Accept-Language: en-us
MIME-Version: 1.0
To: Ulrich Leodolter <ulrich@lab1.psy.univie.ac.at>
CC: linux-kernel@vger.kernel.org
Subject: Re: i810_audio.c v0.11 kernel lockup
In-Reply-To: <Pine.LNX.4.33.0112171427150.1299-100000@lab20.brl.univie.ac.at>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ulrich Leodolter wrote:

> problem:	kernel lockup when apps tries to play sound
> kernel:		linux-2.4.17-pre8
> i810_audio.c:	version 0.11 from 
> http://people.redhat.com/dledford/i810_audio.c.gz


The 0.11 version had a known lockup issue.  The current driver on my web 
site is 0.12 (and has been since very shortly after I announced the 0.11 
version I think).  Anyway, please retry with that driver and see if things work.


> processor:	Intel Pentium4 1.5GHz
> mainboard:	Luck Star P4A845S (http://www.lucky-star.com.tw)
> 
> i have compiled the driver with all DEBUG enabled,
> here are the last kernel messages before the kernel dies:
> 
> Dec 17 14:22:22 lab20 kernel: Intel 810 + AC97 Audio, version 0.11, 10:33:03 Dec 17 2001
> Dec 17 14:22:22 lab20 kernel: PCI: Found IRQ 11 for device 00:1f.5
> Dec 17 14:22:22 lab20 kernel: PCI: Sharing IRQ 11 with 00:1f.3
> Dec 17 14:22:22 lab20 kernel: PCI: Setting latency timer of device 00:1f.5 to 64
> Dec 17 14:22:22 lab20 kernel: i810: Intel ICH2 found at IO 0xe000 and 0xdc00, IRQ 11
> Dec 17 14:22:22 lab20 kernel: i810_audio: Audio Controller supports 6 channels.
> Dec 17 14:22:22 lab20 kernel: ac97_codec: AC97 Audio codec, id: 0x414c:0x4710 (ALC200/200P)
> Dec 17 14:22:22 lab20 kernel: i810_audio: AC'97 codec 0 supports AMAP, total channels = 2
> Dec 17 14:22:22 lab20 kernel: i810_audio: called i810_set_dac_rate : asked for 48000, got 48000
> Dec 17 14:22:22 lab20 kernel: i810_audio: allocated 65536 (order = 4) bytes at ee980000
> Dec 17 14:22:22 lab20 kernel: i810_audio: prog_dmabuf, sample rate = 48000, format = 3,
> Dec 17 14:22:22 lab20 kernel: ^Inumfrag = 32, fragsize = 2048 dmasize = 65536
> Dec 17 14:22:22 lab20 kernel: i810_audio: 9584 bytes in 50 milliseconds
> Dec 17 14:22:43 lab20 kernel: i810_audio: called i810_set_dac_rate : asked for 8000, got 8000
> Dec 17 14:22:43 lab20 kernel: i810_audio: i810_ioctl, arg=0x10, cmd=SNDCTL_DSP_SETFMT
> Dec 17 14:22:43 lab20 kernel: i810_audio: i810_ioctl, arg=0x0, cmd=SNDCTL_DSP_STEREO
> Dec 17 14:22:43 lab20 kernel: i810_audio: i810_ioctl, arg=0x5622, cmd=SNDCTL_DSP_SPEED
> Dec 17 14:25:06 lab20 syslogd 1.3-3: restart.
> 
> 
> 



-- 

  Doug Ledford <dledford@redhat.com>  http://people.redhat.com/dledford
       Please check my web site for aic7xxx updates/answers before
                       e-mailing me about problems

