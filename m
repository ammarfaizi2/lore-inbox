Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280755AbRKSW3F>; Mon, 19 Nov 2001 17:29:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280757AbRKSW24>; Mon, 19 Nov 2001 17:28:56 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:17054 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S280755AbRKSW2f>; Mon, 19 Nov 2001 17:28:35 -0500
Date: Mon, 19 Nov 2001 15:28:30 -0700
Message-Id: <200111192228.fAJMSUD32747@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: John Ellson <ellson@lucent.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] "make modules_install" breaks with new /bin/cp
In-Reply-To: <3BF980F6.6080503@lucent.com>
In-Reply-To: <3BF980F6.6080503@lucent.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Ellson writes:
> linux-2.4.15-pre6, fileutils-4.1.1-1.i386.rpm
> 
> With my configuration (details not important), "make modules_install" results in:
> 
> mkdir -p /lib/modules/2.4.15-pre6/kernel/drivers/sound/
> cp soundcore.o sound.o cs4232.o ad1848.o pss.o ad1848.o mpu401.o cs4232.o uart401.o ad1848.o mpu401.o uart6850.o 
> v_midi.o btaudio.o /lib/modules/2.4.15-pre6/kernel/drivers/sound/
> cp: will not overwrite just-created `/lib/modules/2.4.15-pre6/kernel/drivers/sound/ad1848.o' with `ad1848.o'
> cp: will not overwrite just-created `/lib/modules/2.4.15-pre6/kernel/drivers/sound/cs4232.o' with `cs4232.o'
> cp: will not overwrite just-created `/lib/modules/2.4.15-pre6/kernel/drivers/sound/ad1848.o' with `ad1848.o'
> cp: will not overwrite just-created `/lib/modules/2.4.15-pre6/kernel/drivers/sound/mpu401.o' with `mpu401.o'
> make[2]: *** [_modinst__] Error 1
> 
> This hasn't been a problem with earlier version of /bin/cp (upto
> fileutils-4.1-4.i386.rpm in RH7.2), but /bin/cp from
> fileutils-4.1.1-1.i386.rpm (in the Rawhide collection) is more
> pedantic about multiple copies of the same file.
> 
> This patch works around this "feature".  It would be better if the
> Makefiles were changed to only install modules once, but thats a
> deeper problem.

No, the fix is to upgrade to fileutils-4.1-4.i386.rpm. cp should not
be complaining unless you ask it to. The default should be to do what
you ask. For the same reason, cp does not have "cp -i" as the default
behaviour.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
