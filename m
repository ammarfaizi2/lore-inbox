Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263423AbTEITYm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 15:24:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263426AbTEITYm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 15:24:42 -0400
Received: from 213-99-252-157.uc.nombres.ttd.es ([213.99.252.157]:27279 "EHLO
	dardhal.mired.net") by vger.kernel.org with ESMTP id S263423AbTEITYk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 15:24:40 -0400
Date: Fri, 9 May 2003 21:37:11 +0200
From: Jose Luis Domingo Lopez <linux-kernel@24x7linux.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: ALSA busted in 2.5.69
Message-ID: <20030509193711.GA6189@localhost>
Mail-Followup-To: Linux Kernel <linux-kernel@vger.kernel.org>
References: <1052437191.1205.4.camel@torrey.et.myrio.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1052437191.1205.4.camel@torrey.et.myrio.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, 08 May 2003, at 16:39:51 -0700,
Torrey Hoffman wrote:

> ALSA isn't working for me in 2.5.69.  It appears to be because
> /proc/asound/dev is missing the control devices.
> 
I have been using ALSA for my soundcards for some days, and today I
booted into 2.5.69, and everything still works.

I used the same .config file in both kernel versions, and did a "make
oldconfig" to adapt the older to the newer version.

> lsmod says I have:
> 
Module                  Size  Used by
cls_u32                 6596  1 [unsafe]
sch_ingress             3264  1 [unsafe]
ipt_LOG                 4416  1 
ipt_limit               1728  1 
ipt_state               1408  1 
iptable_filter          2112  1 
ipt_MASQUERADE          2816  1 
iptable_nat            20052  2 ipt_MASQUERADE
ip_conntrack           24012  3 ipt_state,ipt_MASQUERADE,iptable_nat
ip_tables              14208  6 ipt_LOG,ipt_limit,ipt_state,iptable_filter,ipt_MASQUERADE,iptable_nat
ppp_deflate             5056  0 [unsafe]
zlib_deflate           21240  1 ppp_deflate
zlib_inflate           21056  1 ppp_deflate
bsd_comp                5376  0 [unsafe]
ppp_async               9280  1 [unsafe]
tuner                  14340  1 [unsafe]
tvaudio                19264  0 
bttv                   92384  1 
video_buf              15616  1 bttv
i2c_algo_bit            9288  1 bttv
v4l2_common             3776  1 bttv
videodev                8192  1 bttv
ppp_generic            24200  5 ppp_deflate,bsd_comp,ppp_async
slhc                    6336  1 ppp_generic
parport_pc             18784  1 
lp                      8480  0 
parport                35456  2 parport_pc,lp
snd_seq_oss            33408  0 
snd_seq_midi_event      5632  1 snd_seq_oss
snd_seq                54544  4 snd_seq_oss,snd_seq_midi_event
snd_pcm_oss            57220  0 
snd_mixer_oss          18880  4 snd_pcm_oss
snd_via82xx            16260  1 
snd_ymfpci             47296  2 
snd_pcm                89536  3 snd_pcm_oss,snd_via82xx,snd_ymfpci
snd_ac97_codec         46532  2 snd_via82xx,snd_ymfpci
snd_opl3_lib            9728  1 snd_ymfpci
snd_timer              21632  3 snd_seq,snd_pcm,snd_opl3_lib
snd_hwdep               7360  1 snd_opl3_lib
snd_page_alloc          8388  3 snd_via82xx,snd_ymfpci,snd_pcm
snd_mpu401_uart         5952  2 snd_via82xx,snd_ymfpci
snd_rawmidi            20736  1 snd_mpu401_uart
snd_seq_device          6916  4 snd_seq_oss,snd_seq,snd_opl3_lib,snd_rawmidi
md5                     3712  1 
snd                    49220  15 snd_seq_oss,snd_seq_midi_event,snd_seq,snd_pcm_oss,snd_mixer_oss,snd_via82xx,snd_ymfpci,snd_pcm,snd_ac97_codec,snd_opl3_lib,snd_timer,snd_hwdep,snd_mpu401_uart,snd_rawmidi,snd_seq_device
soundcore               6528  2 bttv,snd
ipv6                  197792  7 
8139too                18176  1 
mii                     4096  1 8139too
crc32                   3840  1 8139too
xfs                   541108  1 
dm_mod                 31680  6 
md                     40576  0 
i2c_isa                 1600  0 
i2c_core               18820  5 tuner,tvaudio,bttv,i2c_algo_bit,i2c_isa
rtc                     9572  0 

> but "ls -l /proc/asound/dev" shows only:
>

total 0
crw-rw-rw-    1 root     root     116,   0 2003-05-09 21:36 controlC0
crw-rw-rw-    1 root     root     116,  32 2003-05-09 21:36 controlC1
crw-rw-rw-    1 root     root     116,  24 2003-05-09 21:36 pcmC0D0c
crw-rw-rw-    1 root     root     116,  16 2003-05-09 21:36 pcmC0D0p
crw-rw-rw-    1 root     root     116,  17 2003-05-09 21:36 pcmC0D1p
crw-rw-rw-    1 root     root     116,  18 2003-05-09 21:36 pcmC0D2p
crw-rw-rw-    1 root     root     116,  27 2003-05-09 21:36 pcmC0D3c
crw-rw-rw-    1 root     root     116,  56 2003-05-09 21:36 pcmC1D0c
crw-rw-rw-    1 root     root     116,  48 2003-05-09 21:36 pcmC1D0p
crw-rw-rw-    1 root     root     116,  49 2003-05-09 21:36 pcmC1D1p
crw-rw-rw-    1 root     root     116,   1 2003-05-09 21:36 seq
crw-rw-rw-    1 root     root     116,  33 2003-05-09 21:36 timer

Hope this helps.

-- 
Jose Luis Domingo Lopez
Linux Registered User #189436     Debian Linux Sid (Linux 2.5.69)
