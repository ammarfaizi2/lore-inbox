Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264121AbRFLAxT>; Mon, 11 Jun 2001 20:53:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264135AbRFLAxJ>; Mon, 11 Jun 2001 20:53:09 -0400
Received: from mailgate.rz.uni-karlsruhe.de ([129.13.64.97]:46854 "EHLO
	mailgate.rz.uni-karlsruhe.de") by vger.kernel.org with ESMTP
	id <S264124AbRFLAwy>; Mon, 11 Jun 2001 20:52:54 -0400
Subject: [PATCH] (2.4.5) aci.c, miropcm20*.[c|h] for miroSOUND cards
From: Robert Siemer <Robert.Siemer@gmx.de>
To: linux-sound@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, video4linux-list@redhat.com
Reply-To: Robert Siemer <siemer@panorama.hadiko.de>
X-Mailer: Mew version 1.94b25 on Emacs 20.5 / Mule 4.0 (HANANOEN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20010612025237Q.siemer@panorama.hadiko.de>
Date: Tue, 12 Jun 2001 02:52:37 +0200
X-Dispatcher: imput version 990425(IM115)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

The patch is for miroSOUND sound cards. Especially the miroSOUND PCM20
radio is benefits from it, because of the updated RDS/RBDS stuff.

The latest is for 2.4.5 and can be found on:
http://www.uni-karlsruhe.de/~Robert.Siemer/Private/
http://www.uni-karlsruhe.de/~Robert.Siemer/Private/aci-2.4.5.patch
(40kB)

Changes:
-I renamed some files. As radio drivers got their own directory, it
 make sense to let my drivers start with miropcm20:

 linux/drivers/media/radio/:
 -rw-rw-r--  1 siemer siemer   6218 Jun 11 02:59 miropcm20-radio.c
 -rw-rw-r--  1 siemer siemer   4082 Jun 11 02:41 miropcm20-rds-core.c
 -rw-rw-r--  1 siemer siemer    529 Jun 11 02:41 miropcm20-rds-core.h
 -rw-rw-r--  1 siemer siemer   3041 Jun 11 02:41 miropcm20-rds.c

 Resulting modules:
 -rw-rw-r--  1 siemer siemer   3300 Jun 11 06:02 miropcm20-rds.o
 -rw-rw-r--  1 siemer siemer   7360 Jun 11 06:02 miropcm20.o

-created miropcm20-rds-core.h (aci.h is not the right place...)
-invented preprocessor macros for better readability
-started with RDS user interface driver; 
 try "cat /dev/v4l/rds/radiotext" to get radiotext...
 This is marked 'experimental' (driver is very basic at the moment)
 and needs devfs.
-adapted video_register_device()-call (changed in kernel)
-some documentation updates/corrections 


Bye,
	Robert
