Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262780AbVAFI6U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262780AbVAFI6U (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 03:58:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262781AbVAFI6U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 03:58:20 -0500
Received: from gate.perex.cz ([82.113.61.162]:19850 "EHLO mail.perex.cz")
	by vger.kernel.org with ESMTP id S262780AbVAFIxs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 03:53:48 -0500
Date: Thu, 6 Jan 2005 09:45:19 +0100 (CET)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: perex@pnote.perex-int.cz
To: Linus Torvalds <torvalds@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [ALSA PATCH] 1.0.8rc2 release
Message-ID: <Pine.LNX.4.58.0501060943100.3812@pnote.perex-int.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please do a

  bk pull http://linux-sound.bkbits.net/linux-sound

The GNU patch is available at:

  ftp://ftp.alsa-project.org/pub/kernel-patches/alsa-bk-2005-01-05.patch.gz

The pull command will update the following files:

 include/sound/soundmem.h                                     |    8 
 sound/core/seq/oss/seq_oss_misc.c                            |  110 
 Documentation/sound/alsa/ALSA-Configuration.txt              |   63 
 Documentation/sound/alsa/Bt87x.txt                           |   78 
 Documentation/sound/alsa/DocBook/writing-an-alsa-driver.tmpl |  213 -
 Documentation/sound/alsa/MIXART.txt                          |    4 
 Documentation/sound/alsa/OSS-Emulation.txt                   |   11 
 include/sound/ac97_codec.h                                   |   12 
 include/sound/ad1848.h                                       |    9 
 include/sound/ainstr_fm.h                                    |    2 
 include/sound/ainstr_gf1.h                                   |    2 
 include/sound/ainstr_iw.h                                    |    2 
 include/sound/ainstr_simple.h                                |    2 
 include/sound/ak4531_codec.h                                 |    2 
 include/sound/asound.h                                       |    9 
 include/sound/control.h                                      |   13 
 include/sound/core.h                                         |    9 
 include/sound/cs4231.h                                       |    5 
 include/sound/cs8427.h                                       |    3 
 include/sound/emu10k1.h                                      |   25 
 include/sound/es1688.h                                       |    3 
 include/sound/gus.h                                          |    4 
 include/sound/info.h                                         |    9 
 include/sound/pcm.h                                          |   92 
 include/sound/rawmidi.h                                      |    7 
 include/sound/sb.h                                           |    4 
 include/sound/seq_midi_emul.h                                |    2 
 include/sound/snd_wavefront.h                                |    1 
 include/sound/soundfont.h                                    |    1 
 include/sound/trident.h                                      |    4 
 include/sound/version.h                                      |    8 
 include/sound/vx_core.h                                      |   34 
 include/sound/ymfpci.h                                       |    3 
 sound/Kconfig                                                |    2 
 sound/arm/sa11xx-uda1341.c                                   |    4 
 sound/core/Kconfig                                           |    2 
 sound/core/control.c                                         |  247 -
 sound/core/hwdep.c                                           |    2 
 sound/core/info.c                                            |   26 
 sound/core/init.c                                            |   34 
 sound/core/ioctl32/hwdep32.c                                 |   32 
 sound/core/ioctl32/ioctl32.c                                 |  315 +-
 sound/core/ioctl32/ioctl32.h                                 |   87 
 sound/core/ioctl32/pcm32.c                                   |  333 --
 sound/core/ioctl32/rawmidi32.c                               |   16 
 sound/core/ioctl32/seq32.c                                   |    6 
 sound/core/ioctl32/timer32.c                                 |   10 
 sound/core/memory.c                                          |   16 
 sound/core/oss/mixer_oss.c                                   |   40 
 sound/core/oss/mulaw.c                                       |    1 
 sound/core/oss/pcm_oss.c                                     |   21 
 sound/core/oss/pcm_plugin.c                                  |   49 
 sound/core/oss/pcm_plugin.h                                  |    1 
 sound/core/oss/rate.c                                        |    2 
 sound/core/oss/route.c                                       |   91 
 sound/core/pcm.c                                             |   33 
 sound/core/pcm_lib.c                                         |   99 
 sound/core/pcm_memory.c                                      |    2 
 sound/core/pcm_misc.c                                        |   11 
 sound/core/pcm_native.c                                      |   23 
 sound/core/rawmidi.c                                         |    8 
 sound/core/seq/Makefile                                      |    2 
 sound/core/seq/instr/ainstr_fm.c                             |    5 
 sound/core/seq/instr/ainstr_gf1.c                            |    5 
 sound/core/seq/instr/ainstr_iw.c                             |    5 
 sound/core/seq/instr/ainstr_simple.c                         |    5 
 sound/core/seq/oss/seq_oss_device.h                          |    1 
 sound/core/seq/oss/seq_oss_init.c                            |   39 
 sound/core/seq/oss/seq_oss_readq.c                           |    3 
 sound/core/seq/oss/seq_oss_timer.c                           |    2 
 sound/core/seq/seq_clientmgr.c                               |    6 
 sound/core/seq/seq_clientmgr.h                               |    1 
 sound/core/seq/seq_instr.c                                   |   18 
 sound/core/seq/seq_memory.c                                  |    5 
 sound/core/seq/seq_memory.h                                  |    1 
 sound/core/seq/seq_midi.c                                    |    8 
 sound/core/seq/seq_midi_emul.c                               |   17 
 sound/core/seq/seq_midi_event.c                              |    6 
 sound/core/sgbuf.c                                           |    6 
 sound/core/sound.c                                           |   33 
 sound/core/timer.c                                           |   12 
 sound/drivers/opl3/Makefile                                  |    1 
 sound/drivers/opl3/opl3_drums.c                              |    8 
 sound/drivers/opl3/opl3_lib.c                                |    6 
 sound/drivers/opl3/opl3_midi.c                               |    2 
 sound/drivers/opl3/opl3_seq.c                                |    4 
 sound/drivers/opl4/opl4_lib.c                                |   13 
 sound/drivers/vx/vx_cmd.c                                    |    2 
 sound/drivers/vx/vx_cmd.h                                    |    2 
 sound/drivers/vx/vx_core.c                                   |  116 
 sound/drivers/vx/vx_hwdep.c                                  |  142 
 sound/drivers/vx/vx_pcm.c                                    |    8 
 sound/drivers/vx/vx_uer.c                                    |    2 
 sound/i2c/cs8427.c                                           |   21 
 sound/i2c/i2c.c                                              |    2 
 sound/i2c/l3/uda1341.c                                       |    9 
 sound/i2c/other/ak4117.c                                     |    2 
 sound/isa/ad1816a/ad1816a_lib.c                              |   10 
 sound/isa/ad1848/ad1848_lib.c                                |   30 
 sound/isa/als100.c                                           |    2 
 sound/isa/cs423x/cs4231_lib.c                                |   42 
 sound/isa/cs423x/cs4236.c                                    |    2 
 sound/isa/es1688/es1688_lib.c                                |    8 
 sound/isa/es18xx.c                                           |   12 
 sound/isa/gus/gus_dma.c                                      |   12 
 sound/isa/gus/gus_mem.c                                      |    3 
 sound/isa/gus/gus_sample.c                                   |    2 
 sound/isa/opl3sa2.c                                          |   12 
 sound/isa/opti9xx/opti92x-ad1848.c                           |   12 
 sound/isa/sb/emu8000.c                                       |    2 
 sound/isa/sb/emu8000_callback.c                              |    4 
 sound/isa/sb/emu8000_pcm.c                                   |    3 
 sound/isa/sb/sb16_main.c                                     |   10 
 sound/isa/sb/sb8_main.c                                      |    4 
 sound/isa/sb/sb_common.c                                     |    2 
 sound/isa/sscape.c                                           |   30 
 sound/isa/wavefront/wavefront.c                              |    6 
 sound/isa/wavefront/wavefront_fx.c                           |    3 
 sound/isa/wavefront/wavefront_synth.c                        |  100 
 sound/pci/Kconfig                                            |   39 
 sound/pci/Makefile                                           |    3 
 sound/pci/ac97/ac97_codec.c                                  |  746 ++--
 sound/pci/ac97/ac97_local.h                                  |   27 
 sound/pci/ac97/ac97_patch.c                                  |  170 -
 sound/pci/ac97/ac97_pcm.c                                    |   12 
 sound/pci/ac97/ac97_proc.c                                   |   12 
 sound/pci/ac97/ak4531_codec.c                                |   34 
 sound/pci/ali5451/ali5451.c                                  |   12 
 sound/pci/als4000.c                                          |    7 
 sound/pci/atiixp.c                                           |   19 
 sound/pci/atiixp_modem.c                                     |   19 
 sound/pci/au88x0/au88x0.c                                    |   15 
 sound/pci/au88x0/au88x0.h                                    |    6 
 sound/pci/au88x0/au88x0_core.c                               |   83 
 sound/pci/au88x0/au88x0_eq.c                                 |   58 
 sound/pci/au88x0/au88x0_mixer.c                              |    4 
 sound/pci/au88x0/au88x0_pcm.c                                |   13 
 sound/pci/azt3328.c                                          |   48 
 sound/pci/bt87x.c                                            |  155 -
 sound/pci/ca0106/Makefile                                    |    3 
 sound/pci/ca0106/ca0106.h                                    |  549 +++
 sound/pci/ca0106/ca0106_main.c                               | 1280 ++++++++
 sound/pci/ca0106/ca0106_mixer.c                              |  635 ++++
 sound/pci/ca0106/ca0106_proc.c                               |  437 ++
 sound/pci/cmipci.c                                           |   31 
 sound/pci/cs4281.c                                           |   18 
 sound/pci/cs46xx/cs46xx_lib.c                                |   92 
 sound/pci/cs46xx/cs46xx_lib.h                                |   40 
 sound/pci/cs46xx/dsp_spos.c                                  |   24 
 sound/pci/cs46xx/dsp_spos_scb_lib.c                          |   12 
 sound/pci/cs46xx/imgs/cwcdma.h                               |    8 
 sound/pci/emu10k1/Makefile                                   |    4 
 sound/pci/emu10k1/emu10k1.c                                  |   32 
 sound/pci/emu10k1/emu10k1_main.c                             |   44 
 sound/pci/emu10k1/emu10k1_synth.c                            |    4 
 sound/pci/emu10k1/emu10k1x.c                                 | 1688 ++++++++++-
 sound/pci/emu10k1/emufx.c                                    |  273 +
 sound/pci/emu10k1/emumixer.c                                 |   71 
 sound/pci/emu10k1/emupcm.c                                   |   14 
 sound/pci/emu10k1/emuproc.c                                  |  220 +
 sound/pci/emu10k1/io.c                                       |   25 
 sound/pci/emu10k1/irq.c                                      |    4 
 sound/pci/emu10k1/timer.c                                    |   99 
 sound/pci/ens1370.c                                          |   37 
 sound/pci/es1938.c                                           |   25 
 sound/pci/es1968.c                                           |   55 
 sound/pci/fm801.c                                            |   21 
 sound/pci/ice1712/ak4xxx.c                                   |    3 
 sound/pci/ice1712/aureon.c                                   |  510 ++-
 sound/pci/ice1712/aureon.h                                   |   10 
 sound/pci/ice1712/delta.c                                    |    3 
 sound/pci/ice1712/ice1712.c                                  |    7 
 sound/pci/ice1712/ice1712.h                                  |    1 
 sound/pci/ice1712/ice1724.c                                  |    8 
 sound/pci/intel8x0.c                                         |   96 
 sound/pci/intel8x0m.c                                        |   15 
 sound/pci/korg1212/korg1212.c                                |   49 
 sound/pci/maestro3.c                                         |   71 
 sound/pci/mixart/mixart.c                                    |   23 
 sound/pci/mixart/mixart_core.c                               |    5 
 sound/pci/mixart/mixart_hwdep.c                              |  190 -
 sound/pci/mixart/mixart_hwdep.h                              |    3 
 sound/pci/nm256/nm256.c                                      |   30 
 sound/pci/rme32.c                                            |    7 
 sound/pci/rme96.c                                            |   11 
 sound/pci/rme9652/hdsp.c                                     |  119 
 sound/pci/rme9652/rme9652.c                                  |    3 
 sound/pci/sonicvibes.c                                       |   14 
 sound/pci/trident/trident_main.c                             |   63 
 sound/pci/trident/trident_memory.c                           |   23 
 sound/pci/trident/trident_synth.c                            |    4 
 sound/pci/via82xx.c                                          |   84 
 sound/pci/via82xx_modem.c                                    | 1274 ++++++++
 sound/pci/vx222/vx222.c                                      |   16 
 sound/pci/vx222/vx222_ops.c                                  |   26 
 sound/pci/ymfpci/ymfpci_main.c                               |   27 
 sound/pcmcia/pdaudiocf/pdaudiocf.h                           |    2 
 sound/pcmcia/pdaudiocf/pdaudiocf_core.c                      |    6 
 sound/pcmcia/vx/vx_entry.c                                   |   78 
 sound/pcmcia/vx/vxp_ops.c                                    |   28 
 sound/ppc/pmac.c                                             |   17 
 sound/sparc/cs4231.c                                         |   23 
 sound/synth/emux/emux.c                                      |    8 
 sound/synth/emux/emux_seq.c                                  |    3 
 sound/synth/emux/emux_synth.c                                |   10 
 sound/synth/emux/soundfont.c                                 |    8 
 sound/usb/Kconfig                                            |    2 
 sound/usb/usbaudio.c                                         |   20 
 sound/usb/usbmidi.c                                          |    6 
 sound/usb/usbmixer.c                                         |   70 
 sound/usb/usx2y/Makefile                                     |    2 
 sound/usb/usx2y/usX2Yhwdep.c                                 |   14 
 sound/usb/usx2y/usbusx2y.c                                   |   43 
 sound/usb/usx2y/usbusx2y.h                                   |   47 
 sound/usb/usx2y/usbusx2yaudio.c                              |  819 ++---
 sound/usb/usx2y/usx2y.h                                      |    6 
 sound/usb/usx2y/usx2yhwdeppcm.c                              |  811 +++++
 sound/usb/usx2y/usx2yhwdeppcm.h                              |   21 
 218 files changed, 11445 insertions(+), 3619 deletions(-)

through these ChangeSets:

<perex@suse.cz> (05/01/05 1.2149)
   [ALSA] 1.0.8rc2

<perex@suse.cz> (05/01/04 1.2148)
   [ALSA] Print values at errors
   
   EMU10K1/EMU10K2 driver
   Print out the invalid values at resource allocation errors, too.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/01/04 1.2147)
   [ALSA] Don't probe sample rates on non-VRA chips
   
   ES1968 driver,CA0106 driver,EMU10K1/EMU10K2 driver
   Don't probe sample rates on chips which need no VRA.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/01/04 1.2146)
   [ALSA] Add codec id in component names
   
   AC97 Codec Core
   Added codec id number to the component names.
   The component becomes like 'AC97a:12345678'.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/01/04 1.2145)
   [ALSA] Fix C-Media codecs
   
   AC97 Codec Core
   Don't create PCM (and Master for CM9739/9761) volume controls for some of
   C-Media codecs.  The volume is supposed to be controlled via softvol plugin.
   
   The wrong (duble) entry for a CM9761 model is removed, too.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/01/04 1.2143)
   [ALSA] Add a DXS entry for ABIT VA-20
   
   VIA82xx driver
   Added a DXS whitelist entry for ABIT VA-20.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/01/04 1.2142)
   [ALSA] Fix NULL pointer access
   
   MIXART driver
   Fixed NULL pointer access when id string isn't given.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/01/04 1.2141)
   [ALSA] Add a new ID
   
   CA0106 driver
   I attach a minor update that corrects the DMA mask, and adds an extra
   ID. This sound card can handle 32bit DMA addresses.
   
   Signed-off-by: James Courtier-Dutton  <James@superbug.demon.co.uk>
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/01/04 1.2140)
   [ALSA] Clean up and fix stereo mutes
   
   AC97 Codec Core
   Clean up the build of controls.  The volume resolution detection is
   unified.
   Fixed minor bugs to handle stereo mutes.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/01/04 1.2139)
   [ALSA] Clean up handling of user-defined controls
   
   Control Midlevel
   Cleaned up the code to handle user-defined controls.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/01/03 1.2034.85.85)
   [ALSA] Fix spinlock
   
   au88x0 driver
   Fixed possible spin deadlocks.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/01/03 1.2034.85.84)
   [ALSA] Add CODEC and BUS device types
   
   OPL3,OPL4,I2C lib core,L3 drivers,AK4117 receiver,ALSA Core
   EMU8000 driver,AC97 Codec Core,AK4531 codec
   Added SNDRV_DEV_CODEC and SNDRV_DEV_BUS types to tell from the lowlevel
   components.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/01/03 1.2034.85.83)
   [ALSA] Remove superfluous code
   
   USB USX2Y
   Removed the superfluous creation/deletion of lowlevel component.
   It's not used at all.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/01/03 1.2034.85.82)
   [ALSA] Fix the order of creation of instances
   
   AZT3328 driver,CMIPCI driver,CS4281 driver,ENS1370/1+ driver
   Maestro3 driver,SonicVibes driver,CS46xx driver,KORG1212 driver
   NM256 driver,Trident driver,YMFPCI driver
   Make sure that the chip instance is created at first before other components.
   This will fix occasional oops at unloading due to the access to the released
   resources.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/01/03 1.2034.85.81)
   [ALSA] Clean up codes
   
   ALSA<-OSS emulation
   Got rid of the unused float codes (the legacy code for sharing with ALSA
   library).
   Add assert to the invalid conversion indices which results in oops
   (just to be sure).
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/01/03 1.2034.85.80)
   [ALSA] Description about snd_card_set_dev()
   
   Documentation
   Added the description about snd_card_set_dev().
   Misc cleanup.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/01/03 1.2034.85.79)
   [ALSA] Fix the release of resources at error path
   
   Control Midlevel
   Implemented free callback to fix the release of control resources
   before calling register.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/01/03 1.2034.85.78)
   [ALSA] Update documentation for hotplug fw loader
   
   Documentation
   Updated descriptions about the firmware loading for the recent support of
   hotplug firmware loader.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/01/03 1.2034.85.77)
   [ALSA] Add hotplug firmware loader support
   
   RME HDSP driver
   Added the hotplug firmware loader support without hdsploader.
   The firmware data must be installed beforehand in the proper place from
   the latest alsa-firmware package.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/01/03 1.2034.85.76)
   [ALSA] Fix compile warning
   
   EMU10K1/EMU10K2 driver
   Removed an unused variable to fix a compile warning.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/01/03 1.2034.85.75)
   [ALSA] Fix compile warning (make inline)
   
   AZT3328 driver
   Fixed compile warning when built without joystick support.
   (Optimized via inline.)
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/01/03 1.2034.85.74)
   [ALSA] Fix open handling
   
   USB USX2Y
   Return -EBUSY from snd_usX2Y_usbpcm_open(), if the associated hwdep
   device is not opened.
   
   It now works as originally intended. Had forgotten a pair of parenthesis.
   
   Signed-off-by: Karsten Wiese <annabellesgarden@yahoo.de>
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/01/03 1.2034.85.73)
   [ALSA CVS]  delete unused file
   
   Remove nowhere referenced file. (egrep "filename\." didn't find
   anything)
   
   Signed-off-by: Domen Puncer <domen@coderock.org>
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/01/03 1.2034.85.72)
   [ALSA] Code clean up
   
   EMU10K1/EMU10K2 driver
   Small code clean up.  Use snd_pcm_lib_preallocage_pages_for_all()
   for buffer allocation.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/01/03 1.2034.85.71)
   [ALSA] Avoid VRA on codec chips
   
   YMFPCI driver
   Avoid VRA setting on ac97 codec chips.  YMFPCI doesn't need VRA.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/01/03 1.2034.85.70)
   [ALSA] Add snd-ca0106 driver
   
   Documentation,PCI drivers,CA0106 driver
   Added snd-ca0106 driver for SB Audigy LS / Live 24bit boards
   by James Courtier-Dutton <James@superbug.demon.co.uk>.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/01/03 1.2034.85.69)
   [ALSA] Add emu10k1x driver
   
   Documentation,PCI drivers,EMU10K1/EMU10K2 driver
   Added the new driver, snd-emu10k1x, for SB Live Dell OEM version
   by Francisco Moraes <fmoraes@nc.rr.com>.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/01/03 1.2034.85.68)
   [ALSA] Allow strings for ac97_quirk options
   
   AC97 Codec Core,Intel8x0 driver,VIA82xx driver
   Since there are many ac97_quirk values, the number is no longer good to
   remember what it really means.  Now ac97_quirk option becomes as a string
   option, and more undstandable.  For example, you can pass like
   'ac97_quirk=hp_only'.  The old number is still kept and parsed for backward
   compatibility.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/01/03 1.2034.85.67)
   [ALSA] Fix handling of user-defined controls
   
   Control Midlevel,ALSA Core
   Fixed handling of user-defined controls.
   The max number of user-defined controls is limited, too (as default 32).
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/01/03 1.2034.85.66)
   [ALSA] Don't probe rates when bus->no_vra is set
   
   AC97 Codec Core
   Don't probe rates and set VRA/VRM bits when bus->no_vra is set.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/01/03 1.2034.85.65)
   [ALSA] Use msleep() in ac97 callbacks
   
   CS46xx driver,NM256 driver
   Use msleep() instead of mdelay() in ac97 callbacks (spinlock was removed).
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/01/03 1.2034.85.64)
   [ALSA] Spinlock removal and loop fix
   
   au88x0 driver
   Removed unnecessary spinlocks.
   The invalid (typo) loop in the codec read callback is fixed.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/01/03 1.2034.85.63)
   [ALSA] Fix spinlocks
   
   FM801 driver
   Fixed the possible deadlock with no irq spinlock.
   Also, spin_lock_irqsave() is replaced with spin_lock_irq() in some places.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/01/03 1.2034.85.62)
   [ALSA] Remove unnecessary ac97 spinlocks
   
   ATIIXP driver,ATIIXP-modem driver,ENS1370/1+ driver,Intel8x0 driver
   Intel8x0-modem driver,Maestro3 driver,VIA82xx driver
   VIA82xx-modem driver
   Removed unnecessary spinlocks in ac97 callbacks.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/01/03 1.2034.85.61)
   [ALSA] Remove spinlock in callbacks
   
   AC97 Codec Core,AK4531 codec
   Removed spinlocks in callback, use sempahore instead since all ac97
   callbacks are supposed to be non-atomic.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/01/03 1.2034.85.60)
   [ALSA] Unify ac97 control callbacks
   
   AC97 Codec Core
   Unified single_* and double_* control callbacks.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/01/03 1.2034.85.59)
   [ALSA] Replace long delays with msleep()
   
   au88x0 driver
   Long udelay()'s are replaced with msleep() as much as possible.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/01/03 1.2034.85.58)
   [ALSA] Fix creation of control devices over udev
   
   Control Midlevel,ALSA Core
   Don't create control devices before the driver initialization finishes
   (ALSA BTS #742).
   
   The control device is now handled in the device list together with others
   (holding the card instance as the device pointer).
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/01/03 1.2034.85.57)
   [ALSA] Add mute LED quirk
   
   AC97 Codec Core,Intel8x0 driver
   A new quirk type, AC97_TUNE_MUTE_LED, is added for HP/Compaq laptops.
   With this quirk, the EAPD bit is used to control the mute LED in
   conjunction with the master mute switch.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/01/03 1.2034.85.56)
   [ALSA] Fix compile warning
   
   Wavefront drivers
   Fixed compile warning regarding the sign of char.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/01/03 1.2034.85.55)
   [ALSA] Fix the wrong sign of format data entries
   
   PCM Midlevel
   Fix suggested by Benjamin Herrenschmidt <benh@kernel.crashing.org>
   
   On architectures like PPC, char is handled as 'unsigned char', thus the
   pcm_format_data table entries with -1 give a positive 255.  This causes
   Oops with OSS-emulation on such architectures.
   
   The patch simply adds the right signed/unsigned prefix to fix this problem.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/01/03 1.2034.85.54)
   [ALSA] Fix invalid 'AutoSync Reference' value
   
   RME HDSP driver
   The value returned by controllers for control number 14 ('AutoSync
   Reference') is incorrect and different from that reported by doing
   a cat /proc/asound/card0/hdsp.
   The value reported is not 'AutoSync Reference' but 'Preferred Sync
   Reference' instead.
   
   Signed-off-by: Remy Bruno <remy.bruno@trinnov.com>
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/01/03 1.2034.85.53)
   [ALSA] Add PCXHR hwdep iface type
   
   ALSA Core
   Added SNDRV_HWDEP_IFACE_PCXHR for Digigram PCXHR driver.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/01/03 1.2034.85.52)
   [ALSA] Fix the invalid DMA pointer value
   
   PPC PMAC driver
   Fixed the bug returning invalid DMA pointer values.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/01/03 1.2034.85.51)
   [ALSA] Fix compilation errors
   
   Digigram VX core,MIXART driver
   Fix compilation errors when built without hotplug fw loader.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/01/03 1.2034.85.50)
   [ALSA] Fix CMI9739A silent problem
   
   AC97 Codec Core
   Fix by Zinx Verituse <zinx@epicsol.org>
   The patch for cmi9739a is added.  The undocumented unmute bits are
   enabled.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/01/03 1.2034.85.49)
   [ALSA] Fix interrupt generation on MIDI input for es1938 sound cards
   
   ES1938 driver
   The patch ensures that a es1938 based sound card generates interrupts on
   incoming MIDI events. I tested the patch successfully on an ess Solo-1 in
   a AlphaPC UX/164.
   
   Signed-off-by: Andreas Feldner <pelzi@flying-snail.de>
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/01/03 1.2034.85.48)
   [ALSA] Add description about hotplug fw loader
   
   Documentation
   New descriptions about hotplug fw loader for vx and mixart drivers.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/01/03 1.2034.85.47)
   [ALSA] Hotplug firmware loader support
   
   Digigram VX core,MIXART driver,Digigram VX222 driver
   Digigram VX Pocket driver
   The hogplut fw loader is supported by vxpocket, vxp440, vx2222 and mixart
   drivers.  The old ALSA fw loader is still supported for built-in kernels.
   To use the hotplug, the new firmware data must be installed beforehand
   from the latest alsa-tools package.
   
   The experimental suspend/resume for vxpocket, vxp440 and vx222 are added,
   too.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/01/03 1.2034.85.46)
   [ALSA] Fix memory corruption
   
   Digigram VX core
   Fixed the memory corruption by the wrong sized kmalloc.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/01/03 1.2034.85.45)
   [ALSA] Return -EBADFD when the device is disconnected
   
   USB generic driver
   The trigger callback returns -EBADFD when the device is disconnected.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/01/03 1.2034.85.44)
   [ALSA] Add volatile to IO pinters
   
   ALSA Core
   Add volatile prefix to IO pointers for copy_to_user_fromio() and
   copy_from_user_toio() functions.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/01/03 1.2034.85.43)
   [ALSA] buffersize and constraints on pmac
   
   PPC PMAC driver
   Buffersize is a bit small compared to the OSS driver (dmasound.h says
   128kb is limit for Amiga, for pmac 256kb is used)
   At least on Snapper, some samplerates cause choppy sound when
   periods<3 or buffersize is not a multiple of periodsize.
   
   Signed-off-by: Danny Tholen <obiwan@mailmij.org>
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/01/03 1.2034.85.42)
   [ALSA] Export snd_ctl_elem_read/write() functions
   
   Control Midlevel,ALSA Core,IOCTL32 emulation
   snd_ctl_elem_read() and snd_ctl_elem_write() functions are exported
   to be accessible from other kernel modules.  They can be used for
   suspend/resume codes, for example.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/01/03 1.2034.85.41)
   [ALSA] Clean up power-management
   
   Documentation,SA11xx UDA1341 driver,Control Midlevel,ALSA Core
   ES18xx driver,OPL3SA2 driver,AD1848 driver,CS4231 driver,ATIIXP driver
   ATIIXP-modem driver,CS4281 driver,ES1938 driver,ES1968 driver
   Intel8x0 driver,Intel8x0-modem driver,Maestro3 driver,VIA82xx driver
   VIA82xx-modem driver,ALI5451 driver,CS46xx driver,NM256 driver
   Trident driver,YMFPCI driver,Sound Core PDAudioCF driver
   PPC PMAC driver
   Clean up for PM code.
   snd_power_change() is called in the common routines instead of driver's callback.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/01/03 1.2034.85.40)
   [ALSA] Midiman Delta DIO2496 has two stereo analog outs
   
   ICE1712 driver
   
   
   Signed-off-by: Jaroslav Kysela <perex@suse.cz>

