Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264705AbTFATGL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jun 2003 15:06:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264706AbTFATGL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jun 2003 15:06:11 -0400
Received: from gate.perex.cz ([194.212.165.105]:21007 "EHLO gate.perex.cz")
	by vger.kernel.org with ESMTP id S264705AbTFATGG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jun 2003 15:06:06 -0400
Date: Sun, 1 Jun 2003 21:19:25 +0200 (CEST)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: perex@pnote.perex-int.cz
To: Linus Torvalds <torvalds@transmeta.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH/BK] ALSA update 0.9.4
Message-ID: <Pine.LNX.4.44.0306012117170.7783-100000@pnote.perex-int.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please do a

  bk pull http://linux-sound.bkbits.net/linux-sound

The GNU patch is available at:

  ftp://ftp.alsa-project.org/pub/kernel-patches/alsa-bk-2003-06-01.patch.gz

The pull command will update the following files:

 Documentation/sound/alsa/ALSA-Configuration.txt              |   88 
 Documentation/sound/alsa/CMIPCI.txt                          |    3 
 Documentation/sound/alsa/DocBook/writing-an-alsa-driver.tmpl |   17 
 Documentation/sound/alsa/OSS-Emulation.txt                   |    4 
 include/sound/ac97_codec.h                                   |    3 
 include/sound/ak4xxx-adda.h                                  |   61 
 include/sound/asequencer.h                                   |    2 
 include/sound/core.h                                         |   17 
 include/sound/cs8427.h                                       |    3 
 include/sound/info.h                                         |    7 
 include/sound/initval.h                                      |    2 
 include/sound/mpu401.h                                       |    6 
 include/sound/opl4.h                                         |   32 
 include/sound/pcm.h                                          |   65 
 include/sound/sb.h                                           |   14 
 include/sound/sndmagic.h                                     |    3 
 include/sound/trident.h                                      |    6 
 include/sound/uda1341.h                                      |   19 
 include/sound/version.h                                      |   16 
 include/sound/vx_core.h                                      |  550 +++
 sound/Kconfig                                                |    6 
 sound/Makefile                                               |    3 
 sound/arm/sa11xx-uda1341.c                                   |  856 ++----
 sound/core/Makefile                                          |   10 
 sound/core/control.c                                         |   12 
 sound/core/hwdep.c                                           |    2 
 sound/core/info.c                                            |  242 -
 sound/core/init.c                                            |   32 
 sound/core/ioctl32/pcm32.c                                   |   14 
 sound/core/ioctl32/rawmidi32.c                               |   10 
 sound/core/ioctl32/timer32.c                                 |   13 
 sound/core/memalloc.c                                        |   13 
 sound/core/oss/mixer_oss.c                                   |    2 
 sound/core/oss/pcm_oss.c                                     |   18 
 sound/core/pcm.c                                             |   20 
 sound/core/pcm_lib.c                                         |  116 
 sound/core/pcm_native.c                                      |  754 ++---
 sound/core/rawmidi.c                                         |    2 
 sound/core/seq/Makefile                                      |    2 
 sound/core/seq/oss/seq_oss.c                                 |    2 
 sound/core/seq/seq_clientmgr.c                               |    2 
 sound/core/seq/seq_memory.c                                  |   11 
 sound/core/sgbuf.c                                           |    2 
 sound/core/sound.c                                           |   69 
 sound/core/sound_oss.c                                       |    1 
 sound/core/timer.c                                           |    2 
 sound/drivers/Makefile                                       |    2 
 sound/drivers/dummy.c                                        |   26 
 sound/drivers/mpu401/Makefile                                |    2 
 sound/drivers/mpu401/mpu401_uart.c                           |   64 
 sound/drivers/opl3/Makefile                                  |    2 
 sound/drivers/opl3/opl3_lib.c                                |   12 
 sound/drivers/opl4/Makefile                                  |   15 
 sound/drivers/opl4/opl4_lib.c                                |  275 +
 sound/drivers/opl4/opl4_local.h                              |  231 +
 sound/drivers/opl4/opl4_mixer.c                              |   93 
 sound/drivers/opl4/opl4_proc.c                               |  165 +
 sound/drivers/opl4/opl4_seq.c                                |  224 +
 sound/drivers/opl4/opl4_synth.c                              |  623 ++++
 sound/drivers/opl4/yrw801.c                                  |  961 ++++++
 sound/drivers/vx/Makefile                                    |   11 
 sound/drivers/vx/vx_cmd.c                                    |  109 
 sound/drivers/vx/vx_cmd.h                                    |  248 +
 sound/drivers/vx/vx_core.c                                   |  808 +++++
 sound/drivers/vx/vx_hwdep.c                                  |  122 
 sound/drivers/vx/vx_mixer.c                                  |  951 ++++++
 sound/drivers/vx/vx_pcm.c                                    | 1307 +++++++++
 sound/drivers/vx/vx_uer.c                                    |  320 ++
 sound/i2c/Makefile                                           |    2 
 sound/i2c/cs8427.c                                           |  161 -
 sound/i2c/l3/uda1341.c                                       |  278 -
 sound/i2c/other/Makefile                                     |   10 
 sound/i2c/other/ak4xxx-adda.c                                |  445 +++
 sound/isa/Kconfig                                            |   10 
 sound/isa/Makefile                                           |    2 
 sound/isa/ad1816a/ad1816a.c                                  |    4 
 sound/isa/als100.c                                           |    4 
 sound/isa/azt2320.c                                          |    7 
 sound/isa/cmi8330.c                                          |    3 
 sound/isa/cs423x/Makefile                                    |    1 
 sound/isa/cs423x/cs4231_lib.c                                |    8 
 sound/isa/cs423x/cs4236.c                                    |    6 
 sound/isa/dt019x.c                                           |   25 
 sound/isa/es18xx.c                                           |    3 
 sound/isa/gus/gus_irq.c                                      |    3 
 sound/isa/gus/gus_synth.c                                    |    3 
 sound/isa/gus/interwave.c                                    |    3 
 sound/isa/opl3sa2.c                                          |    6 
 sound/isa/opti9xx/opti92x-ad1848.c                           |   31 
 sound/isa/sb/emu8000.c                                       |    2 
 sound/isa/sb/es968.c                                         |   13 
 sound/isa/sb/sb16.c                                          |    9 
 sound/isa/sb/sb8.c                                           |    5 
 sound/isa/sb/sb8_main.c                                      |    3 
 sound/isa/sb/sb8_midi.c                                      |   85 
 sound/isa/sscape.c                                           | 1560 ++++++++++-
 sound/isa/wavefront/wavefront.c                              |    6 
 sound/parisc/Kconfig                                         |   13 
 sound/parisc/Makefile                                        |    8 
 sound/parisc/harmony.c                                       | 1147 ++++++++
 sound/pci/Kconfig                                            |    6 
 sound/pci/Makefile                                           |    2 
 sound/pci/ac97/Makefile                                      |    1 
 sound/pci/ac97/ac97_codec.c                                  |  132 
 sound/pci/ac97/ac97_patch.c                                  |  126 
 sound/pci/ac97/ac97_patch.h                                  |    2 
 sound/pci/ali5451/ali5451.c                                  |   76 
 sound/pci/cmipci.c                                           |   15 
 sound/pci/cs46xx/cs46xx_lib.c                                |    8 
 sound/pci/emu10k1/emufx.c                                    |    2 
 sound/pci/emu10k1/irq.c                                      |   29 
 sound/pci/ens1370.c                                          |   26 
 sound/pci/ice1712/Makefile                                   |    8 
 sound/pci/ice1712/ak4524.c                                   |  525 ---
 sound/pci/ice1712/ak4xxx.c                                   |  181 +
 sound/pci/ice1712/delta.c                                    |   85 
 sound/pci/ice1712/envy24ht.h                                 |    3 
 sound/pci/ice1712/ews.c                                      |   91 
 sound/pci/ice1712/ice1712.c                                  |  186 -
 sound/pci/ice1712/ice1712.h                                  |   23 
 sound/pci/ice1712/ice1724.c                                  |  109 
 sound/pci/ice1712/revo.c                                     |   28 
 sound/pci/intel8x0.c                                         |  799 ++---
 sound/pci/korg1212/korg1212.c                                |    3 
 sound/pci/maestro3.c                                         |   42 
 sound/pci/nm256/nm256.c                                      |   36 
 sound/pci/rme9652/hammerfall_mem.c                           |   22 
 sound/pci/rme9652/hdsp.c                                     |   22 
 sound/pci/rme9652/rme9652.c                                  |   18 
 sound/pci/sonicvibes.c                                       |    4 
 sound/pci/trident/trident_main.c                             |   11 
 sound/pci/trident/trident_synth.c                            |    3 
 sound/pci/via82xx.c                                          |   99 
 sound/pci/vx222/Makefile                                     |    8 
 sound/pci/vx222/vx222.c                                      |  311 ++
 sound/pci/vx222/vx222.h                                      |  114 
 sound/pci/vx222/vx222_ops.c                                  | 1011 +++++++
 sound/pci/ymfpci/ymfpci.c                                    |   36 
 sound/pci/ymfpci/ymfpci_main.c                               |    9 
 sound/pcmcia/Kconfig                                         |   18 
 sound/pcmcia/Makefile                                        |    8 
 sound/pcmcia/vx/Makefile                                     |   10 
 sound/pcmcia/vx/vx_entry.c                                   |  385 ++
 sound/pcmcia/vx/vxp440.c                                     |   14 
 sound/pcmcia/vx/vxp_mixer.c                                  |  150 +
 sound/pcmcia/vx/vxp_ops.c                                    |  616 ++++
 sound/pcmcia/vx/vxpocket.c                                   |  174 +
 sound/pcmcia/vx/vxpocket.h                                   |  121 
 sound/ppc/awacs.c                                            |   21 
 sound/ppc/keywest.c                                          |   11 
 sound/ppc/pmac.c                                             |   11 
 sound/ppc/pmac.h                                             |    6 
 sound/ppc/tumbler.c                                          |   10 
 sound/usb/usbaudio.c                                         |  420 ++
 sound/usb/usbaudio.h                                         |    3 
 sound/usb/usbmixer.c                                         |   40 
 sound/usb/usbmixer_maps.c                                    |   17 
 sound/usb/usbquirks.h                                        |   16 
 158 files changed, 16599 insertions(+), 3235 deletions(-)

