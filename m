Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270734AbTHBBnr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Aug 2003 21:43:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270976AbTHBBnr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Aug 2003 21:43:47 -0400
Received: from waste.org ([209.173.204.2]:6821 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S270734AbTHBBnq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Aug 2003 21:43:46 -0400
Date: Fri, 1 Aug 2003 20:43:24 -0500
From: Matt Mackall <mpm@selenic.com>
To: Mitchell Blank Jr <mitch@sfgoth.com>
Cc: Andrew Morton <akpm@osdl.org>, Rusty Russell <rusty@rustcorp.com.au>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RCU: Reduce size of rcu_head 1 of 2
Message-ID: <20030802014324.GQ6049@waste.org>
References: <20030731142545.7bcb50fb.akpm@osdl.org> <20030801230235.E67442C286@lists.samba.org> <20030801160036.029e542b.akpm@osdl.org> <20030802011644.GG33201@gaz.sfgoth.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030802011644.GG33201@gaz.sfgoth.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 01, 2003 at 06:16:44PM -0700, Mitchell Blank Jr wrote:
> Andrew Morton wrote:
> > > 	Gratuitous change to API during stable series BAD BAD BAD.  If
> > > you drop this it stays as is until 2.8.  The extra arg in
> > > unneccessary, but breaking it is worse.
> > 
> > There won't be any out-of-tree users by then.
> 
> I must be misunderstanding something.  If the point of the patch is to
> shrink "struct rcu_head" (which it seems to do) won't that change
> offsets in all sorts of things like "struct dentry"?  I know we
> officially don't care about binary modules but a change like that
> seems pretty gratuitous for such a small gain.

Repeat after me: there is no module ABI.

-- 
Matt Mackall : http://www.selenic.com : of or relating to the moon
