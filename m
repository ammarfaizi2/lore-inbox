Return-Path: <linux-kernel-owner+w=401wt.eu-S1753051AbWLTAWR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753051AbWLTAWR (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 19:22:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753022AbWLTAWR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 19:22:17 -0500
Received: from smtp.osdl.org ([65.172.181.25]:48536 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753052AbWLTAWQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 19:22:16 -0500
Date: Tue, 19 Dec 2006 16:22:08 -0800
From: Andrew Morton <akpm@osdl.org>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Michal Sabala <lkml@saahbs.net>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.18 mmap hangs unrelated apps
Message-Id: <20061219162208.f96e2fef.akpm@osdl.org>
In-Reply-To: <1166573863.5768.10.camel@lade.trondhjem.org>
References: <20061215023014.GC2721@prosiaczek>
	<1166199855.5761.34.camel@lade.trondhjem.org>
	<20061215175030.GG6220@prosiaczek>
	<1166211884.5761.49.camel@lade.trondhjem.org>
	<20061215210642.GI6220@prosiaczek>
	<1166219054.5761.56.camel@lade.trondhjem.org>
	<20061219142624.230b28c0.akpm@osdl.org>
	<1166570378.5760.52.camel@lade.trondhjem.org>
	<20061219160315.ea83ca38.akpm@osdl.org>
	<1166573863.5768.10.camel@lade.trondhjem.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Dec 2006 19:17:43 -0500
Trond Myklebust <trond.myklebust@fys.uio.no> wrote:

> > (We were supposed to stop doing that about four years ago - change it so
> > that all a_ops must implement ->releasepage, but nobody got around to it).
> 
> Would you still be interested in seeing this done?

Sure, when things calm down.  It's just a cleanup.

There are various places where we got lazy and did this.  ->set_page_dirty,
->page_mkwrite, many others.  With varying degrees of consequential ugliness.
