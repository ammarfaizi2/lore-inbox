Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262428AbSJESCz>; Sat, 5 Oct 2002 14:02:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262430AbSJESCz>; Sat, 5 Oct 2002 14:02:55 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:37903
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S262428AbSJESCy>; Sat, 5 Oct 2002 14:02:54 -0400
Subject: Re: [IDE] sleeping function called from illegal context at
	slab.c:1347
From: Robert Love <rml@tech9.net>
To: Andrey Panin <pazke@orbita1.ru>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <43341.172.173.28.251.1033807005.squirrel@mail.orbita1.ru>
References: <43341.172.173.28.251.1033807005.squirrel@mail.orbita1.ru>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 05 Oct 2002 14:08:26 -0400
Message-Id: <1033841307.1247.3706.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-10-05 at 04:36, Andrey Panin wrote:

> looks like i tracked down yet another instance of this already famous 
> message, :)
> but i don't know how to fix it.
> 
> This message produced by IDE driver is IMHO 
> caused by ide_init_queue() function called while holding
> ide_lock spinlock in the 
> init_irq() function (ide-probe.c).
> 
> Then ide_init_queue() calls blk_init_queue() 
> and we have a this call chain:
>     ide_init_queue() -> blk_init_queue() -> 
> blk_init_free_list() -> kmem_cache_alloc()

This is known, but thank you anyhow.

> What can we do to fix this ?

Question of the year :)

	Robert Love

