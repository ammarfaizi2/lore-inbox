Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id <S132598AbRC1Vrp>; Wed, 28 Mar 2001 16:47:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id <S132590AbRC1VrI>; Wed, 28 Mar 2001 16:47:08 -0500
Received: from [195.63.194.11] ([195.63.194.11]:50187 "EHLO mail.stock-world.de") by vger.kernel.org with ESMTP id <S132599AbRC1Vp7>; Wed, 28 Mar 2001 16:45:59 -0500
Message-ID: <3AC2587F.8149C3E9@evision-ventures.com>
Date: Wed, 28 Mar 2001 23:32:47 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Linus Torvalds <torvalds@transmeta.com>, "H. Peter Anvin" <hpa@transmeta.com>, Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org, tytso@MIT.EDU
Subject: Re: Larger dev_t
References: <E14i5Y9-0004qx-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > Exactly. It's just that for historical reasons, I think the major for
> > "disk" should be either the old IDE or SCSI one, which just can show more
> > devices. That way old installers etc work without having to suddenly start
> > knowing about /dev/disk0.
> 
> They will mostly break. Installers tend to parse /proc/scsi and have fairly
> complex ioctl based relationships based on knowing ide v scsi.
> 
> /dev/disc/ is a little un-unix but its clean

Why do you worry about installers? New distro - new kernel - new
installer
that's they job to worry about it. They will change the installer anyway
and this kind of change actually is going to simplyfy the code there, I
think,
a bit.

Just kill the old device major suddenly and place it in the changelog
of the new kernel that the user should mknod and add it to /dev/fstab
before rebooting into the new kernel. Hey that's developement anyway :-)
If the developer boots back into the old kernel just other mounts
 in /dev/fstab will fail no problem for transition here in sight...
