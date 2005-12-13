Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030252AbVLMXWF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030252AbVLMXWF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 18:22:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030291AbVLMXWF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 18:22:05 -0500
Received: from smtp.osdl.org ([65.172.181.4]:8137 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030252AbVLMXWE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 18:22:04 -0500
Date: Tue, 13 Dec 2005 15:21:43 -0800
From: Andrew Morton <akpm@osdl.org>
To: Christoph Hellwig <hch@lst.de>
Cc: hch@lst.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] per-mount noatime and nodiratime
Message-Id: <20051213152143.6193fc7a.akpm@osdl.org>
In-Reply-To: <20051213223928.GA22373@lst.de>
References: <20051213175659.GF17130@lst.de>
	<20051213143638.120ee601.akpm@osdl.org>
	<20051213223928.GA22373@lst.de>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@lst.de> wrote:
>
> On Tue, Dec 13, 2005 at 02:36:38PM -0800, Andrew Morton wrote:
> > Where'd this hunk come from?
> > 
> > > Index: linux-2.6.15-rc5/fs/super.c
> > > ===================================================================
> > > --- linux-2.6.15-rc5.orig/fs/super.c	2005-12-13 11:27:14.000000000 +0100
> > > +++ linux-2.6.15-rc5/fs/super.c	2005-12-13 12:06:00.000000000 +0100
> > > @@ -830,9 +830,9 @@
> > >  	mnt->mnt_parent = mnt;
> > >  
> > >  	if (type->fs_flags & FS_NOATIME)
> > > -		sb->s_flags |= MS_NOATIME;
> > > +		mnt->mnt_flags |= MNT_NOATIME;
> > >  	if (type->fs_flags & FS_NODIRATIME)
> > > -		sb->s_flags |= MS_NODIRATIME;
> > > +		mnt->mnt_flags |= MNT_NODIRATIME;
> > >  
> > >  	up_write(&sb->s_umount);
> > >  	free_secdata(secdata);
> > 
> > I just dropped it, but it's a worry...
> 
> This is totally intentional.  The FS_* flags were introduced in the
> previous patch to mark filesystems that always are NOATIME/NODIRATIME,

Please refer to patches by their filename or Subject:.  I assume you're
referring to "[PATCH 3/6] introduce FS_NOATIME and FS_NODIRATIME flags"?

If so, that patch doesn't touch fs/super.c.  Please fix and resend.

