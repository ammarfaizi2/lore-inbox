Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285828AbSBGH4n>; Thu, 7 Feb 2002 02:56:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285747AbSBGH4d>; Thu, 7 Feb 2002 02:56:33 -0500
Received: from twilight.cs.hut.fi ([130.233.40.5]:50106 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S285720AbSBGH4Q>; Thu, 7 Feb 2002 02:56:16 -0500
Date: Thu, 7 Feb 2002 09:56:07 +0200
From: Ville Herva <vherva@niksula.hut.fi>
To: David Relson <relson@osagesoftware.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: How to check the kernel compile options ?
Message-ID: <20020207075607.GE534915@niksula.cs.hut.fi>
Mail-Followup-To: Ville Herva <vherva@niksula.cs.hut.fi>,
	David Relson <relson@osagesoftware.com>,
	lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20020206162657.GD534915@niksula.cs.hut.fi> <m3ofj2galz.fsf@linux.local> <E16YSs7-0005GY-00@the-village.bc.nu> <20020206162657.GD534915@niksula.cs.hut.fi> <4.3.2.7.2.20020206131121.00b1f670@mail.osagesoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4.3.2.7.2.20020206131121.00b1f670@mail.osagesoftware.com>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 06, 2002 at 01:16:58PM -0500, you [David Relson] wrote:
> At 12:26 PM 2/6/02, you wrote:
> 
> 
> >... snip ...
> >
> >        * having /usr/src/linux/patches is not practical : it will be a 
> >big mess wrt
> >to conflict
> 
> Indeed, if /usr/src/linux/patches was a file, the conflicts would be 
> impossible to manage.  But suppose it was a directory and each patch 
> created a small description file in that directory.  This would provide the 
> desired information without having the big mess :-)

With a directory, you lose the information of in which order the patches
have been applied - unless of course you resort to file dates or some such.

I agree that one file is very problematic wrt. patch(1), but I was hoping
there would be a way to persuade patch into doing the right thing.

Anyway, I think these kind of issues are solveable if only anybody agrees
this is a good idea...
 
> The patch descriptions could be saved in a similar manner:
> 
>         cat /usr/src/linux/patches/* | gzip -9 >> image
> 
> Alternatively, instead of outputting to image, one could output to 
> /boot/patch-$KERNELVERSION, (or wherever)

Yep.

To get back to the original subject: I often compile test kernels and use a
ext2 fs on a cdr as the root fs. I put the tested kernel on a floppy (1)
with cp bzImage /dev/fd0. And then when I finally come up with something
interested I usually find my self pondering is this this or that kernel on
this floppy... In that case the /proc/config thing (and /proc/patches or
whatever) is very useful.

(I admit I should be using lilo on the floppy, and the next problem I hit is
finding the right System.map, which /proc/* won't solve, but...)


-- v --

v@iki.fi

(1) Is there a way to make ext2 fs cd bootable? I know I can do that with
iso fs cd (with the el torido boot image), but I've found no way to do that
with other filesystems.
