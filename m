Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265249AbTASAol>; Sat, 18 Jan 2003 19:44:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265250AbTASAol>; Sat, 18 Jan 2003 19:44:41 -0500
Received: from inet-mail2.oracle.com ([148.87.2.202]:50921 "EHLO
	inet-mail2.oracle.com") by vger.kernel.org with ESMTP
	id <S265249AbTASAok>; Sat, 18 Jan 2003 19:44:40 -0500
Message-ID: <979319.1042937324282.JavaMail.nobody@web11.us.oracle.com>
Date: Sat, 18 Jan 2003 16:48:44 -0800 (GMT-08:00)
From: Alessandro Suardi <ALESSANDRO.SUARDI@oracle.com>
To: akpm@digeo.com, maxvaldez@yahoo.com
Subject: Re: Why kernel 2.5.58 only mounts / (not home etc)
Cc: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-Mailer: Oracle Webmail Client
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

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
> Your ext3 filesystem is being built as a module, so you are dependent upon
> correct initrd setup to be able to mount the other filesystems.  If those
> filesystems were not cleanly shut down, ext2 will not be able to mount them.
> Or something like that.  Try setting CONFIG_EXT3_FS=y.

As I reported in the same thread as the breakage of modules in 2.5.59,
 module autoloading doesn't work for me since 2.5.58. Using Rusty's
 module-init-tools 0.9.8 or 0.9.9-pre. Same utils work flawlessly under
 2.4.21-pre3.

I can't run PPP, mount iso9660 CDs, run IrDA - anything modular needs
 manual modprobing in both 2.5.58 and 2.5.59 + Kai's fix.

--alessandro