<perex@suse.cz> (05/01/03 1.2034.85.39)
   [ALSA] [trivial] Fix compile warning
   
   Intel8x0 driver
   Fix compile warning abount unused variables.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/01/03 1.2034.85.38)
   [ALSA] Fix non-symmetrical page_attr changes
   
   Intel8x0 driver
   Fixed non-symmetrical calls of change_page_attr() which may cause BUG().
   This bug happens only on 440MX.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/01/03 1.2034.85.37)
   [ALSA] Add missing USX2Y_PCM hwdep entry
   
   ALSA Core
   Added the missing SNDRV_HWDEP_IFACE_USX2Y_PCM definition.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/01/03 1.2034.85.36)
   [ALSA] Add missing source codes in the last hwdep-pcm patch.
   
   USB USX2Y
   The missing source files in the last hwdep-pcm patch are added.
   
   Signed-off-by: Karsten Wiese <annabellesgarden@yahoo.de>
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/01/03 1.2034.85.35)
   [ALSA] hwdep interface for pcm data
   
   USB,USB USX2Y
   Implements 'rawusb' pcm data transfer through hwdep interface:
   The usb_hc moves pcm data from/into memory via DMA.
   That memory is mmaped by jack's usx2y driver.
   Jack's usx2y driver is the first/last executable code to read/write pcm data.
   Read/write is a combination of power of 2 period shaping and float/int
   conversation.
   
   Compared to standard alsa/jack we leave out power of 2 period shaping
   inside snd-usb-usx2y which needs memcpy() and additional buffers.
   As a side effect possible unwanted pcm-data coruption resulting of
   standard alsa's snd-usb-usx2y period shaping scheme falls away.
   Result is sane jack operation at buffering schemes down to 128frames,
   2 periods.
   
   Also changed Kconfig file, so snd-usb-usx2y is only available for X86,
   PPC or ALPHA platforms, as on others DMA-memory isn't mmapable.
   
   Signed-off-by: Karsten Wiese <annabellesgarden@yahoo.de>
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/01/03 1.2034.85.34)
   [ALSA] Fix detection of Xbox
   
   AC97 Codec Core
   Unfortunately, on newer xboxes, the chip reports less info than
   before, making another change necessary - this change is backwards
   compatible, and doesn't break earlier xboxes, of course.
   
   The patch is originally from Ed Hucek <hostmaster@ed-soft.at>.
   
   Signed-off-by: David Pye <dmp@davidmpye.dyndns.org>
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/01/03 1.2034.85.33)
   ALSA CVS update
   ENS1370/1+ driver
   Trivial patch to enable rear out selection for ens1373 on
   the Gigabyte GA-8IEXP motherboard.
   
   Signed-off-by: Andrew Dennison <andrew-lists@optusnet.com.au>
   Signed-off-by: Jaroslav Kysela <perex@suse.cz>

