Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261198AbVFJUJT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261198AbVFJUJT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 16:09:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261205AbVFJUJT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 16:09:19 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:46302 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261198AbVFJUJQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 16:09:16 -0400
Date: Fri, 10 Jun 2005 21:09:09 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Ram <linuxram@us.ibm.com>
Cc: Christoph Hellwig <hch@infradead.org>, Jeff Mahoney <jeffm@suse.com>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] vfs: namei operations should pass nameidata when available
Message-ID: <20050610200909.GA13315@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Ram <linuxram@us.ibm.com>, Jeff Mahoney <jeffm@suse.com>,
	Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20050328200617.GA13280@locomotive.unixthugs.org> <20050328201728.GA12668@infradead.org> <1118430311.4227.10.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1118430311.4227.10.camel@localhost>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 10, 2005 at 12:05:11PM -0700, Ram wrote:
> On Mon, 2005-03-28 at 12:17, Christoph Hellwig wrote:
> > > +	dentry = __lookup_hash(&nd->last, nd->dentry, nd);
> > 
> > Please add a tiny wrapper lookup_hash_nd(struct nameidata *nd)
> > that expands to the above instead of opencoding it everywhere.
> > 
> > Or just call it lookup_hash() after you removed the original version..
> 
> Jeff,
> 
>    I have incorporated the Christophs' comments. 
>    lookup_hash() now takes a third
>    nameidata argument. I touch tested it. If you like the patch can
>    your forward it to Andrew.

No, please wait.  I have a patch series pending for post 2.6.12 that
revamps this code area little, lookup_hash will only take a nameidata *
after that.

