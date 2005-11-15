Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932340AbVKOKQe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932340AbVKOKQe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 05:16:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932341AbVKOKQe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 05:16:34 -0500
Received: from smtp.osdl.org ([65.172.181.4]:63213 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932340AbVKOKQd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 05:16:33 -0500
Date: Tue, 15 Nov 2005 02:16:02 -0800
From: Andrew Morton <akpm@osdl.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: neilb@suse.de, linux-kernel@vger.kernel.org, trond.myklebust@fys.uio.no
Subject: Re: [PATCH ] Fix some problems with truncate and mtime semantics.
Message-Id: <20051115021602.5119744c.akpm@osdl.org>
In-Reply-To: <20051115095610.GA23605@infradead.org>
References: <20051115125657.9403.patches@notabene>
	<1051115020002.9459@suse.de>
	<20051115095610.GA23605@infradead.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> wrote:
>
> > -int do_truncate(struct dentry *dentry, loff_t length, struct file *filp)
> > +int do_truncate(struct dentry *dentry, loff_t length, unsigned int time_attrs,
> > +	struct file *filp)
> >  {
> >  	int err;
> >  	struct iattr newattrs;
> > @@ -204,7 +205,7 @@ int do_truncate(struct dentry *dentry, l
> >  		return -EINVAL;
> >  
> >  	newattrs.ia_size = length;
> > -	newattrs.ia_valid = ATTR_SIZE | ATTR_CTIME;
> > +	newattrs.ia_valid = ATTR_SIZE | time_attrs;
> 
> I'd rather make the argument and boolean update_times flag and this:
> 

That sentence is incomprehensible.  Want to have another go?

