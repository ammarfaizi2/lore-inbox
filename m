Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262484AbVBXVW0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262484AbVBXVW0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 16:22:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262485AbVBXVW0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 16:22:26 -0500
Received: from MAIL.13thfloor.at ([212.16.62.51]:2526 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S262484AbVBXVWX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 16:22:23 -0500
Date: Thu, 24 Feb 2005 22:22:23 +0100
From: Herbert Poetzl <herbert@13thfloor.at>
To: Ingo Oeser <ioe-lkml@axxeo.de>
Cc: Linux Kernel ML <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Subject: Re: [Patch 4/6] Bind Mount Extensions 0.06
Message-ID: <20050224212223.GE4981@mail.13thfloor.at>
Mail-Followup-To: Ingo Oeser <ioe-lkml@axxeo.de>,
	Linux Kernel ML <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>,
	Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
References: <20050222121233.GE3682@mail.13thfloor.at> <200502230129.30225.ioe-lkml@axxeo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200502230129.30225.ioe-lkml@axxeo.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 23, 2005 at 01:29:30AM +0100, Ingo Oeser wrote:
> Hi,
> 
> Herbert Poetzl wrote:
> > +static inline int mnt_may_unlink(struct vfsmount *mnt, struct inode *dir,
> > struct dentry *child) { +       if (!child->d_inode)
> > +               return -ENOENT;
> > +       if (MNT_IS_RDONLY(mnt))
> > +               return -EROFS;
> > +       return 0;
> > +}
> 
> The argument "dir" is not used. Please remove it and fix the callers.

hmm, yes, just saw that the mnt_may*() functions 
are not according to the 'current' coding style for 
that section/file, so I'll rework that anyway ...

thanks a lot for the input,
Herbert

> Regards
> 
> Ingo Oeser
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