<perex@suse.cz> (05/01/03 1.2034.85.32)
   [ALSA] misc cleanups
   
   OPL3,Digigram VX core,I2C cs8427,SoundFont,Common EMU synth
   The patch below contains the following changes in ALSA code not touched
   by my previous patches:
   - make some needlessly global code static
   - remove the following unused global functions:
     - sound/i2c/cs84: snd_cs8427_detect
     - sound/synth/emux/emux_synth.c: snd_emux_release_voice
     - sound/synth/emux/soundfont.: snd_soundfont_mem_used
   - remove the following unused EXPORT_SYMBOL's:
     - sound/i2c/cs8427.c: snd_cs8427_detect
     - sound/i2c/cs8427.c: snd_cs8427_reg_read
   
   Signed-off-by: Adrian Bunk <bunk@stusta.de>
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/01/03 1.2034.85.31)
   [ALSA] Add 'Duplicate Front' control
   
   CS46xx driver
   A new mixer control 'Duplicate Front' is added for the board with
   a single codec.  This toggles the duplication of front signal to
   the rear speakers.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/01/03 1.2034.85.30)
   [ALSA] opl4 depends on opl3
   
   OPL3
   Compiling OPL4 doesn't include the snd-opl3-lib. This change in the
   Makefile enables now the compiling of snd-opl3-lib.o for OPL4 soundcards.
   
   Signed-off-by: Martin Langer <martin-langer@gmx.de>
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/01/03 1.2034.85.29)
   [ALSA] Update user-space access from sscape driver
   
   Sound Scape driver
   I see that the copy_to/from_user() functions have been updated across
   Linux 2.4 and 2.6, and that verify_read/write() has been replaced by
    access_ok(). I have patched the SoundScape driver accordingly.
   
   Signed-off-by: Chris Rankin <rankincj@yahoo.com>
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/01/03 1.2034.85.28)
   [ALSA] disable legacy IRQs before request_irq() to avoid unhandled interrupts
   
   VIA82xx driver
   
   
   Signed-off-by: Christian Koerner <ckoerner@sysgo.com>
   Signed-off-by: Jaroslav Kysela <perex@suse.cz>

