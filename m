Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752401AbWCRKoX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752401AbWCRKoX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 05:44:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750952AbWCRKoX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 05:44:23 -0500
Received: from mail1.kontent.de ([81.88.34.36]:42183 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S1750753AbWCRKoW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 05:44:22 -0500
From: Oliver Neukum <oliver@neukum.org>
To: Matthew Wilcox <matthew@wil.cx>
Subject: Re: [PATCH]use kzalloc in vfs where appropriate
Date: Sat, 18 Mar 2006 11:44:09 +0100
User-Agent: KMail/1.8
Cc: Oliver Neukum <neukum@fachschaft.cup.uni-muenchen.de>,
       viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
References: <Pine.LNX.4.58.0603172153160.30725@fachschaft.cup.uni-muenchen.de> <20060317210823.GA8980@parisc-linux.org>
In-Reply-To: <20060317210823.GA8980@parisc-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200603181144.10820.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 17. März 2006 22:08 schrieb Matthew Wilcox:
> On Fri, Mar 17, 2006 at 09:58:14PM +0100, Oliver Neukum wrote:
> > --- a/fs/bio.c	2006-03-11 23:12:55.000000000 +0100
> > +++ b/fs/bio.c	2006-03-17 16:44:49.000000000 +0100
> > @@ -635,12 +635,10 @@
> >  		return ERR_PTR(-ENOMEM);
> >  
> >  	ret = -ENOMEM;
> > -	pages = kmalloc(nr_pages * sizeof(struct page *), GFP_KERNEL);
> > +	pages = kzalloc(nr_pages * sizeof(struct page *), GFP_KERNEL);
> 
> Didn't we just discuss this one and conclude it needed to use kcalloc
> instead?

I've found some discussion in the archive, but no conclusion. Could you
elaborate?

	Oliver
