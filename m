Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263355AbTG1MKo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 08:10:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263997AbTG1MKo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 08:10:44 -0400
Received: from gate.perex.cz ([194.212.165.105]:64010 "EHLO gate.perex.cz")
	by vger.kernel.org with ESMTP id S263355AbTG1MKi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 08:10:38 -0400
Date: Mon, 28 Jul 2003 14:24:24 +0200 (CEST)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: perex@pnote.perex-int.cz
To: Linus Torvalds <torvalds@transmeta.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] ALSA update 0.9.6
Message-ID: <Pine.LNX.4.44.0307281421360.28950-100000@pnote.perex-int.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please do a

  bk pull http://linux-sound.bkbits.net/linux-sound

The GNU patch is available at:

  ftp://ftp.alsa-project.org/pub/kernel-patches/alsa-bk-2003-07-28.patch.gz

						Jaroslav

The pull command will update the following files:

 Documentation/sound/alsa/ALSA-Configuration.txt              |   39 
 Documentation/sound/alsa/DocBook/writing-an-alsa-driver.tmpl |   46 
 include/sound/ac97_codec.h                                   |   15 
 include/sound/ad1848.h                                       |   10 
 include/sound/asequencer.h                                   |   11 
 include/sound/asound.h                                       |    3 
 include/sound/core.h                                         |    3 
 include/sound/cs8427.h                                       |    2 
 include/sound/emu10k1.h                                      |    5 
 include/sound/hdsp.h                                         |    1 
 include/sound/info.h                                         |    9 
 include/sound/pcm_oss.h                                      |    4 
 include/sound/seq_midi_event.h                               |   16 
 include/sound/soundfont.h                                    |    1 
 include/sound/version.h                                      |    8 
 include/sound/ymfpci.h                                       |    8 
 scripts/MAKEDEV.snd                                          |  161 ++
 sound/core/control.c                                         |    4 
 sound/core/info.c                                            |   10 
 sound/core/ioctl32/ioctl32.c                                 |    6 
 sound/core/memalloc.c                                        |   81 -
 sound/core/oss/pcm_oss.c                                     |  205 ++
 sound/core/oss/pcm_plugin.c                                  |   23 
 sound/core/oss/pcm_plugin.h                                  |    1 
 sound/core/oss/plugin_ops.h                                  |    2 
 sound/core/oss/rate.c                                        |   22 
 sound/core/oss/route.c                                       |    4 
 sound/core/pcm_lib.c                                         |   13 
 sound/core/pcm_memory.c                                      |   16 
 sound/core/pcm_native.c                                      |   12 
 sound/core/rawmidi.c                                         |   26 
 sound/core/rtctimer.c                                        |   14 
 sound/core/seq/seq_clientmgr.c                               |   56 
 sound/core/seq/seq_midi_event.c                              |   55 
 sound/core/seq/seq_ports.c                                   |   14 
 sound/core/seq/seq_ports.h                                   |    3 
 sound/core/sound.c                                           |   18 
 sound/core/sound_oss.c                                       |    2 
 sound/core/timer.c                                           |   20 
 sound/drivers/dummy.c                                        |   26 
 sound/drivers/opl3/opl3_lib.c                                |    2 
 sound/drivers/opl4/opl4_lib.c                                |    5 
 sound/drivers/opl4/opl4_local.h                              |    2 
 sound/drivers/opl4/opl4_synth.c                              |   22 
 sound/drivers/vx/vx_core.c                                   |    6 
 sound/i2c/cs8427.c                                           |    6 
 sound/i2c/other/ak4xxx-adda.c                                |    2 
 sound/isa/ad1848/ad1848.c                                    |   19 
 sound/isa/ad1848/ad1848_lib.c                                |  108 +
 sound/isa/cmi8330.c                                          |    2 
 sound/isa/cs423x/cs4231_lib.c                                |    4 
 sound/isa/es18xx.c                                           |    2 
 sound/isa/gus/gus_main.c                                     |    4 
 sound/isa/opl3sa2.c                                          |    3 
 sound/isa/sb/emu8000.c                                       |    2 
 sound/isa/sb/sb16.c                                          |   18 
 sound/isa/sscape.c                                           |    2 
 sound/pci/ac97/Makefile                                      |    2 
 sound/pci/ac97/ac97_codec.c                                  |  823 -----------
 sound/pci/ac97/ac97_local.h                                  |   42 
 sound/pci/ac97/ac97_patch.c                                  |  618 ++++++++
 sound/pci/ac97/ac97_patch.h                                  |    3 
 sound/pci/ac97/ac97_proc.c                                   |  295 +++
 sound/pci/ali5451/ali5451.c                                  |   52 
 sound/pci/cmipci.c                                           |    4 
 sound/pci/cs4281.c                                           |   74 
 sound/pci/cs46xx/cs46xx.c                                    |   13 
 sound/pci/cs46xx/cs46xx_lib.c                                |   29 
 sound/pci/emu10k1/emu10k1.c                                  |   10 
 sound/pci/emu10k1/emu10k1_main.c                             |    8 
 sound/pci/emu10k1/emufx.c                                    |   59 
 sound/pci/emu10k1/emumixer.c                                 |   82 -
 sound/pci/emu10k1/irq.c                                      |   45 
 sound/pci/ens1370.c                                          |   10 
 sound/pci/es1938.c                                           |    6 
 sound/pci/es1968.c                                           |   48 
 sound/pci/ice1712/ak4xxx.c                                   |   14 
 sound/pci/ice1712/aureon.c                                   |    2 
 sound/pci/ice1712/ews.c                                      |   16 
 sound/pci/ice1712/ice1712.h                                  |    8 
 sound/pci/ice1712/ice1724.c                                  |    4 
 sound/pci/intel8x0.c                                         |  358 ++--
 sound/pci/maestro3.c                                         |  100 -
 sound/pci/nm256/nm256.c                                      |   13 
 sound/pci/rme96.c                                            |   18 
 sound/pci/rme9652/Makefile                                   |    5 
 sound/pci/rme9652/hammerfall_mem.c                           |  251 ---
 sound/pci/rme9652/hdsp.c                                     |  417 +++--
 sound/pci/rme9652/rme9652.c                                  |   79 -
 sound/pci/sonicvibes.c                                       |    6 
 sound/pci/trident/trident.c                                  |   15 
 sound/pci/trident/trident_main.c                             |   17 
 sound/pci/via82xx.c                                          |    6 
 sound/pci/ymfpci/ymfpci.c                                    |   15 
 sound/pci/ymfpci/ymfpci_main.c                               |  131 +
 sound/pcmcia/vx/vxpocket.c                                   |    1 
 sound/ppc/awacs.c                                            |   29 
 sound/ppc/burgundy.c                                         |   25 
 sound/ppc/pmac.c                                             |    2 
 sound/ppc/pmac.h                                             |    5 
 sound/ppc/tumbler.c                                          |   28 
 sound/synth/emux/soundfont.c                                 |   18 
 sound/usb/usbaudio.c                                         |  230 ++-
 sound/usb/usbaudio.h                                         |    8 
 sound/usb/usbmidi.c                                          |    3 
 sound/usb/usbmixer.c                                         |    2 
 sound/usb/usbmixer_maps.c                                    |   23 
 sound/usb/usbquirks.h                                        |   36 
 108 files changed, 3166 insertions(+), 2126 deletions(-)