<perex@suse.cz> (05/01/03 1.2034.85.27)
   [ALSA] IEC958 Capture mixer controls and Universe support
   
   ICE1712 driver,ICE1724 driver
    * Added SPI read routine
    * Added IEC958 Capture mixer controls
    * Improved Universe support
    * Headphone Amp renamed to External Amplifier
    * Fixed GPIO bug in Prodigy code (There is no GPIO23 on ICE1724)
   
   Signed-off-by: Peter Christensen <peter@developers.dk>
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/01/03 1.2034.85.26)
   [ALSA] Fix sleep in h/w volume control
   
   ES1968 driver
   Fixed sleeps in h/w volume control tasklet.
   Also, msleep()s in ac97 accessor callbacks are removed since the chip
   works without such delays.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/01/03 1.2034.85.25)
   [ALSA] Use macro usb_maxpacket() for portability
   
   USB USX2Y
   In future kernels struct usb_device won't have the epmaxpacketin/out members.
   Use macro usb_maxpacket() instead of directly accessing those members.
   
   Signed-off-by: Karsten Wiese <annabellesgarden@yahoo.de>
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/01/03 1.2034.85.24)
   [ALSA] Remove the NULL pointer check in kfree/vfree wrappers
   
   ALSA Core
   The check of NULL pointer in kfree/vfree wrappers is removed.
   kfree() and vfree() accept NULL pointer.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/01/03 1.2034.85.23)
   [ALSA] Added VIA82xx-modem driver
   
   Documentation,PCI drivers,VIA82xx-modem driver
   Added the VIA82xx AC97 modem driver by Sasha Khapyorsky <sashak@smlink.com>.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/01/03 1.2034.85.22)
   [ALSA] ALSA core: misc cleanups
   
   HWDEP Midlevel,ALSA Core,PCM Midlevel,RawMidi Midlevel
   ALSA<-OSS emulation,ALSA sequencer,ALSA<-OSS sequencer
   The patch below does the following cleanups under sound/core/ :
   - make needlessly global code static
   - remove the following stale prototypes from pcm.h
     (the functions are not or no longer present):
     - snd_pcm_capture_ready_jiffies
     - snd_pcm_playback_ready_jiffies
   - remove the following unused global functions:
     - oss/pcm_plugin.c: snd_pcm_plug_capture_channels_mask
     - seq/seq_instr.c: snd_seq_cluster_new
     - seq/seq_instr.c: snd_seq_cluster_free
   - move global to static inline functions
     - pcm_lib.c: snd_pcm_playback_ready
     - pcm_lib.c: snd_pcm_capture_ready
     - pcm_lib.c: snd_pcm_playback_empty
     - pcm_lib.c: snd_pcm_capture_empty
     - pcm_lib.c: snd_pcm_playback_data
   - remove the following unused EXPORT_SYMBOL's:
     - snd_create_proc_entry
     - snd_interval_ratden
     - snd_midi_channel_init
     - snd_midi_channel_init_set
     - snd_pcm_playback_empty
     - snd_pcm_capture_empty
     - snd_pcm_playback_data
     - snd_pcm_capture_poll
     - snd_pcm_playback_ready
     - snd_pcm_capture_ready
     - snd_pcm_format_size
     - snd_pcm_open
     - snd_pcm_playback_poll
     - snd_pcm_playback_ready
     - snd_pcm_release
     - snd_pcm_subformat_name
     - snd_remove_proc_entry
   
   Signed-off-by: Adrian Bunk <bunk@stusta.de>
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/01/03 1.2034.85.21)
   [ALSA] check __copy_to_user in sscape_upload_bootblock()
   
   Sound Scape driver
   __copy_to_user() is called without checking its return value in
   sound/isa/sscape.c::sscape_upload_bootblock .
   
   Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/01/03 1.2034.85.20)
   [ALSA] ifdef typos: sound_isa_es18xx.c
   
   ES18xx driver
   Changed CONFIG_PNP_ to CONFIG_PNP, also fixed a comment related to
   another CONFIG_PNP.
   
   Signed-off-by: Domen Puncer <domen@coderock.org>
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/01/03 1.2034.85.19)
   [ALSA] ifdef typos: sound_isa_cs423x_cs4231_lib.c
   
   CS4231 driver
   Funny typo.
   
   Acked-by: Randy Dunlap <rddunlap@osdl.org>
   
   Signed-off-by: Domen Puncer <domen@coderock.org>
   Signed-off-by: Maximilian Attems <janitor@sternwelten.at>
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/01/03 1.2034.85.18)
   [ALSA] Fix interface type for some mixer controls
   
   RME96 driver
   The interface type of some basic mixer controls is changed from
   IFACE_PCM to IFACE_MIXER so that it can be accessed from mixer apps.
   
   Signed-off-by: Peter Chrisensen <peter@developers.dk>
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/01/03 1.2034.85.17)
   [ALSA] Fix the interface type of mixer controls
   
   RME32 driver
   The patch will change SNDRV_CTL_ELEM_IFACE_PCM to
   SNDRV_CTL_ELEM_IFACE_MIXER for some mixer elements of rme32.
   
   Signed-off-by: Martin Langer <martin-langer@gmx.de>
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/01/03 1.2034.85.16)
   [ALSA] [trivial] Fix compilation warnings on 64bit
   
   SPARC cs4231 driver
   Fixed the compilation warnings about the pointer size.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/12/21 1.2034.85.15)
   [ALSA] Fix targets for GUS and OPL4
   
   ALSA sequencer
   The the obj targets for GUS and OPL4 are fixed.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/12/21 1.2034.85.14)
   [ALSA] Clean up of kfree()/vfree() NULL checks
   
   ALSA Core,PCM Midlevel,Memalloc module,Timer Midlevel,IOCTL32 emulation
   ALSA<-OSS emulation,ALSA sequencer,ALSA<-OSS sequencer,I2C cs8427
   L3 drivers,GUS Library,EMU8000 driver,Wavefront drivers,Maestro3 driver
   AC97 Codec Core,ALI5451 driver,CS46xx driver,EMU10K1/EMU10K2 driver
   ICE1712 driver,Trident driver,YMFPCI driver,PPC PMAC driver
   Common EMU synth,USB generic driver,USB USX2Y
   I've cleaned up sound/ directory from 'if (x) {k/v}free(x);' and similar
   constructions. I'm going to to this for most of the kernel if I found
   some time.
   
   Signed-off-by: Marcel Sebek <sebek64@post.cz>
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/12/21 1.2034.85.13)
   [ALSA] Fix ioctl32 wrapper (for SPARC)
   
   IOCTL32 emulation
   Fix ioctl32 wrapper design, using compat_alloc_user_space() now.
   This will fix the crash on SPARC64.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/12/21 1.2034.85.12)
   [ALSA] Export functions for ioctl32 wrapper
   
   Control Midlevel,PCM Midlevel,ALSA Core
   Export some functions to access from ioctl32 wrapper.
   This will reduce the memory footprint (doublly kmalloc's for the same
   ioctl records).
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/12/21 1.2034.85.11)
   [ALSA] Fix compilation without CONFIG_PM
   
   AC97 Codec Core
   Fixed the compilation without CONFIG_PM.
   The resume callback is built only with CONFIG_PM.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/11/29 1.2034.2.80)
   [ALSA] alternate CS4235 ident string
   
   CS4236+ driver
   The patch adds an alternate CS4235 ident string
   
   Signed-off-by: Pang Lih Wuei <basic@mozdev.org>
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/11/29 1.2034.2.79)
   [ALSA] alternate ALS0200 ident string
   
   ALS100 driver
   The patch adds an alternate ALS0200 ident string
   
   Signed-off-by: Pang Lih Wuei <basic@mozdev.org>
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/11/29 1.2034.2.78)
   [ALSA] Disable 'IEC958 Input Monitor' switch for ALC codecs
   
   AC97 Codec Core
   'IEC958 Input Monitor' switch for ALC codecs produces only the
   cracky noises, and KDE seems to turn this on as default in the
   initialization.
   So, better to remove this switch.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/11/29 1.2034.2.77)
   [ALSA] ALSA ISA drivers: misc cleanups
   
   AD1848 driver,CS4231 driver,ES1688 driver,GUS Library,SB drivers
   Wavefront drivers,ES18xx driver,OPL3SA2 driver,AD1816A driver
   Opti9xx drivers,SB16/AWE driver,SB8 driver
   The patch below makes cleanups under sound/isa/ including:
   - make needlessly global code static
   - ad1816a/ad1816a_lib.c: much code was unused starting with the
                            global function snd_ad1816a_timer
   - removed EXPORT_SYMBOL's:
     - cs423x/cs4231_lib.c: snd_cs4231_outm
     - es1688/es1688_lib.c: snd_es1688_mixer_read
   
   Signed-off-by: Adrian Bunk <bunk@stusta.de>
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/11/29 1.2034.2.76)
   [ALSA] misc clean up
   
   Intel8x0 driver
   Clean up the module init code after removal of midi/joystick support.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/11/29 1.2034.2.75)
   [ALSA] fix weird placement of static keyword in sound/core/pcm_memory.c
   
   PCM Midlevel
   This patch moves the 'static' keyword to the beginning of the declaration
   to eliminate the following warning when building with gcc -W
   sound/core/pcm_memory.c:40: warning: 'static' is not at beginning of declaration
   
   This has no actal imact on the code, but it's one less warning to sift
   through when looking for potential trouble-code with -W
   I have a hard time thinking of a reason to not apply this trivial patch :)
   
   Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/11/29 1.2034.2.74)
   [ALSA] Fix the detection of Audigy2 ZS
   
   EMU10K1/EMU10K2 driver
   Fix the detection of the older model of Audigy2 ZS.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/11/29 1.2034.2.73)
   [ALSA] [trivial] Fix compile warnings
   
   ALSA Core,CS46xx driver,MIXART driver
   Fix trivial compile warnings.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/11/29 1.2034.2.72)
   [ALSA] Fixed problem with changing size of etram
   
   EMU10K1/EMU10K2 driver
   It doesn't work to double the etram size, because of a bad comparison
   statement.
   
   Signed-off-by: Mikael Magnusson <mikma@users.sourceforge.net>
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/11/29 1.2034.2.71)
   [ALSA] add register dump to proc
   
   EMU10K1/EMU10K2 driver
   The register dump proc files are added.
   Enabled only when CONFIG_SND_DEBUG=y.
   
   Signed-off-by: James Courtier-Dutton
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/11/29 1.2034.2.70)
   [ALSA] check CONFIG_COMPAT for snd-ioctl32
   
   ALSA Core
   check CONFIG_COMPAT for selection of snd-ioctl32 module.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/11/29 1.2034.2.69)
   [ALSA] make some code static
   
   Sound Core PDAudioCF driver
   The patch below makes some needlessly global code static.
   
   Signed-off-by: Adrian Bunk <bunk@stusta.de>
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/11/29 1.2034.2.68)
   [ALSA] Support for Audigy2 Value SB0400
   
   EMU10K1/EMU10K2 driver
   This adds support for the SB0400 version of the Audigy2 Value, that uses
   the new CA0108 chip.
   
   Signed-off-by: James Courtier-Dutton
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/11/29 1.2034.2.67)
   [ALSA] Fixes the 'It disables the right channel' bug
   
   EMU10K1/EMU10K2 driver
   
   
   Signed-off-by: James Courtier-Dutton
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/11/29 1.2034.2.66)
   [ALSA] ALSA PCI drivers: misc cleanups
   
   EMU10K1/EMU10K2 driver,Trident driver,YMFPCI driver,AZT3328 driver
   SonicVibes driver,AC97 Codec Core,CS46xx driver,KORG1212 driver
   RME HDSP driver,RME9652 driver
   The patch below does the following cleanups under sound/pci/ :
   - make some needlessly global code static
   - remove the following unused EXPORT_SYMBOL's:
     - trident/trident_main.c: snd_trident_clear_voices
     - trident/trident_main.c: snd_trident_synth_bzero
   - remove the following unused global functions:
     - azt3328.c: snd_azf3328_mixer_read
     - emu10k1/io.c: snd_emu10k1_sum_vol_attn
     - trident/trident_main.c: snd_trident_detach_synthesizer
     - trident/trident_memory.c: snd_trident_synth_bzero
   
   Signed-off-by: Adrian Bunk <bunk@stusta.de>
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/11/29 1.2034.2.65)
   [ALSA] fix display of send routing in /proc
   
   EMU10K1/EMU10K2 driver
   The emu10k1's send routing is a per channel setting.  The emu10k1 has 4
   sends per channel, the Audigy 8.  Currently we only display the first 4
   sends for the first channel.  This patch updates the /proc file to
   display the send routing for all 64 channels, and to display the last 4
   sends if present.
   
   Signed-off-by: Lee Revell <rlrevell@joe-job.com>
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/11/29 1.2034.2.64)
   [ALSA] AD18xx/19xx resume fix
   
   AC97 Codec Core
   Added resume callback so that the codec-specific resume code can be
   called properly.  Moved AD-specific initialization code into it.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/11/29 1.2034.2.63)
   [ALSA] sort DXS whitelist
   
   VIA82xx driver
   DXS whitelist entries are sorted.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/11/29 1.2034.2.62)
   [ALSA] via82xx: Enable DXS on ABIT KV8 Pro
   
   VIA82xx driver
   From Marko Kreen <marko@l-t.ee>:
   
   Enable DXS for via audio chip on ABIT KV8 Pro.
   
   Works for me.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/11/29 1.2034.2.61)
   [ALSA] Addition of pci_disable_device() and cleanup
   
   Documentation
   Added pci_disable_device() in the removal and error paths.
   Replaced with C-style comments in many places.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/11/29 1.2034.2.60)
   [ALSA] Add pci_disable_device() to removal and error paths
   
   ALS4000 driver,ATIIXP driver,ATIIXP-modem driver,AZT3328 driver
   BT87x driver,CMIPCI driver,CS4281 driver,ENS1370/1+ driver
   ES1938 driver,ES1968 driver,FM801 driver,Intel8x0 driver
   Intel8x0-modem driver,Maestro3 driver,RME32 driver,RME96 driver
   SonicVibes driver,VIA82xx driver,ALI5451 driver,CS46xx driver
   EMU10K1/EMU10K2 driver,ICE1712 driver,ICE1724 driver,KORG1212 driver
   MIXART driver,NM256 driver,RME HDSP driver,RME9652 driver
   Trident driver,Digigram VX222 driver,YMFPCI driver
   pci_disable_device() is called properly in the removal and error
   paths.  Also, the pci_set_master() is added to the resume callbacks if
   missing (just to be sure).
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/11/29 1.2034.2.59)
   [ALSA] whitespace cleanup
   
   EMU10K1/EMU10K2 driver
   
   
   Signed-off-by: Lee Revell <rlrevell@joe-job.com>
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/11/29 1.2034.2.58)
   [ALSA] minor send routing cleanup
   
   EMU10K1/EMU10K2 driver
   Use snd_emu10k1_compose_audigy_fxrt* macro where appropriate.  Also add
   a few comments to explain send routing structure.
   
   Signed-off-by: Lee Revell <rlrevell@joe-job.com>
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/11/29 1.2034.2.57)
   [ALSA] fix chorus/reverb FX loader
   
   EMU8000 driver
   Fixed the chorus/reverb FX loader callback.
   The header bytes must be eliminated.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/11/29 1.2034.2.56)
   [ALSA] fix MIDI GS chorus/reverb mode
   
   ALSA sequencer
   Fixed the parsing of MIDI GS chorus/reverb mode SYSEX messages.
   They were swapped.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/11/29 1.2034.2.55)
   [ALSA] fix iomem mmap
   
   PCM Midlevel
   The patch adds the definition vm_private_data again to
   snd_pcm_lib_mmap_iomem(). It got lost during the rewrite of
   the mmap stuff.
   
   Signed-off-by: Martin Langer <martin-langer@gmx.de>
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/11/29 1.2034.2.54)
   [ALSA] add Line/Headphone jack detection for AD1981A/B
   
   AC97 Codec Core
   Line/Headphone Jack Sense mixer switches are added to
   AD1981A/B.
   
   HP sense is activated as default.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/11/29 1.2034.2.53)
   [ALSA] Add pci_save_state() in suspend
   
   ALSA Core
   Added pci_save_state() in the ALSA suspend core callback since
   its call was removed from the PCI core driver in the recent
   version.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/11/29 1.2034.2.52)
   [ALSA] fix sleep in atomic during prepare callback
   
   Intel8x0 driver
   Fixed the sleep in spinlock during prepare callback.
   This happened only on Nforce chips.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/11/29 1.2034.2.51)
   [ALSA] AC97 quirks for Dell
   
   Intel8x0 driver
   Added ac97 quirks for some dell machines.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/11/29 1.2034.2.50)
   [ALSA] Fix WM8770 Init
   
   ICE1712 driver
   Corrects WM8770 ADC mux initialization
   
   Signed-off-by: Peter Christensen <peter@developers.dk>
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/11/29 1.2034.2.49)
   [ALSA] Fix the missing line in the patch for hdsp accurate_ptr
   
   RME HDSP driver
   Fixed missing line in the patch for hdsp accurate_ptr.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/11/11 1.2034.2.48)
   ALSA 1.0.7

