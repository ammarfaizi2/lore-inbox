Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262141AbSJFTeV>; Sun, 6 Oct 2002 15:34:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262144AbSJFTeV>; Sun, 6 Oct 2002 15:34:21 -0400
Received: from gate.perex.cz ([194.212.165.105]:16136 "EHLO gate.perex.cz")
	by vger.kernel.org with ESMTP id <S262141AbSJFTeT>;
	Sun, 6 Oct 2002 15:34:19 -0400
Date: Sun, 6 Oct 2002 21:38:54 +0200 (CEST)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: <perex@pnote.perex-int.cz>
To: Linus Torvalds <torvalds@transmeta.com>
cc: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] ALSA update
Message-ID: <Pine.LNX.4.33.0210062136590.503-100000@pnote.perex-int.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please do a

	bk pull http://linux-sound.bkbits.net/linux-sound

This will update the following files:

 include/sound/version.h             |    2 
 sound/core/info.c                   |    6 
 sound/core/sound.c                  |    9 
 sound/isa/sgalaxy.c                 |   21 -
 sound/pci/Config.in                 |    4 
 sound/pci/cs46xx/dsp_spos.c         |    1 
 sound/pci/cs46xx/dsp_spos_scb_lib.c |    1 
 sound/sound_core.c                  |   15 -
 sound/usb/usbaudio.c                |  183 +++++++++-----
 sound/usb/usbaudio.h                |   29 +-
 sound/usb/usbmidi.c                 |  395 ++++++++++++++++++++++++-------
 sound/usb/usbquirks.h               |  451 ++++++++++++++++++++++++------------
 12 files changed, 770 insertions(+), 347 deletions(-)

through these ChangeSets:

<perex@suse.cz> (02/10/05 1.696.1.3)
   ALSA update
     - updated config descriptions for EMU10K1 and INTEL8X0

<perex@suse.cz> (02/10/05 1.696.1.2)
   ALSA update
     - CS46xx driver - removed unused variable
     - USB code
       - pass struct usb_interface pointer to the usb-midi parser.
         in usb-midi functions, this instance is used instead of parsing
         the interface from dev and ifnum.
       - allocate the descriptor buffer only for parsing the audio device.
       - clean up, new probe/disconnect callbacks for 2.4 API.
       - added the support for Yamaha and Midiman devices.                                                  

<perex@suse.cz> (02/10/04 1.696.1.1)
   ALSA
     - DEVFS cleanup - removal of compatibility code for 2.2 and 2.4 kernels
     - fixed sgalaxy driver (save_flags/cli/restore_flags removal)
     - USB Audio driver
       - added the missing dev_set_drvdata() for 2.5 API
       - simplified the conexistence of old and new USB APIs
       - don't skip the active capture urbs
       - added the debug print for active capture urbs
       - don't change runtime->rate even if the current rate is not same
       - check the bandwidth for urbs (for tests only, now commented out)


						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project  http://www.alsa-project.org
SuSE Linux    http://www.suse.com

