Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262581AbTI1N7N (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Sep 2003 09:59:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262583AbTI1N7N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Sep 2003 09:59:13 -0400
Received: from mail1.cc.huji.ac.il ([132.64.1.17]:46561 "EHLO
	mail1.cc.huji.ac.il") by vger.kernel.org with ESMTP id S262581AbTI1N7G
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Sep 2003 09:59:06 -0400
Message-ID: <3F76E927.7030809@mscc.huji.ac.il>
Date: Sun, 28 Sep 2003 16:59:03 +0300
From: Voicu Liviu <pacman@mscc.huji.ac.il>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5b) Gecko/20030913 Thunderbird/0.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Sound bug ?!
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by Vexira MailArmor (version: 2.0.1.14; VAE: 6.21.0.1; VDF: 6.21.0.53; host: mail1.cc.huji.ac.il)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sound bug ?!
I also have seen that this 2.6-test6 is missing a few sound cards(like 
Ensoniq ES1371) so I was forced to use alsa!

starshooter liviu # uname -a
Linux starshooter 2.6.0-test6 #1 Sun Sep 28 15:29:07 IDT 2003 i686 
Pentium II (Deschutes) GenuineIntel GNU/Linux

starshooter liviu # lspci |grep audio
00:09.0 Multimedia audio controller: Ensoniq ES1371 [AudioPCI-97] (rev 08)


starshooter linux # cat .config|grep SND
CONFIG_SND=m
CONFIG_SND_SEQUENCER=m
CONFIG_SND_SEQ_DUMMY=m
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=m
CONFIG_SND_PCM_OSS=m
CONFIG_SND_SEQUENCER_OSS=y
CONFIG_SND_DUMMY=m
CONFIG_SND_VIRMIDI=m


starshooter liviu # /etc/init.d/alsasound start
 * Loading ALSA drivers...
 * Loading: snd-pcm-oss
WARNING: Error inserting snd 
(/lib/modules/2.6.0-test6/kernel/sound/acore/snd.o): Invalid module format
WARNING: Error inserting snd_mixer_oss 
(/lib/modules/2.6.0-test6/kernel/sound/acore/oss/snd-mixer-oss.o): 
Invalid module format
WARNING: Error inserting snd_timer 
(/lib/modules/2.6.0-test6/kernel/sound/acore/snd-timer.o): Invalid 
module format
WARNING: Error inserting snd_page_alloc 
(/lib/modules/2.6.0-test6/kernel/sound/acore/snd-page-alloc.o): Invalid 
module formatWARNING: Error inserting snd_pcm 
(/lib/modules/2.6.0-test6/kernel/sound/acore/snd-pcm.o): Invalid module 
format
FATAL: Error inserting snd_pcm_oss 
(/lib/modules/2.6.0-test6/kernel/sound/acore/oss/snd-pcm-oss.o): Invalid 
module format
 * Loading: snd-ens1371
WARNING: Error inserting snd 
(/lib/modules/2.6.0-test6/kernel/sound/acore/snd.o): Invalid module format
WARNING: Error inserting snd_ac97_codec 
(/lib/modules/2.6.0-test6/kernel/sound/pci/ac97/snd-ac97-codec.o): 
Invalid module format
WARNING: Error inserting snd_timer 
(/lib/modules/2.6.0-test6/kernel/sound/acore/snd-timer.o): Invalid 
module format
WARNING: Error inserting snd_page_alloc 
(/lib/modules/2.6.0-test6/kernel/sound/acore/snd-page-alloc.o): Invalid 
module formatWARNING: Error inserting snd_pcm 
(/lib/modules/2.6.0-test6/kernel/sound/acore/snd-pcm.o): Invalid module 
format
WARNING: Error inserting snd_seq_device 
(/lib/modules/2.6.0-test6/kernel/sound/acore/seq/snd-seq-device.o): 
Invalid module format
WARNING: Error inserting snd_rawmidi 
(/lib/modules/2.6.0-test6/kernel/sound/acore/snd-rawmidi.o): Invalid 
module format
FATAL: Error inserting snd_ens1371 
(/lib/modules/2.6.0-test6/kernel/sound/pci/snd-ens1371.o): Invalid 
module format
 * Running card-dependant scripts
 * ERROR: Failed to load neccessary drivers
 * Restoring Mixer Levels
cat: /proc/asound/cards: No such file or 
directory                                                                     
[ ok ]
starshooter liviu #

Any clue please?
Thanks

