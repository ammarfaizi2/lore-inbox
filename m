Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292527AbSBTVvS>; Wed, 20 Feb 2002 16:51:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292526AbSBTVvJ>; Wed, 20 Feb 2002 16:51:09 -0500
Received: from mailhost.teleline.es ([195.235.113.141]:58914 "EHLO
	tsmtp6.mail.isp") by vger.kernel.org with ESMTP id <S292525AbSBTVuz>;
	Wed, 20 Feb 2002 16:50:55 -0500
Date: Wed, 20 Feb 2002 22:53:01 +0100
From: Diego Calleja <diegocg@teleline.es>
To: Mark Hahn <hahn@physics.mcmaster.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: SIS IDE driver
Message-Id: <20020220225301.1be26c89.diegocg@teleline.es>
In-Reply-To: <Pine.LNX.4.33.0202201550490.12332-100000@coffee.psychology.mcmaster.ca>
In-Reply-To: <20020220214351.108acbde.diegocg@teleline.es>
	<Pine.LNX.4.33.0202201550490.12332-100000@coffee.psychology.mcmaster.ca>
X-Mailer: Sylpheed version 0.6.6 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

En Wed, 20 Feb 2002 15:52:30 -0500 (EST)
Mark Hahn <hahn@physics.mcmaster.ca> escribio...:

> > latest updates about SIS Ide driver update: When I sleep the drive with
> > hdparm -Y /dev/hda
> > then the drive sleeps.
> 
> are you also doing APM/ACPI sleep?
I'm using APM && apmd, but it seems it does nothing. Now I'll test without apm
module && apmd unloaded.
Well, there's a strange thing: I have two drives:
/dev/hda on /boot,
/dev/hdc on /
If i do hdparm -Y /dev/hda, without apm loaded, hda stops, i can't awake it. hdc remains working.
Now, if i do hdparm -Y /dev/hdc i can sleep && awake hdc. But sometimes, when hda is working (or not)
and with/without apm loaded the system stops, and hdc doesn't awake. I'm getting crazy.

Now when I try to mount the ide cdrom, mount keeps hanged, too.



> 
> > Feb 15 18:13:08 localhost kernel: hda: timeout waiting for DMA
> 
> classic sign that the ide interface has forgotten its state.
> 
> > Drive was tuned with hdparm with the following options:
> > /sbin/hdparm -c3 -A1 -a8 -d1 -m16 -p4 -u1 -W1 -X34 /dev/hda
> 
> such tuning is unnecessary and indeed possibly bad on modern kernels.
> for instance, -m is irrelevant in any dma/udma mode, as is -u.

I didn't know, i just read the hdparm manual, which doesn't says that.
> 
