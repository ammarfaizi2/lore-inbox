Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262611AbUKLUut@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262611AbUKLUut (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 15:50:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262615AbUKLUut
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 15:50:49 -0500
Received: from 208.177.141.226.ptr.us.xo.net ([208.177.141.226]:30665 "EHLO
	ash.lnxi.com") by vger.kernel.org with ESMTP id S262611AbUKLUul
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 15:50:41 -0500
Subject: Re: [PATCH] gen_init_cpio-slink_pipe_sock
From: Thayne Harbaugh <tharbaugh@lnxi.com>
Reply-To: tharbaugh@lnxi.com
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org, klibc@zytor.com, akpm@digeo.com,
       azarah@nosferatu.za.org
In-Reply-To: <41952022.1050607@pobox.com>
References: <1100290509.3171.8.camel@tubarao>  <41952022.1050607@pobox.com>
Content-Type: text/plain
Organization: Linux Networx
Date: Fri, 12 Nov 2004 13:27:25 -0700
Message-Id: <1100291245.3171.14.camel@tubarao>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-11-12 at 15:42 -0500, Jeff Garzik wrote:
> Thayne Harbaugh wrote:
> > diff -ur linux-2.6.10-rc1.orig/drivers/block/Kconfig linux-2.6.10-rc1/drivers/block/Kconfig
> > --- linux-2.6.10-rc1.orig/drivers/block/Kconfig	2004-11-12 11:03:52.657108248 -0700
> > +++ linux-2.6.10-rc1/drivers/block/Kconfig	2004-11-12 11:07:28.458301480 -0700
> > @@ -363,10 +363,14 @@
> >  	    file <name> <location> <mode> <uid> <gid>
> >  	    dir <name> <mode> <uid> <gid>
> >  	    nod <name> <mode> <uid> <gid> <dev_type> <maj> <min>
> > +	    slink <name> <target> <mode> <uid> <gid>
> > +	    pipe <name> <mode> <uid> <gid>
> > +	    sock <name> <mode> <uid> <gid>
> >  
> >  	  Where:
> > -	    <name>      name of the file/dir/nod in the archive
> > +	    <name>      name of the file/dir/nod/etc in the archive
> >  	    <location>  location of the file in the current filesystem
> > +	    <target>    link target
> >  	    <mode>      mode/permissions of the file
> >  	    <uid>       user id (0=root)
> >  	    <gid>       group id (0=root)
> 
> This info should get moved out of Kconfig, and into a Documentation/* 
> text file somewhere.

It's actually redundant with the gen_init_cpio help output.  It could be
removed from the Kconfig and put in Documentation/early-userspace/README
if someone still wants it someplace other than the gen_init_cpio help
output.

> > +/*
> > + * Original work by Jeff Garzick
> 
> Please spell my last name correctly :)

I did - you're the one that spells it incorrectly! B^)

Makes me wonder how I got your email correct since I typed that from
memory . . ..

-- 
Thayne Harbaugh
Linux Networx

