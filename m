Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261595AbTJMJWg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Oct 2003 05:22:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261598AbTJMJWg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Oct 2003 05:22:36 -0400
Received: from mail.fh-wedel.de ([213.39.232.194]:23724 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S261595AbTJMJWd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Oct 2003 05:22:33 -0400
Date: Mon, 13 Oct 2003 11:21:38 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: include/linux/nfs/nfsfh.h declares a symbol
Message-ID: <20031013092138.GA16056@wohnheim.fh-wedel.de>
References: <20031001121811.GE31698@wohnheim.fh-wedel.de> <16266.11661.91185.167555@notabene.cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <16266.11661.91185.167555@notabene.cse.unsw.edu.au>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 October 2003 14:43:57 +1000, Neil Brown wrote:
> On Wednesday October 1, joern@wohnheim.fh-wedel.de wrote:
> > Neil, the function SVCFH_fmt uses a static variable to sprintf into.
> > Looks like this variable is declared locally for every .c file
> > including nfsfh.h, which is quite a few.
> > 
> > You could remove the static, but that would increase the stack usage,
> > which might be a problem too.  The buffer could be reduced to 64
> > chars, to reduce that problem.  kmalloc()ing it seems a bit expensive,
> > but might be an option, too.
> 
> Thanks.  I think it is best to simply make SVCFH_fmt a real function
> instead of inline, as below.
> 
> NeilBrown
> 
> =======================================
> Move SVCFH_fmt from being 'inline' to being 'extern'.
> 
> This way, the "static char buf" is defined only once instead
> of once per file.

Patch looks good.  Thanks!

Jörn

-- 
To recognize individual spam features you have to try to get into the
mind of the spammer, and frankly I want to spend as little time inside
the minds of spammers as possible.
-- Paul Graham
