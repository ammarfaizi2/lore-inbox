Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266721AbUIIShc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266721AbUIIShc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 14:37:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266674AbUIISdr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 14:33:47 -0400
Received: from fw.osdl.org ([65.172.181.6]:23761 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266391AbUIIScb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 14:32:31 -0400
Date: Thu, 9 Sep 2004 11:32:28 -0700
From: Chris Wright <chrisw@osdl.org>
To: BlaisorBlade <blaisorblade_spam@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net,
       Chris Wright <chrisw@osdl.org>, akpm@osdl.org, jdike@addtoit.com,
       linux-kernel@vger.kernel.org
Subject: Re: [uml-devel] Re: [patch 1/1] uml:fix ubd deadlock on SMP
Message-ID: <20040909113228.M1973@build.pdx.osdl.net>
References: <20040908172503.384144933@zion.localdomain> <20040908111204.I1973@build.pdx.osdl.net> <200409092002.19134.blaisorblade_spam@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200409092002.19134.blaisorblade_spam@yahoo.it>; from blaisorblade_spam@yahoo.it on Thu, Sep 09, 2004 at 08:02:19PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* BlaisorBlade (blaisorblade_spam@yahoo.it) wrote:
> On Wednesday 08 September 2004 20:12, Chris Wright wrote:
> > * blaisorblade_spam@yahoo.it (blaisorblade_spam@yahoo.it) wrote:
> > > Trivial: don't lock the queue spinlock when called from the request
> > > function. Since the faulty function must use spinlock in another case,
> > > double-case it. And since we will never use both functions together, let
> > > no object code be shared between them.
> >
> > Why not add a helper which locks around the core function.  Then either
> > call helper or core function directly depending on locking needs?
> I'm happy with whatever is nicer.

The way I outlined is nicer as it avoids all that conditional locking.
I can do a full patch if you like.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
