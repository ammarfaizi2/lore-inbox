Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261844AbTJRVNo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Oct 2003 17:13:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261850AbTJRVNn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Oct 2003 17:13:43 -0400
Received: from pentafluge.infradead.org ([213.86.99.235]:33685 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261844AbTJRVNn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Oct 2003 17:13:43 -0400
Subject: Re: PPC: slab error in cache_free_debugcheck() from
	sd_revalidate_disk
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: John Mock <kd6pag@qsl.net>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <3F919763.1000901@colorfullife.com>
References: <3F919763.1000901@colorfullife.com>
Content-Type: text/plain
Message-Id: <1066511556.4777.286.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 18 Oct 2003 23:12:37 +0200
Content-Transfer-Encoding: 7bit
X-SA-Exim-Mail-From: benh@kernel.crashing.org
X-SA-Exim-Scanned: No; SAEximRunCond expanded to false
X-Pentafluge-Mail-From: <benh@kernel.crashing.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> That looks like a bug Ben reported some time ago: The dma controller 
> trashes the whole cacheline when it transfers data from disk to memory.
> I think the only solution is to disable redzoning for the kmalloc 
> caches, or to use get_free_pages instead of kmalloc for the disk buffers,.

Looks like it indeed. I will probably send a patch to use get_free_page()
instead one of these days (after I've moved)

Ben.


