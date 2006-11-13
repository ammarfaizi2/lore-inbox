Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753568AbWKMA4e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753568AbWKMA4e (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Nov 2006 19:56:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753744AbWKMA4e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Nov 2006 19:56:34 -0500
Received: from ns2.g-housing.de ([81.169.133.75]:64969 "EHLO mail.g-house.de")
	by vger.kernel.org with ESMTP id S1753568AbWKMA4d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Nov 2006 19:56:33 -0500
Date: Mon, 13 Nov 2006 00:56:24 +0000 (GMT)
From: Christian Kujau <evil@g-house.de>
X-X-Sender: evil@sheep.housecafe.de
To: Arjan van de Ven <arjan@infradead.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: OOM in 2.6.19-rc*
In-Reply-To: <1163322915.3293.83.camel@laptopd505.fenrus.org>
Message-ID: <Pine.LNX.4.64.0611130052350.17658@sheep.housecafe.de>
References: <Pine.LNX.4.64.0611111318230.1247@sheep.housecafe.de>
 <1163322915.3293.83.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oh dear, Murphy hits again....or was it Heisenberg? Since I posted to 
lkml the daily OOM killings went away. I'm running 2.6.19-rc5-mm1 right 
now and no OOM situation today..phew.

On Sun, 12 Nov 2006, Arjan van de Ven wrote:
> which modules/drivers do you use? Maybe there's a less commonly used on
> in there that we could look at.

Thanks for your reply (all your replies!), FWIW:

# lsmod
Module                  Size  Used by
dm_crypt               12304  0
dm_mod                 55280  1 dm_crypt
powernow_k8            10584  0
freq_table              4168  1 powernow_k8
w83627hf               28944  0
hwmon_vid               3648  1 w83627hf
eeprom                  6992  0
i2c_dev                 7368  0
i2c_isa                 5184  1 w83627hf
ide_cd                 39520  0
cdrom                  37160  1 ide_cd
ide_disk               14272  0
ata_generic             6468  0
libata                106920  1 ata_generic
qla2xxx               154668  0
firmware_class          9216  1 qla2xxx
snd_intel8x0           32872  2
snd_ac97_codec        108440  1 snd_intel8x0
snd_ac97_bus            2816  1 snd_ac97_codec
ohci1394               33032  0
ieee1394               93168  1 ohci1394
snd_pcm_oss            41440  0
snd_mixer_oss          16512  1 snd_pcm_oss
snd_pcm                74828  3 snd_intel8x0,snd_ac97_codec,snd_pcm_oss
snd_timer              22536  1 snd_pcm
k8temp                  5440  0
scsi_transport_fc      39492  1 qla2xxx
i2c_nforce2             5696  0
i2c_core               20056  5 w83627hf,eeprom,i2c_dev,i2c_isa,i2c_nforce2
amd74xx                15344  0 [permanent]
ide_core              130300  3 ide_cd,ide_disk,amd74xx
snd                    56680  10 snd_intel8x0,snd_ac97_codec,snd_pcm_oss,snd_mixer_oss,snd_pcm,snd_timer
soundcore               7648  1 snd
hwmon                   3168  2 w83627hf,k8temp
snd_page_alloc          8464  2 snd_intel8x0,snd_pcm

# uname -a
Linux prinz64 2.6.19-rc5-mm1 #4 PREEMPT Sat Nov 11 16:02:25 GMT 2006 x86_64 GNU/Linux


Christian.
-- 
BOFH excuse #21:

POSIX compliance problem