<perex@suse.cz> (04/11/11 1.2034.2.47)
   [ALSA] nonblock_open=1 by default for OSS PCM API emulation
   
   Documentation,ALSA<-OSS emulation
   
   
   Signed-off-by: Jaroslav Kysela <perex@suse.cz>

<perex@suse.cz> (04/11/11 1.2034.2.46)
   [ALSA] fix parsing of mixer unit descriptors
   
   USB generic driver
   MU descriptor parsing code completely rewritten; the old code confused
   the number of input audio channel clusters and the number of input
   channels.  Furthermore, check all bmControls bits so that mixer
   controls are created even if the first output channel doesn't have
   a control.
   
   Signed-off-by: Clemens Ladisch <clemens@ladisch.de>

<perex@suse.cz> (04/11/11 1.2034.2.45)
   [ALSA] read bmControls array in correct order
   
   USB generic driver
   The driver used some code from audio.c that reads the bmControl array
   backwards; this would not work here as we get a pointer to the
   beginning of the array.
   
   Signed-off-by: Clemens Ladisch <clemens@ladisch.de>

<perex@suse.cz> (04/11/11 1.2034.2.44)
   [ALSA] handle missing control bitmap when parsing MUDs
   
   USB generic driver
   The AudioTrak Maya44 USB has a mixer unit descriptor without a
   bmControl field; handle this as if all bits are zero.
   
   Signed-off-by: Clemens Ladisch <clemens@ladisch.de>

