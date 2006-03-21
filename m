Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423204AbWCUSh2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423204AbWCUSh2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 13:37:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423130AbWCUSh1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 13:37:27 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:57988 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1423204AbWCUShX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 13:37:23 -0500
Subject: Re: [PATCH] slab: introduce kmem_cache_zalloc allocator
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <44204754.8070401@colorfullife.com>
References: <Pine.LNX.4.58.0603201506140.19005@sbz-30.cs.Helsinki.FI>
	 <20060321023654.389dc572.akpm@osdl.org>
	 <Pine.LNX.4.58.0603211250530.22577@sbz-30.cs.Helsinki.FI>
	 <44204754.8070401@colorfullife.com>
Date: Tue, 21 Mar 2006 20:37:21 +0200
Message-Id: <1142966242.23941.0.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution 2.4.2.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-03-21 at 19:35 +0100, Manfred Spraul wrote:
> One minor point: There are two cache_alloc entry points: __cache_alloc, 
> which is a forced inline function, and kmem_cache_alloc, which is just a 
> wrapper for __cache_alloc. Is it really necessary to call __cache_alloc?

Unfortunately, yes. Using kmem_cache_alloc screws up caller tracing.

				Pekka

