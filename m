Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129318AbRCHQtX>; Thu, 8 Mar 2001 11:49:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129310AbRCHQtN>; Thu, 8 Mar 2001 11:49:13 -0500
Received: from 513.holly-springs.nc.us ([216.27.31.173]:3332 "EHLO
	513.holly-springs.nc.us") by vger.kernel.org with ESMTP
	id <S129309AbRCHQtK>; Thu, 8 Mar 2001 11:49:10 -0500
Message-Id: <200103081739.f28Hd0Q04143@513.holly-springs.nc.us>
Subject: Re: opening files in /proc, and modules
From: Michael Rothwell <rothwell@holly-springs.nc.us>
To: Alexander Viro <viro@math.psu.edu>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.21.0103081141190.11458-100000@weyl.math.psu.edu>
Content-Type: text/plain
X-Mailer: Evolution (0.9/+cvs.2001.03.06.23.22 - Preview Release)
Date: 08 Mar 2001 11:48:42 -0500
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sweet! Thanks!

I'm working on 2.2 for now, but the 2.4 API looks nicer... :)

-M

On 08 Mar 2001 11:43:24 -0500, Alexander Viro wrote:
> 
> 
> On 8 Mar 2001, Michael Rothwell wrote:
> 
> > Figured it out -- I think. This appears to be the answer:
> > 
> > In struct proc_dir_entry,set the fill_inode function pointer to a
> > callback to handle refcounts.
> > 
> > struct proc_dir_entry
> > {
> > ...
> > void (*fill_inode)(struct inode *, int);
> > ...
> > };
> [snip]
> > ... right?  :)
> 
> Right for 2.2, wrong for 2.4. There you just set ->owner to THIS_MODULE
> and forget about the whole mess with callbacks.
>                                                               Cheers,
>                                                                       Al

