Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288994AbSA3JFF>; Wed, 30 Jan 2002 04:05:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288995AbSA3JE5>; Wed, 30 Jan 2002 04:04:57 -0500
Received: from [195.66.192.167] ([195.66.192.167]:28942 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S288994AbSA3JEp>; Wed, 30 Jan 2002 04:04:45 -0500
Message-Id: <200201300903.g0U933t08579@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Horst von Brand <brand@jupiter.cs.uni-dortmund.de>
Subject: Re: [PATCH] KERN_INFO for devfs
Date: Wed, 30 Jan 2002 11:03:05 -0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200201291649.g0TGnnD8001332@tigger.cs.uni-dortmund.de>
In-Reply-To: <200201291649.g0TGnnD8001332@tigger.cs.uni-dortmund.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 29 January 2002 14:49, Horst von Brand wrote:
> > diff -u --recursive linux-2.4.18-pre6mhv_ll/fs/devfs/base.c
> > linux-2.4.18-pre6mhv_ll.devfs/fs/devfs/base.c
> > --- linux-2.4.18-pre6mhv_ll/fs/devfs/base.c     Fri Jan 25 15:49:53 2002
> > +++ linux-2.4.18-pre6mhv_ll.devfs/fs/devfs/base.c       Mon Jan 28
> > 23:05:44 2002
> > @@ -3490,8 +3489,8 @@
> >      int err;
> >
> >      if ( !(boot_options & OPTION_MOUNT) ) return;
> > -    err = do_mount ("none", "/dev", "devfs", 0, "");
> > -    if (err == 0) printk ("Mounted devfs on /dev\n");
> > +    err = do_mount ("devfs", "/dev", "devfs", 0, "");
> > +    if (err == 0) printk (KERN_INFO "Mounted devfs on /dev\n");
> >      else printk ("Warning: unable to mount devfs, err: %d\n", err);
>
>                     ^^^^^
>                      Missed this one

Hmm. KERN_WARNING can be added there, but it is the default level anyway.
--
vda