<perex@suse.cz> (04/11/11 1.2034.2.43)
   [ALSA] emu10k1 - fixed remaining problems with new DSP code loading
   
   EMU10K1/EMU10K2 driver
   
   
   Signed-off-by: Jaroslav Kysela <perex@suse.cz>

<perex@suse.cz> (04/11/11 1.2034.2.42)
   [ALSA] [emu10k1] add interval timer support
   
   EMU10K1/EMU10K2 driver
   
   
   Signed-off-by: Lee Revell <rlrevell@joe-job.com>
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/11/11 1.2034.2.41)
   [ALSA] Fixed issues with Abit AV8
   
   VIA82xx driver
   Added Abit AV8 sound card to the white list to use
   VIA_DXS_NO_VRA by default. This resolves issues with
   programs wanting to use 41k streams. It also fixes
   gstreamer issue with alsasink module interaction.
   
   Signed-off-by: Jerone Young <jerone@gmail.com>
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/11/11 1.2034.2.40)
   [ALSA] Add subvendor ID to the pci id table of vx222 driver
   
   Digigram VX222 driver
   The subsystem ID is added to the pci id table of vx222 driver
   to make the matching more strict since it (PLX) conflicts with
   other devices.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/11/11 1.2034.2.39)
   [ALSA] removes unneeded spin_lock_irqsave()s from snd-es1968
   
   ES1968 driver
   spin_lock_irqsave(&chip->reg_lock) was called a second time in sequence from
   snd_es1968_bob_start() called from es1968_measure_clock().
   While this didn't cause harm on my UP laptop with mainline kernels,
   it made 'insmod snd-es1968' hang on kernel 2.6.9-mm1-RT-V0.6.9.
   The patch assumes that 2 callpaths don't need explicit spinlock protection:
   1: The trigger callback, because it is called with IRQs disabled.
   2. PM's suspend/resume callbacks, because  those are called while ortdinary
      user processes are frozen.
      Thus the spin_lock_irqsave(&chip->reg_lock)  calls in snd_es1968_bob_start()
      / snd_es1968_bob_stop() are not needed.
   
   Signed-off-by: Karsten Wiese <annabellesgarden@yahoo.de>
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/11/11 1.2034.2.38)
   [ALSA] Fixed the description of module_parm_array()
   
   Documentation
   Fixed the description about module_param_array() for the latest change.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (04/11/11 1.2034.2.37)
   [ALSA] remove snd_seq_simple_id
   
   Instrument layer,GUS Library,Trident driver
   remove uses of the snd_seq_simple_id symbol because it is
   no longer exported
   
   Signed-off-by: Clemens Ladisch <clemens@ladisch.de>

