Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261874AbTGKLn1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 07:43:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269905AbTGKLn1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 07:43:27 -0400
Received: from wall.ttu.ee ([193.40.254.238]:63759 "EHLO wall.ttu.ee")
	by vger.kernel.org with ESMTP id S261874AbTGKLnZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 07:43:25 -0400
Date: Fri, 11 Jul 2003 14:58:06 +0300 (EET DST)
From: Siim Vahtre <siim@pld.ttu.ee>
To: linux-kernel@vger.kernel.org
Subject: "/proc/asound/dev" gone in 2.5.75
Message-ID: <Pine.GSO.4.53.0307111450440.29900@pitsa.pld.ttu.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I just went from 2.5.70 to 2.5.75 and discovered that sound no longer
works. After short period of investigation, I found that "/dev/snd" is
pointing to "/proc/asound/dev" that now, for some unknown reason, is gone.

'dmesg' shows
> ALSA device list:
>  #0: Intel 82801BA-ICH2 at 0xe800, irq 9

And '/proc/asound' seems  to be there, aswell.
> siim@void:/proc/asound$ ls
> I82801BAICH2@  card0/  cards  devices  oss/  pcm  timers  version

But no 'dev' there. I am also missing those control0* stuff. Strange...

Can anyone please tell me what I'm doing wrong?

I used exactly the same .config for both kernels:

#
# Advanced Linux Sound Architecture
#

CONFIG_SND=y
# CONFIG_SND_SEQUENCER is not set
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=y
CONFIG_SND_PCM_OSS=y
CONFIG_SND_RTCTIMER=y
# CONFIG_SND_VERBOSE_PRINTK is not set
# CONFIG_SND_DEBUG is not set

# PCI devices
CONFIG_SND_INTEL8X0=y

# Open Sound System
# CONFIG_SOUND_PRIME is not set

-- 
Siim Vahtre
