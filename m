Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262467AbTH2EOb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 00:14:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264389AbTH2EOb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 00:14:31 -0400
Received: from fw.osdl.org ([65.172.181.6]:49799 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262467AbTH2EOa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 00:14:30 -0400
Date: Thu, 28 Aug 2003 21:17:44 -0700
From: Andrew Morton <akpm@osdl.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: mingo@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] Futex non-page-pinning fix
Message-Id: <20030828211744.3081a058.akpm@osdl.org>
In-Reply-To: <20030829035729.E126C2C0BD@lists.samba.org>
References: <20030828012152.1294f183.akpm@osdl.org>
	<20030829035729.E126C2C0BD@lists.samba.org>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell <rusty@rustcorp.com.au> wrote:
>
> Well, the patch I posted adds a futex_rehash to ___add_to_page_cache,

That's a real hotpath.  Certainly we couldn't take a global lock there.

Need to find a way to rehash when moving pages around only in swapcache.  I
thought the earlier patches were structured that way?