<perex@suse.cz> (04/11/11 1.2034.2.36)
   [ALSA] Added SNDRV_HWDEP_IFACE_BLUETOOTH
   
   ALSA Core
   
   
   Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
   Signed-off-by: Jaroslav Kysela <perex@suse.cz>

<perex@suse.cz> (04/11/11 1.2034.2.35)
   [ALSA] emu10k1 - another attempt to correct the new emufx DSP code
   
   EMU10K1/EMU10K2 driver
   
   
   Signed-off-by: Jaroslav Kysela <perex@suse.cz>

<perex@suse.cz> (04/11/11 1.2034.2.34)
   [ALSA] replace schedule_timeout() with msleep()
   
   SPARC cs4231 driver
   Uses msleep() instead of schedule_timeout() to guarantee the task
   delays as expected.
   
   Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
   Signed-off-by: Clemens Ladisch <clemens@ladisch.de>

<perex@suse.cz> (04/11/11 1.2034.2.33)
   [ALSA] replace schedule_timeout() with msleep()
       
   CS4231 driver
   Uses msleep() instead of schedule_timeout() to guarantee
   the task delays as expected. This lead to several related changes, as
   the current code assumes the value of HZ is 100. Use timeout as an
   iteration variable to count out how many 10ms delays should be used.
       
   Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
   Signed-off-by: Clemens Ladisch <clemens@ladisch.de>

