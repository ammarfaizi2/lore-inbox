Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129065AbRBWOfN>; Fri, 23 Feb 2001 09:35:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129066AbRBWOfE>; Fri, 23 Feb 2001 09:35:04 -0500
Received: from mailgate.rz.uni-karlsruhe.de ([129.13.64.97]:16913 "EHLO
	mailgate.rz.uni-karlsruhe.de") by vger.kernel.org with ESMTP
	id <S129065AbRBWOeu>; Fri, 23 Feb 2001 09:34:50 -0500
To: linux-sound@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] (2.4.2) aci.c, radio-miropcm20.c for miroSOUND cards
From: Robert Siemer <Robert.Siemer@gmx.de>
X-Mailer: Mew version 1.94b25 on Emacs 20.5 / Mule 4.0 (HANANOEN)
Reply-To: Robert Siemer <siemer@panorama.hadiko.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20010223153203L.siemer@panorama.hadiko.de>
Date: Fri, 23 Feb 2001 15:32:03 +0100
X-Dispatcher: imput version 990425(IM115)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

The patch is for miroSOUND sound cards. The corresponding driver files
are aci.c and radio-miropcm20.c

The latest is for 2.4.2 and can be found on:
http://www.uni-karlsruhe.de/~Robert.Siemer/Private/
http://www.uni-karlsruhe.de/~Robert.Siemer/Private/aci-2.4.2.patch
(61kB)

Changes: 
aci.c
  -general clean-up and rewrite of aci.c for 2.4.x 
  -added SMP safe locking 
  -ioctl pointer bugfix 
  -added (OSS-limited) equalizer support 
  -better distinction of PCM1/PCM12/PCM20 for good
           mixer-labeling/mic-preamp/output-amplification handling 
  -threw mad16 dependence away: no mixer-number hack anymore 
  -'solo' mode doesn't need some private ioctl() anymore 
radio-miropcm20.c 
  -removed unclear volume handling (maybe I add it later again) 
  -added stereo/corrected mute handling 
  -tune-ioctl() pays attention to different aci-versions 
  -introduced TUNER_LOW for 50kHz steps 
  -integrated lowlevel RDS routines, currently only for finegrained
           signal strength value 
other changes 
  -documentation updates/corrections 



Bye,
	Robert
