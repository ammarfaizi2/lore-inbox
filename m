Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131157AbRC3HMK>; Fri, 30 Mar 2001 02:12:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131158AbRC3HMB>; Fri, 30 Mar 2001 02:12:01 -0500
Received: from mailout01.sul.t-online.com ([194.25.134.80]:18959 "EHLO
	mailout01.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S131157AbRC3HLn>; Fri, 30 Mar 2001 02:11:43 -0500
Date: 30 Mar 2001 08:54:00 +0200
From: kaih@khms.westfalen.de (Kai Henningsen)
To: linux-kernel@vger.kernel.org
Message-ID: <7yrcoKS1w-B@khms.westfalen.de>
In-Reply-To: <3AC2587F.8149C3E9@evision-ventures.com>
Subject: Re: Larger dev_t
X-Mailer: CrossPoint v3.12d.kh5 R/C435
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Organization: Organisation? Me?! Are you kidding?
In-Reply-To: <E14i5Y9-0004qx-00@the-village.bc.nu> <3AC2587F.8149C3E9@evision-ventures.com>
X-No-Junk-Mail: I do not want to get *any* junk mail.
Comment: Unsolicited commercial mail will incur an US$100 handling fee per received mail.
X-Fix-Your-Modem: +++ATS2=255&WO1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dalecki@evision-ventures.com (Martin Dalecki)  wrote on 28.03.01 in <3AC2587F.8149C3E9@evision-ventures.com>:

> Alan Cox wrote:
> >
> > > Exactly. It's just that for historical reasons, I think the major for
> > > "disk" should be either the old IDE or SCSI one, which just can show
> > > more devices. That way old installers etc work without having to
> > > suddenly start knowing about /dev/disk0.
> >
> > They will mostly break. Installers tend to parse /proc/scsi and have
> > fairly complex ioctl based relationships based on knowing ide v scsi.
> >
> > /dev/disc/ is a little un-unix but its clean
>
> Why do you worry about installers? New distro - new kernel - new
> installer
> that's they job to worry about it. They will change the installer anyway
> and this kind of change actually is going to simplyfy the code there, I
> think,
> a bit.
>
> Just kill the old device major suddenly and place it in the changelog
> of the new kernel that the user should mknod and add it to /dev/fstab
> before rebooting into the new kernel. Hey that's developement anyway :-)
> If the developer boots back into the old kernel just other mounts
>  in /dev/fstab will fail no problem for transition here in sight...

Make them finally use UUIDs and /proc/partitions. Except for the root fs,  
problem solved. (Well ok, someone needs to create the right device nodes.)

As for the root fs, even that part isn't hard with an initrd.

MfG Kai
