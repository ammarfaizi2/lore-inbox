Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030299AbWCUL2f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030299AbWCUL2f (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 06:28:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030315AbWCUL2f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 06:28:35 -0500
Received: from smtp.osdl.org ([65.172.181.4]:45252 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030299AbWCUL2e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 06:28:34 -0500
Date: Tue, 21 Mar 2006 03:25:21 -0800
From: Andrew Morton <akpm@osdl.org>
To: Pekka J Enberg <penberg@cs.Helsinki.FI>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] slab: introduce kmem_cache_zalloc allocator
Message-Id: <20060321032521.03a8d6de.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0603201506140.19005@sbz-30.cs.Helsinki.FI>
References: <Pine.LNX.4.58.0603201506140.19005@sbz-30.cs.Helsinki.FI>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pekka J Enberg <penberg@cs.Helsinki.FI> wrote:
>
> This patch introduces a memory-zeroing variant of kmem_cache_alloc.
>

Problem is, after I've weathered 10000000000 convert-to-kmem_cache_zalloc
patches, those pestiferous NUMA people are going to come along wanting
kmem_cache_kzalloc_node().

Probably this should be designed for up-front?
