Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262449AbSKYGDf>; Mon, 25 Nov 2002 01:03:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262450AbSKYGDe>; Mon, 25 Nov 2002 01:03:34 -0500
Received: from smtp01.uc3m.es ([163.117.136.121]:21511 "HELO smtp.uc3m.es")
	by vger.kernel.org with SMTP id <S262449AbSKYGDe>;
	Mon, 25 Nov 2002 01:03:34 -0500
Date: Mon, 25 Nov 2002 07:10:38 +0100
Message-Id: <200211250610.gAP6AcA19907@oboe.it.uc3m.es>
From: "Peter T. Breuer" <ptb@it.uc3m.es>
To: linux-kernel@vger.kernel.org
Subject: Re: Unable to mount root device under .49 (possibly earlier than .47)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> X-X-Sender: zwane@montezuma.mastecende.com
> 
> Linux version 2.5.49 (zwane@montezuma.mastecende.com) (gcc version 3.2
> 20020903 (Red Hat Linux 8.0 3.2-7)) #17 SMP Sat Nov 23 15:39:24 EST 2002
> 
> What i get at boot is;
> 
> kernel /vmlinuz ro root=/dev/hda1
> ...
> VFS: Cannot open root device "hda1" or 00:00
> Please append a correct "root=" boot option
> Kernel panic: VFS: Unable to mount root fs on 00:00
> 

I found that on 2.5.47. It turned out that I had to give the devfs
name for the root device. root=/dev/ide/la/la/la.

I had devfs compiled in but not active on boot. 

 CONFIG_PROC_FS=y
 CONFIG_DEVFS_FS=y
 # CONFIG_DEVFS_MOUNT is not set
 # CONFIG_DEVFS_DEBUG is not set
 CONFIG_DEVPTS_FS=y



Peter
