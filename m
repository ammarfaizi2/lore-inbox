Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290228AbSBXRSm>; Sun, 24 Feb 2002 12:18:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290216AbSBXRSc>; Sun, 24 Feb 2002 12:18:32 -0500
Received: from gate.perex.cz ([194.212.165.105]:45584 "EHLO gate.perex.cz")
	by vger.kernel.org with ESMTP id <S290289AbSBXRSV>;
	Sun, 24 Feb 2002 12:18:21 -0500
Date: Sun, 24 Feb 2002 18:18:15 +0100 (CET)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: <perex@pnote.perex-int.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: KMOD error messages - proposal and patch
In-Reply-To: <E16eySE-0001co-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.31.0202241814130.535-100000@pnote.perex-int.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Feb 2002, Alan Cox wrote:

> > +	/* Don't allow request_module() when ramfs based rootfs is mounted! */
> > +	if ( ! strcmp("rootfs", current->fs->pwdmnt->mnt_sb->s_type->name) ) {
> > +		printk(KERN_ERR "request_module[%s]: Real root fs not mounted\n",
> > +			module_name);
> > +		return -EPERM;
> > +	}
>
> The ramfs based root file system once the load ramfs from tar stuff is
> working may have a completely valid modprobe on it.
>
> Perhaps request_module() needs a 'quiet' flag

Well, I though about this, but we can suppress with this way important
informative error messages as well. I think that the condition in kmod
might be exteded in future when the ramfs initialization will be
implemented.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project  http://www.alsa-project.org
SuSE Linux    http://www.suse.com

