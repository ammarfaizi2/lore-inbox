Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289102AbSA3LKy>; Wed, 30 Jan 2002 06:10:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289103AbSA3LKo>; Wed, 30 Jan 2002 06:10:44 -0500
Received: from khan.acc.umu.se ([130.239.18.139]:1726 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id <S289102AbSA3LKd>;
	Wed, 30 Jan 2002 06:10:33 -0500
Date: Wed, 30 Jan 2002 12:09:34 +0100
From: David Weinehall <tao@acc.umu.se>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: Horst von Brand <brand@jupiter.cs.uni-dortmund.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KERN_INFO for devfs
Message-ID: <20020130120934.R1735@khan.acc.umu.se>
In-Reply-To: <200201291649.g0TGnnD8001332@tigger.cs.uni-dortmund.de> <200201300903.g0U933t08579@Port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200201300903.g0U933t08579@Port.imtp.ilyichevsk.odessa.ua>; from vda@port.imtp.ilyichevsk.odessa.ua on Wed, Jan 30, 2002 at 11:03:05AM -0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2002 at 11:03:05AM -0200, Denis Vlasenko wrote:
> On 29 January 2002 14:49, Horst von Brand wrote:
> > > diff -u --recursive linux-2.4.18-pre6mhv_ll/fs/devfs/base.c
> > > linux-2.4.18-pre6mhv_ll.devfs/fs/devfs/base.c
> > > --- linux-2.4.18-pre6mhv_ll/fs/devfs/base.c     Fri Jan 25 15:49:53 2002
> > > +++ linux-2.4.18-pre6mhv_ll.devfs/fs/devfs/base.c       Mon Jan 28
> > > 23:05:44 2002
> > > @@ -3490,8 +3489,8 @@
> > >      int err;
> > >
> > >      if ( !(boot_options & OPTION_MOUNT) ) return;
> > > -    err = do_mount ("none", "/dev", "devfs", 0, "");
> > > -    if (err == 0) printk ("Mounted devfs on /dev\n");
> > > +    err = do_mount ("devfs", "/dev", "devfs", 0, "");
> > > +    if (err == 0) printk (KERN_INFO "Mounted devfs on /dev\n");
> > >      else printk ("Warning: unable to mount devfs, err: %d\n", err);
> >
> >                     ^^^^^
> >                      Missed this one
> 
> Hmm. KERN_WARNING can be added there, but it is the default level anyway.

Yes, but that may change (in theory, at least.) Consistency is a virtue.


/David Weinehall
  _                                                                 _
 // David Weinehall <tao@acc.umu.se> /> Northern lights wander      \\
//  Maintainer of the v2.0 kernel   //  Dance across the winter sky //
\>  http://www.acc.umu.se/~tao/    </   Full colour fire           </
