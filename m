Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262119AbRENPMY>; Mon, 14 May 2001 11:12:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262125AbRENPMO>; Mon, 14 May 2001 11:12:14 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:53800 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S262119AbRENPL7>; Mon, 14 May 2001 11:11:59 -0400
To: David Woodhouse <dwmw2@infradead.org>
Cc: "H . J . Lu" <hjl@lucon.org>, "David S. Miller" <davem@redhat.com>,
        alan@lxorguk.ukuu.org.uk, linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: Enable IP PNP for 2.4.4-ac8
In-Reply-To: <m1y9s1jbml.fsf@frodo.biederman.org> <20010511162412.A11896@lucon.org> <15100.30085.5209.499946@pizda.ninka.net> <20010511165339.A12289@lucon.org> <m13da9ky7s.fsf@frodo.biederman.org> <20010513110707.A11055@lucon.org> <16874.989832587@redhat.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 14 May 2001 09:08:24 -0600
In-Reply-To: David Woodhouse's message of "Mon, 14 May 2001 10:29:47 +0100"
Message-ID: <m1k83kj7dj.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Woodhouse <dwmw2@infradead.org> writes:

> ebiederm@xmission.com said:
> >  Since you have to set the command line anyway ip=dhcp is no extra
> > burden and it lets you use the same kernel to boot of the harddrive
> > etc.
> 
> You don't have to set the command line anyway. At least you _didn't_.

There wasn't even DHCP support before so yes you did.   As you can't
get the nfs mount point from bootp.

> ebiederm@xmission.com said:
> >  I boot diskless all of time and supporting a ramdisk is trivial.  You
> > just a have a program that slaps a kernel a ramdisk, and some command
> > line arguments into a single image, along with a touch of adapter code
> > to set the kernel parameters correctly and then boot that.
> 
> It's a PITA. Downloading a kernel by TFTP each time you make a one-line 
> change is painful enough, without having to download a ramdisk to go with 
> it.

Unless you have a slow network, it isn't bad.  I routinely download a 3MB
kerenl+RAMDISK image in under a second.  And that ramdisk is virtually
without size optimization.  It has glibc and a whole host of user
space tools.  I have gotten it down much smaller.

> And once those kernels are being built with CONFIG_BLK_DEV=n, the ramdisk 
> is going to be an even more unattractive solution.

Well I think in the CONFIG_BLK_DEV=n case it might wind up being a
ramfs or tmpfs image.  Something like a simplified version of tar.

Eric
