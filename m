Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424154AbWKIRXN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424154AbWKIRXN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 12:23:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966048AbWKIRXN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 12:23:13 -0500
Received: from py-out-1112.google.com ([64.233.166.177]:54404 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S966046AbWKIRXL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 12:23:11 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=OjHuy0MjV6B2OmsoLl8XlElldDhsh+byLIyY5EOCx+MLb33eyZriS4dob90Sgyz5kvT1lCt9wt0PVZezv4rQH8/LVfdDb2l6c3nlfYAEF416/OgCnbcp0Z5/Hun0vMGi9BIjOK5/I9JB0v8kYp72GVg8MHndET8/PzCROzs8aZ0=
Message-ID: <d9a083460611090922j75b97cd4u6cc53eeee52b2344@mail.gmail.com>
Date: Thu, 9 Nov 2006 18:22:36 +0100
From: Jano <jasieczek@gmail.com>
To: "Phillip Susi" <psusi@cfl.rr.com>
Subject: Re: Problems with mounting filesystems from /dev/hdb (kernel 2.6.18.1)
Cc: "Jiri Slaby" <jirislaby@gmail.com>, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org
In-Reply-To: <455360CF.9070600@cfl.rr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <d9a083460611081439v2eacb065nef62f129d2d9c9c0@mail.gmail.com>
	 <4af2d03a0611090320m5d8316a7l86b42cde888a4fd@mail.gmail.com>
	 <45534B31.50008@cfl.rr.com> <45534D2C.6080509@gmail.com>
	 <455360CF.9070600@cfl.rr.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2006/11/9, Jiri Slaby <jirislaby@gmail.com>:
> Jano wrote:
> > I've compiled it into the kernel, but it doesn't work.
>
> But I guess, you either haven't mkinitrd'ed it or you don't have an initrd line
> in your loader config (I can't see any difference in dmesgs diff)?
>

It is quite possible. All I've done was:

# make all
# make modules_install
# make install

And update of /boot/grub/menu.lst. Additionally I've tried to do it using:

# make-kpkg --initrd kernel_image kernel_headers

And installing the deb package. Please correct me if I've made any mistakes.

2006/11/9, Phillip Susi <psusi@cfl.rr.com>:
> I didn't ask for /proc/mounts, I asked for the output of the mount
> command with no arguments, which prints the contents of /etc/mtab.  I
> was thinking that /etc/mtab might show the partitions as mounted even
> though they are not, which could be why mount is complaining.
>

Here you are, this is output of 'mount' while in recovery mode using
kernel 2.6.18.1

$ mount
 /dev/hda3 on / type ext3 (rw,errors=remount-ro)
proc on /proc type proc (rw)
/sys on /sys type sysfs (rw)
varrun on /var/run type tmpfs (rw)
varlock on /var/lock type tmpfs (rw)
udev on /dev type tmpfs (rw)
devpts on /dev/pts type devpts (rw,gid=5,mode=620)
devshm on /dev/shm type tmpfs (rw)
/dev/hda1 on /boot type ext3 (rw)
/dev/hda5 on /usr type ext3 (rw)

As you can see, no trace of /dev/hdb1.

Best regards,
Jano

-- 
Mail 	jano at stepien com pl
Jabber 	jano at jabber aster pl
GG 	1894343
Web	stepien.com.pl