through these ChangeSets:

<perex@suse.cz> (03/07/28 1.1598)
   ALSA update
     - removed empty hammerfall_mem.c file
     - added MAKEDEV.snd script

<perex@suse.cz> (03/07/28 1.1597)
   ALSA 0.9.6 update
     - added __setup() to all midlevel modules
     - sequencer protocol 1.0.1
       - added timestamping flags for ports
     - OSS PCM emulation
       - fixed write() behaviour
       - added two new options no-silence & whole-frag
       - a try to fix OOPSes caused in the rate plugin
     - emu10k1 driver
       - more support for Audigy/Audigy2 EX
       - fixed soundfont locking
     - sb16 driver
       - fixed fm_res handling (and proc OOPS)
     - via82xx driver
       - fixed revision check for 8233A
     - usbaudio driver
       - added a workaround for M-Audio Audiophile USB

<perex@suse.cz> (03/07/21 1.1506.7.1)
   ALSA update 0.9.5
     - global
       - updated #ifdefs for sequencer and gameport
       - removed more "compatibility" code
     - PCM OSS interface
       - implemented POST ioctl
       - fixed read() semantics according original OSS API
     - AC'97 codec
       - separated code for specific codecs
       - added wolfson specific defines
     - AD1848
       - added workaround for thinkpad notebook
     - EMU10K1
       - fixed emufx ioctls
     - HDSP
       - updated driver
     - YMFPCI
       - added joystick code
     - USB driver
       - updated
     - intel8x0
       - added ALI chipset support
     - ice1712
       - fixed initialization for EWS cards


-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs

