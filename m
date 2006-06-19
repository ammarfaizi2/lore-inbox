Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932275AbWFSINS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932275AbWFSINS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 04:13:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932284AbWFSINS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 04:13:18 -0400
Received: from mail-gw1.sa.eol.hu ([212.108.200.67]:45708 "EHLO
	mail-gw1.sa.eol.hu") by vger.kernel.org with ESMTP id S932275AbWFSINS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 04:13:18 -0400
To: akpm@osdl.org
CC: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-reply-to: <20060618235805.f12d4606.akpm@osdl.org> (message from Andrew
	Morton on Sun, 18 Jun 2006 23:58:05 -0700)
Subject: Re: [PATCH 4/7] fuse: add POSIX file locking support
References: <E1FplQT-0005yf-00@dorka.pomaz.szeredi.hu>
	<E1FplXk-00062M-00@dorka.pomaz.szeredi.hu> <20060618235805.f12d4606.akpm@osdl.org>
Message-Id: <E1FsEsM-0002M3-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 19 Jun 2006 10:12:50 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > +/*
> > + * It would be nice to scramble the ID space, so that the value of the
> > + * files_struct pointer is not exposed to userspace.  Symmetric crypto
> > + * functions are overkill, since the inverse function doesn't need to
> > + * be implemented (though it does have to exist).  Is there something
> > + * simpler?
> > + */
> > +static inline u64 fuse_lock_owner_id(fl_owner_t id)
> > +{
> > +	return (unsigned long) id;
> > +}
> 
> Add a constant, not-known-to-userspace offset to all ids?

I thought of that, but it seemd cryptographically not quite strong
enough.  But maybe it's better than nothing.

Thanks,
Miklos
