Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423380AbWBBIpJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423380AbWBBIpJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 03:45:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423382AbWBBIpI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 03:45:08 -0500
Received: from smtp.osdl.org ([65.172.181.4]:51357 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1423380AbWBBIpH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 03:45:07 -0500
Date: Thu, 2 Feb 2006 00:44:15 -0800
From: Andrew Morton <akpm@osdl.org>
To: Pekka J Enberg <penberg@cs.Helsinki.FI>
Cc: kevin@koconnor.net, linux-kernel@vger.kernel.org, jgarzik@pobox.com,
       manfred@colorfullife.com
Subject: Re: [PATCH] slab leak detector (Was: Size-128 slab leak)
Message-Id: <20060202004415.28249549.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0602021021240.32240@sbz-30.cs.Helsinki.FI>
References: <Pine.LNX.4.58.0602021021240.32240@sbz-30.cs.Helsinki.FI>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pekka J Enberg <penberg@cs.Helsinki.FI> wrote:
>
>  Here's a version that uses dbg_userword() instead of overriding bufctls 
>  and adds a CONFIG_DEBUG_SLAB_LEAK config option. Upside is that this works 
>  with the slab verifier patch and is less invasive.

What is the slab verifier patch?

> Downside is that now 
>  some slabs don't get leak reports (those that don't get SLAB_STORE_USER 
>  enabled in kmem_cache_create).

Which slabs are those?  SLAB_HWCACHE_ALIGN?  If so, that's quite a lot of
them (more than needed, probably).

