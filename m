Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751306AbVK1VHU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751306AbVK1VHU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 16:07:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751309AbVK1VHU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 16:07:20 -0500
Received: from adsl-80.mirage.euroweb.hu ([193.226.228.80]:63498 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S1751306AbVK1VHR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 16:07:17 -0500
To: akpm@osdl.org
CC: linux-kernel@vger.kernel.org
In-reply-to: <20051128124007.1feb4473.akpm@osdl.org> (message from Andrew
	Morton on Mon, 28 Nov 2005 12:40:07 -0800)
Subject: Re: [PATCH 7/7] fuse: support caching negative dentries
References: <E1EgosN-0006s3-00@dorka.pomaz.szeredi.hu>
	<E1EgouE-0006sp-00@dorka.pomaz.szeredi.hu>
	<E1EgowL-0006tN-00@dorka.pomaz.szeredi.hu>
	<E1EgoxK-0006tk-00@dorka.pomaz.szeredi.hu>
	<E1EgoyM-0006uH-00@dorka.pomaz.szeredi.hu>
	<E1Egozl-0006uy-00@dorka.pomaz.szeredi.hu>
	<E1Egp0p-0006vL-00@dorka.pomaz.szeredi.hu>
	<E1Egp20-0006vv-00@dorka.pomaz.szeredi.hu> <20051128124007.1feb4473.akpm@osdl.org>
Message-Id: <E1EgqD6-0007Cf-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 28 Nov 2005 22:06:52 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >
> > +void fuse_invalidate_attr(struct inode *inode)
> >  +{
> >  +	get_fuse_inode(inode)->i_time = jiffies - 1;
> >  +}
> >  +
> >  +static void fuse_invalidate_entry_cache(struct dentry *entry)
> >  +{
> >  +	entry->d_time = jiffies - 1;
> >  +}
> >  +
> 
> I'd normally have a little whine about lack of comments here - pity the
> poor programmer who is trying to work out why on earth that code is doing
> that.

Well, I thought it was evident, but it seems not.  I'll add some
comments.

> But fuse is pretty much a comment-free zone anyway.

I think most of FUSE is really-really obvious.  The most complex parts
are in the device handling, which is now quite well commented (thanks
to your earlier whining :).

> Please don't go near any buses.

Don't worry, I usually go by tram.

Miklos
