Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265275AbTASBYv>; Sat, 18 Jan 2003 20:24:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265277AbTASBYv>; Sat, 18 Jan 2003 20:24:51 -0500
Received: from anvers-smtp.planetinternet.be ([195.95.30.152]:36612 "EHLO
	yoda.planetinternet.be") by vger.kernel.org with ESMTP
	id <S265275AbTASBYu>; Sat, 18 Jan 2003 20:24:50 -0500
Date: Sun, 19 Jan 2003 02:34:40 +0100
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Why kernel 2.5.58 only mounts / (not home etc)
Message-ID: <20030119013440.GA815@gouv>
References: <1042932078.3476.25.camel@garaged.fis.unam.mx> <20030118154414.607df22b.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030118154414.607df22b.akpm@digeo.com>
User-Agent: Mutt/1.5.3i
From: Leopold Gouverneur <lgouv@pi.be>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 18, 2003 at 03:44:14PM -0800, Andrew Morton wrote:
> Max Valdez <maxvaldez@yahoo.com> wrote:
> >
> > I'm having a problem with 2.5.58, when I boot I get / mounted, but not
> > the other entries on fstab, but if I mount them manually they run ok.
> > All ext3.
> > 
> > Is anybody having the same problem ?
> > mount-2.11u, e2fsprogs-1.27-4mdk
> > on MDK 9.0.
> > 
> 
> Your ext3 filesystem is being built as a module, so you are dependent upon
> correct initrd setup to be able to mount the other filesystems.  If those
> filesystems were not cleanly shut down, ext2 will not be able to mount them.
> 
> Or something like that.  Try setting CONFIG_EXT3_FS=y.
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
my problem is probably different:
2.5.58 is ok but when i boot 2.5.59 it hangs after issuing
Mounting local filesystem...
/dev/hde7 on /usrtype ext2 (rw)
Nothing in the logs, same config and tools as 2.5.58 !