<perex@suse.cz> (04/10/30 1.2026.56.2)
   [ALSA] emu10k1 - fixes against the last emufx changes
   
   EMU10K1/EMU10K2 driver
   The indirect pointers are allocated correctly now for default DSP code.
   Also, one bug in emu10k1_fx8010_code_t has been fixed as well.
   
   Signed-off-by: Jaroslav Kysela <perex@suse.cz>

<perex@suse.cz> (04/10/29 1.2026.53.16)
   [ALSA] fixed emu10k1_fx8010_code_t structure to be less than 8192 bytes
   
   EMU10K1/EMU10K2 driver
   This patch fixes emu10k1_fx8010_code_t structure using indirect pointers
   to be less than 8192 bytes to follow the ioctl semantics.
   
   Signed-off-by: Jaroslav Kysela <perex@suse.cz>

<perex@suse.cz> (04/10/29 1.2026.53.15)
   [ALSA] remove kernel version info from proc file
   
   ALSA Core
   The kernel version information isn't necessary for the driver
   in the kernel tree, so move it to the alsa-driver package.
   
   This removes a dependency to <linux/version.h>.
   
   Signed-off-by: Clemens Ladisch <clemens@ladisch.de>

<perex@suse.cz> (04/10/29 1.2026.53.14)
   [ALSA] Limit parity error messages
   
   BT87x driver
   Some systems generate tons of PCI parity errors, so shut up
   when more than 20 have been detected.
   
   Signed-off-by: Clemens Ladisch <clemens@ladisch.de>

<perex@suse.cz> (04/10/29 1.2026.53.13)
   [ALSA] remove dead exports
   
   ALSA Core,Instrument layer,AD1848 driver,ES1688 driver
   Alsa currently has tons of dead exports, often with totally unused
   functions behind them.
   This removes some of them.
   
   Signed-off-by: Christoph Hellwig <hch@lst.de>
   Signed-off-by: Clemens Ladisch <clemens@ladisch.de>

<perex@suse.cz> (04/10/29 1.2026.53.12)
   [ALSA] remove old compatibility code
   
   USB USX2Y
   
   
   Signed-off-by: Clemens Ladisch <clemens@ladisch.de>

<perex@suse.cz> (04/10/29 1.2026.53.11)
   [ALSA] fix data type mismatch in sign_invert
   
   au88x0 driver
   the last sign_invert cleanup introduced a data type mismatch
   (an unsigned value can never be negative)
   
   Signed-off-by: Clemens Ladisch <clemens@ladisch.de>

<perex@suse.cz> (04/10/29 1.2026.53.10)
   [ALSA] au88x0: comment and whitespace cleanup
   
   au88x0 driver
   Remove an obsolete comment and cleanup up some whitespace a bit
   
   Signed-off-by: Jeff Muizelaar <muizelaar@rogers.com>
   Signed-off-by: Jaroslav Kysela <perex@suse.cz>

<perex@suse.cz> (04/10/29 1.2026.53.9)
   [ALSA] au88x0: name typo
   
   au88x0 driver
   Fix the spelling of my name
   
   Signed-off-by: Jeff Muizelaar <muizelaar@rogers.com>
   Signed-off-by: Jaroslav Kysela <perex@suse.cz>

<perex@suse.cz> (04/10/29 1.2026.53.8)
   [ALSA] au88x0: sign_invert cleanup
   
   au88x0 driver
   Remove unecessary ' & 0xffff'ing of the result of sign_invert
   
   Signed-off-by: Jeff Muizelaar <muizelaar@rogers.com>
   Signed-off-by: Jaroslav Kysela <perex@suse.cz>

<perex@suse.cz> (04/10/29 1.2026.53.7)
   [ALSA] au88x0: set-levels cleanup
   
   au88x0 driver
   Cleanup vortex_EqHw_SetLevels and add a bit of documentation
   
   Signed-off-by: Jeff Muizelaar <muizelaar@rogers.com>
   Signed-off-by: Jaroslav Kysela <perex@suse.cz>

<perex@suse.cz> (04/10/29 1.2026.53.6)
   [ALSA] au88x0: fix is-quad oops
   
   au88x0 driver
   Fixes an oops on module removal caused by dereferencing the codec pointer.
   This is not the best solution, but it is the easiest and fixes things for
   now.
   
   Signed-off-by: Jeff Muizelaar <muizelaar@rogers.com>
   Signed-off-by: Jaroslav Kysela <perex@suse.cz>

<perex@suse.cz> (04/10/29 1.2026.53.5)
   [ALSA] au88x0: add resetup dma
   
   au88x0 driver
   Add adbdma_resetup for refreshing the hw page table on pcm start
   
   Signed-off-by: Jeff Muizelaar <muizelaar@rogers.com>
   Signed-off-by: Jaroslav Kysela <perex@suse.cz>

<perex@suse.cz> (04/10/29 1.2026.53.4)
   [ALSA] snd-usb-usx2y - crash fix for OHCI USB-HCDs
   
   USB USX2Y
   Version: 0.8.6
   Work on this started, when rumors spread that OHCI equipped machines would
   crash. This was due to me missing two facts:
   1) Ohci has a bigger usb frame number wrap around.
   2) It only supports URB_ISO_ASAP when submitting iso urbs.
   These issues are fixed now.
   
   Signed-off-by: Karsten Wiese <annabellesgarden@yahoo.de>
   Signed-off-by: Jaroslav Kysela <perex@suse.cz>

<perex@suse.cz> (04/10/29 1.2026.53.3)
   [ALSA] rearrange OSS SPARC dependencies
   
   Sound Core
   rearrange the SPARC symbols in the OSS dependencies to
   prevent alsa-driver's mod-deps from throwing up
   
   Signed-off-by: Clemens Ladisch <clemens@ladisch.de>

<perex@suse.cz> (04/10/29 1.2026.53.2)
   [ALSA] fix sequencer sleeping in interrupt context
   
   ALSA sequencer,ALSA<-OSS sequencer
   
   
   Signed-off-by: Clemens Ladisch <clemens@ladisch.de>

<perex@suse.cz> (04/10/29 1.2026.53.1)
   [ALSA] use blacklist/whitelist for (non-)audio Bt878 cards
   
   Documentation,PCI drivers,BT87x driver
   Some Bt87x cards use PCI function 1 for MPEG data instead of
   audio data, so we blacklist those in the audio driver.
   
   Further add a whitelist for cards where audio is known to work
   (many other cards do not implement the audio connection).
   Unknown cards can be enabled manually.
   
   Signed-off-by: Clemens Ladisch <clemens@ladisch.de>


-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs
