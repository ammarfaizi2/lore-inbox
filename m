Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263578AbTKKQMj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 11:12:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263592AbTKKQMj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 11:12:39 -0500
Received: from fw.osdl.org ([65.172.181.6]:32157 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263578AbTKKQMi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 11:12:38 -0500
Date: Tue, 11 Nov 2003 08:12:32 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Petr Vandrovec <vandrove@vc.cvut.cz>
cc: linux-kernel@vger.kernel.org, <linux-mm@kvack.org>
Subject: Re: [PATCH?] 2.6.0-test9: mm/memory.c:1075: spin_unlock(kernel/fork.c:c0efed90)
 not locked
In-Reply-To: <20031111150915.GA14601@vana.vc.cvut.cz>
Message-ID: <Pine.LNX.4.44.0311110812060.30657-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 11 Nov 2003, Petr Vandrovec wrote:
> 
>   As far as I can tell, problem is that no_mem case should NOT release page_table_lock
> as it was already released before call to pte_chain_alloc(), and was not reacquired
> yet.

Your patch looks correct to me..

		Linus

