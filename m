Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753942AbWKHC4K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753942AbWKHC4K (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 21:56:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753944AbWKHC4J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 21:56:09 -0500
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:39297 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1753942AbWKHC4G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 21:56:06 -0500
Date: Wed, 8 Nov 2006 11:57:32 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: clameter@sgi.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       stable@kernel.org, akpm@osdl.org
Subject: Re: [PATCH] Fix sys_move_pages when a NULL node list is passed.
Message-Id: <20061108115732.fcd17f67.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <20061108134744.ffc504ea.sfr@canb.auug.org.au>
References: <20061103144243.4601ba76.sfr@canb.auug.org.au>
	<20061108105648.4a149cca.kamezawa.hiroyu@jp.fujitsu.com>
	<Pine.LNX.4.64.0611071800250.7749@schroedinger.engr.sgi.com>
	<20061108111341.748d034a.kamezawa.hiroyu@jp.fujitsu.com>
	<20061108134744.ffc504ea.sfr@canb.auug.org.au>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Nov 2006 13:47:44 +1100
Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> On Wed, 8 Nov 2006 11:13:41 +0900 KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com> wrote:
> >
> > Ah.. I'm mentioning to this.
> > ==
> > +			pm[i].node = 0;	/* anything to not match MAX_NUMNODES */
> > ==
> > Sorry for my bad cut & paste.
> >
> > It seems that this 0 will be passed to alloc_pages_node().
> > alloc_pages_node() doesn't check whether a node is online or not before using
> > NODE_DATA().
> 
> Actually, it won't.  If you do that assignment, then the nodes parameter
> was NULL and you will only call do_pages_stat() and so never call
> alloc_pages_node().
> 
Ah..Okay, I'm sorry for noise.

-Kame

