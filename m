Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272578AbTHBBLN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Aug 2003 21:11:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272579AbTHBBLN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Aug 2003 21:11:13 -0400
Received: from [63.205.85.133] ([63.205.85.133]:60886 "EHLO gaz.sfgoth.com")
	by vger.kernel.org with ESMTP id S272578AbTHBBLN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Aug 2003 21:11:13 -0400
Date: Fri, 1 Aug 2003 18:16:44 -0700
From: Mitchell Blank Jr <mitch@sfgoth.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RCU: Reduce size of rcu_head 1 of 2
Message-ID: <20030802011644.GG33201@gaz.sfgoth.com>
References: <20030731142545.7bcb50fb.akpm@osdl.org> <20030801230235.E67442C286@lists.samba.org> <20030801160036.029e542b.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030801160036.029e542b.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> > 	Gratuitous change to API during stable series BAD BAD BAD.  If
> > you drop this it stays as is until 2.8.  The extra arg in
> > unneccessary, but breaking it is worse.
> 
> There won't be any out-of-tree users by then.

I must be misunderstanding something.  If the point of the patch is to
shrink "struct rcu_head" (which it seems to do) won't that change
offsets in all sorts of things like "struct dentry"?  I know we
officially don't care about binary modules but a change like that
seems pretty gratuitous for such a small gain.

This sounds like the kind of change that should either happen now or
wait for 2.7.1 (and not be backported into 2.6)

-Mitch
