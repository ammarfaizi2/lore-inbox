Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267298AbUHWVHB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267298AbUHWVHB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 17:07:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267596AbUHWVEF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 17:04:05 -0400
Received: from mail.kroah.org ([69.55.234.183]:13711 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266806AbUHWVAg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 17:00:36 -0400
Date: Mon, 23 Aug 2004 13:59:43 -0700
From: Greg KH <greg@kroah.com>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: Christoph Hellwig <hch@infradead.org>, James Morris <jmorris@redhat.com>,
       Andrew Morton <akpm@osdl.org>,
       Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][7/7] add xattr support to ramfs
Message-ID: <20040823205942.GA3370@kroah.com>
References: <Xine.LNX.4.44.0408231420100.13728-100000@thoron.boston.redhat.com> <Xine.LNX.4.44.0408231421200.13728-100000@thoron.boston.redhat.com> <20040823212623.A20995@infradead.org> <1093292789.27211.279.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1093292789.27211.279.camel@moss-spartans.epoch.ncsc.mil>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 23, 2004 at 04:26:29PM -0400, Stephen Smalley wrote:
> On Mon, 2004-08-23 at 16:26, Christoph Hellwig wrote:
> > On Mon, Aug 23, 2004 at 02:22:20PM -0400, James Morris wrote:
> > > This patch adds xattr support to tmpfs, and a security xattr handler.
> > > Original patch from: Chris PeBenito <pebenito@gentoo.org>
> > 
> > What's the point on doing this for ramfs?  And if you really want this
> > the implementation could be shared with tmpfs easily and put into xattr.c
> 
> For udev.

What's wrong with using a tmpfs for udev in such situations that xattrs
are needed?  udev does not require ramfs at all.  In fact, why not just
use a ext2 or ext3 partition for /dev instead today, if you really need
it?

thanks,

greg k-h


> 
> -- 
> Stephen Smalley <sds@epoch.ncsc.mil>
> National Security Agency
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
