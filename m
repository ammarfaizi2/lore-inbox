Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261785AbVDEPfV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261785AbVDEPfV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 11:35:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261773AbVDEPfT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 11:35:19 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:7571 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S261794AbVDEPbc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 11:31:32 -0400
Subject: Re: debug: sleeping function...slab.c:2090
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-os@analogic.com
Cc: John M Flinchbaugh <john@hjsoft.com>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0504051036440.16098@chaos.analogic.com>
References: <20050405142836.GA25571@butterfly.hjsoft.com>
	 <Pine.LNX.4.61.0504051036440.16098@chaos.analogic.com>
Content-Type: text/plain
Date: Tue, 05 Apr 2005 17:31:34 +0200
Message-Id: <1112715094.12406.55.camel@notepaq>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Richard,

> > I got the debug statement below during boot.
> >
> > Environment:
> >    Pentium M, Thinkpad R40
> >    Debian unstable
> >    Linux 2.6.12-rc2
> >    Gnu C 3.3.5
> >    binutils 2.15
> >
> > Debug: sleeping function called from invalid context at mm/slab.c:2090
> > in_atomic():1, irqs_disabled():0
> > [<c0103707>] dump_stack+0x17/0x20
> > [<c0114e6c>] __might_sleep+0xac/0xc0
> > [<c014394e>] kmem_cache_alloc+0x5e/0x60
> > [<c0142aa3>] kmem_cache_create+0xe3/0x570
> > [<c0268d39>] proto_register+0x99/0xc0
> > [<e0bea096>] inet6_init+0x16/0x1d0 [ipv6]
> > [<c0132902>] sys_init_module+0x172/0x230
> > [<c01030e5>] syscall_call+0x7/0xb
> >
> 
> What module was being loaded at the time?

this is the ipv6 module and the unix module has the same problem. I
posted this problem already to the netdev mailing list and it seems that
Arnaldo is looking at it.

Regards

Marcel


