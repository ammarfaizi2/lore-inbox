Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261932AbVANRZe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261932AbVANRZe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 12:25:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262033AbVANRZd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 12:25:33 -0500
Received: from gate.perex.cz ([82.113.61.162]:14771 "EHLO mail.perex.cz")
	by vger.kernel.org with ESMTP id S261932AbVANRZK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 12:25:10 -0500
Date: Fri, 14 Jan 2005 18:23:57 +0100 (CET)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: perex@pnote.perex-int.cz
To: Linus Torvalds <torvalds@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH] ALSA 1.0.8
Message-ID: <Pine.LNX.4.58.0501141822270.1757@pnote.perex-int.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please do a

  bk pull http://linux-sound.bkbits.net/linux-sound

The GNU patch is available at:

  ftp://ftp.alsa-project.org/pub/kernel-patches/alsa-bk-2005-01-14.patch.gz

The pull command will update the following files:

 Documentation/sound/alsa/ALSA-Configuration.txt |   52 ++++++++------
 include/sound/ac97_codec.h                      |    1 
 include/sound/version.h                         |    4 -
 sound/core/ioctl32/ioctl32.c                    |   89 ++++--------------------
 sound/core/rawmidi.c                            |    4 -
 sound/pci/ac97/ac97_codec.c                     |   16 +++-
 sound/pci/ac97/ac97_patch.c                     |    9 +-
 sound/pci/atiixp.c                              |   36 +++++----
 sound/pci/ca0106/ca0106_mixer.c                 |    1 
 sound/pci/ca0106/ca0106_proc.c                  |    1 
 sound/pci/intel8x0.c                            |   20 +++++
 sound/pci/mixart/mixart.c                       |    4 -
 12 files changed, 111 insertions(+), 126 deletions(-)

through these ChangeSets:

<perex@suse.cz> (05/01/13 1.1938.477.75)
   ALSA 1.0.8

<perex@suse.cz> (05/01/12 1.1938.477.74)
   [ALSA] Add ac97_quirk option
   
   Documentation,ATIIXP driver
   Added ac97_quirk option like intel and via drivers.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/01/12 1.1938.477.73)
   [ALSA] Fix ctl_read/write ioctl wrappers
   
   IOCTL32 emulation
   Fixed bugs with ctl_read/write ioctls.
   The struct size mismatch due to alignment is fixed.
   The code is also a bit optimized.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/01/12 1.1938.477.72)
   [ALSA] Fix DMA pointer read
   
   ATIIXP driver
   Try to reread DMA pointer register if the value is invalid.
   The register shows bogus values on some broken hardwares.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/01/12 1.1938.477.71)
   [ALSA] Add suspend callback
   
   AC97 Codec Core
   Add suspend callback for each codec patch.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/01/12 1.1938.477.70)
   [ALSA] Remove & from function pointers
   
   AC97 Codec Core
   Remove & from function pointers (it works but not common to add it...)
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/01/12 1.1938.477.69)
   [ALSA] Fixed description about ac97_quirk
   
   Documentation
   Fixed the description about ac97_quirk option.
   Now it accepts string, too.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/01/12 1.1938.477.68)
   [ALSA] Adapt SPDIF Input selection for Realtek ALC658
   
   AC97 Codec Core
   This fixes the SPDIF Input selection for ALC658 as Realtek has
   changed the meaning betweenALC655 and ALC658.
   
   Signed-off-by: Stefan Macher <Stefan.Macher@web.de>
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/01/12 1.1938.477.67)
   [ALSA] Fix Oops at resume
   
   AC97 Codec Core
   Fixed Oops at resume on certain codecs.
   Set null ops when no patch exists or the patch doesn't set build_ops.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/01/12 1.1938.477.66)
   [ALSA] remove compatibility code for 2.2.x kernels
   
   CA0106 driver
   
   
   Signed-off-by: Clemens Ladisch <clemens@ladisch.de>

<perex@suse.cz> (05/01/12 1.1938.477.65)
   [ALSA] Add quirk for HP zv5000
   
   Intel8x0 driver
   Added the quirk for HP zv5000 (mute LED with EAPD).
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/01/12 1.1938.477.64)
   [ALSA] Fix float format support
   
   MIXART driver
   Fixed typos in float format support.
   
   Signed-off-by: Markus Bollinger<bollinger@digigram.com>
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/01/12 1.1938.477.63)
   [ALSA] Fix description of ALSA/OSS device mapping
   
   Documentation
   Fixed the description of ALSA/OSS device mapping.  The direction
   suffix was missing in ALSA devices.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/01/12 1.1938.477.62)
   [ALSA] ac97 quirk entries for HP xw6200 & xw8000
   
   Intel8x0 driver
   Add AC97 quick list entries to snd-intel8x0 for HP xw6200 and xw8000.
   
   Signed-off-by: John W. Linville <linville@tuxdriver.com>
   Signed-off-by: Takashi Iwai <tiwai@suse.de>

<perex@suse.cz> (05/01/12 1.1938.477.61)
   [ALSA] Fix ioctl arguments
   
   RawMidi Midlevel
   Fixed the wrong pointer types passed to get_user() for
   DROP and DRAIN ioctls.
   
   Signed-off-by: Takashi Iwai <tiwai@suse.de>


-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs
