Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278653AbRKMUDg>; Tue, 13 Nov 2001 15:03:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278673AbRKMUD0>; Tue, 13 Nov 2001 15:03:26 -0500
Received: from ppp01.ts1-1.NewportNews.visi.net ([209.8.196.1]:30961 "EHLO
	blimpo.internal.net") by vger.kernel.org with ESMTP
	id <S278653AbRKMUDY>; Tue, 13 Nov 2001 15:03:24 -0500
Date: Tue, 13 Nov 2001 15:03:17 -0500
From: Ben Collins <bcollins@debian.org>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Differences between 2.2.x and 2.4.x initrd
Message-ID: <20011113150317.G329@visi.net>
In-Reply-To: <20011113143947.F329@visi.net> <3BF1794B.D5E584D0@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3BF1794B.D5E584D0@mandrakesoft.com>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 13, 2001 at 02:49:31PM -0500, Jeff Garzik wrote:
> Ben Collins wrote:
> > Basically what we have is a kernel image with ramdisk and initrd
> > enabled, and a root disk image slapped on the end that is loaded via
> > initrd.
> > 
> > On 2.2.x, this works without problems; the ramdisk is loaded, and
> > /sbin/init is executed. However, with 2.4.x, it's quite different.
> > 
> > It loads the initial ramdisk, mounts it fine, tries to execute /linuxrc
> > (same as in 2.2.x, but it isn't there, so it continues), and then
> > complains with this:
> > 
> > VFS: Mounted root (ext2 filesystem).
> > VFS: Cannot open root device "" or 02:00
> > 
> > For some reason it is trying to mount /dev/fd, and totally forgets
> > about /dev/ram. If I pass root=/dev/ram to the command line, it works
> > fine, but I don't want to have to do this :)
> 
> hrm, if your root filesystem is indeed in RAM, then root=/dev/ram seems
> appropriate on both 2.2.x and 2.4.x.  That's what 2.2.x and 2.4.x
> Documentation/initrd.txt seem to indicate to me, anyway.

Well, the point being that 2.2.x worked implicitly, and 2.4.x doesn't. I
don't want to have to tell people who have been using tilo forever and a
day that they now have to add additional command line to get it to work
with 2.4.x.

-- 
 .----------=======-=-======-=========-----------=====------------=-=-----.
/                   Ben Collins    --    Debian GNU/Linux                  \
`  bcollins@debian.org  --  bcollins@openldap.org  --  bcollins@linux.com  '
 `---=========------=======-------------=-=-----=-===-======-------=--=---'
