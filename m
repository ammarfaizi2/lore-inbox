Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261744AbUA3QDP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 11:03:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261812AbUA3QDP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 11:03:15 -0500
Received: from fungus.teststation.com ([212.32.186.211]:8208 "EHLO
	fungus.teststation.com") by vger.kernel.org with ESMTP
	id S261744AbUA3QDN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 11:03:13 -0500
Date: Fri, 30 Jan 2004 17:03:22 +0100 (CET)
From: Urban Widmark <Urban.Widmark@enlight.net>
X-X-Sender: puw@cola.local
To: Arjan van de Ven <arjanv@redhat.com>
cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] smbfs: Large File Support (3/3) (fwd)
In-Reply-To: <Pine.LNX.4.58L.0401300904240.1323@logos.cnet>
Message-ID: <Pine.LNX.4.44.0401301631370.31893-100000@cola.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Jan 2004, Marcelo Tosatti wrote:

> 
> Urban?
> 
> ---------- Forwarded message ----------
> Date: Wed, 28 Jan 2004 14:21:53 -0500
> From: Arjan van de Ven <arjanv@redhat.com>
> To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
> Subject: Re: [PATCH] smbfs: Large File Support (3/3)
> 
> On Wed, 2004-01-28 at 06:05, Linux Kernel Mailing List wrote:
> 
> > diff -Nru a/include/linux/smb.h b/include/linux/smb.h
> > --- a/include/linux/smb.h	Wed Jan 28 04:02:56 2004
> > +++ b/include/linux/smb.h	Wed Jan 28 04:02:56 2004
> > @@ -85,7 +85,7 @@
> >  	uid_t		f_uid;
> >  	gid_t		f_gid;
> >  	kdev_t		f_rdev;
> > -	off_t		f_size;
> > +	loff_t		f_size;
> >  	time_t		f_atime;
> >  	time_t		f_mtime;
> >  	time_t		f_ctime;
> 
> ehhmmmm doesn't this change the userspace ABI incompatibly ???

How would userspace get access to a smb_fattr struct?
(Which ioctl/syscall, etc? Not that they can include the header.)

It is used internally to keep data that you would otherwise find in the
inode, and data is copied to/from the corresponding inode fields for some
operations.

What am I missing?

/Urban