through these ChangeSets:

<perex@suse.cz> (03/06/01 1.1257)
   ALSA update 0.9.4
     - added drivers for Digigram VXPocket V2, VXPocket 440 (pcmcia)
     - added driver for Digigram VXP220 V2/Mic (PCI)
     - added driver Harmony chipset (parisc)
     - added OPL4 driver
     - code cleanups - removed 2.2 and 2.4 code
     - nm256 driver - added Dell Latitude LS workaround
     - ac97 driver - fixes in intialization
     - usb audio driver - strlcat() fixes

<perex@suse.cz> (03/05/21 1.1155.2.3)
   ALSA update
     - fixed sscape driver Makefile
     - fixed spin deadlock in PCM midlevel
     - added AC'97 detection workaround to ens1370 and nm256 drivers

<perex@suse.cz> (03/05/20 1.1155.2.2)
   ALSA update 0.9.3c
     - added sscape driver
     - documentation updates
     - removed proc dynamic device directory
     - fixed deadlock in PCM midlevel
     - more PnP code cleanups
     - ICE1712/1724 driver - cleanups
     - usbaudio driver
       - added preliminary support for streams II/III
       - more quirk update for extigy
     - intel8x0 driver - nforce fixes
     - sb8 driver - full duplex MIDI UART code for DSP 2.xx+

<perex@suse.cz> (03/05/08 1.1063.5.13)
   ALSA update 0.9.3a
     - PCM - recoded link group locking
     - MPU401 - replaced RX_LOOP and TX_LOOP bits with atomic_t variables
     - ICE17xx - moved ak4xxx routines to separate module (snd-ak4xxx-adda)
     - CS8427 - fixed initialization, added Q-subcode control
     - AC97 - added more patches for Wolfson codecs
     - CMIPCI - added 24-bit sample support for S/PDIF
     - maestro3 - fixes
     - via82xx - workaround for Award BIOS, dxs_support module parameter
     - ymfpci - fixed initialization
     - intel8x0 - code cleanups, recoded inialization of pcm streams
     - sa11xx-uda1341 - removed debug code and other cleanups
     - irqreturn_t cleanups

<perex@suse.cz> (03/04/11 1.971.121.1)
   ALSA update
     - ISA PnP drivers - fixed failure path (missing pnp_unregister_card_driver() call)

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs

