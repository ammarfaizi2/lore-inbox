Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946021AbWBORCK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946021AbWBORCK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 12:02:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946026AbWBORCK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 12:02:10 -0500
Received: from smtp.osdl.org ([65.172.181.4]:9883 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1946021AbWBORCJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 12:02:09 -0500
Date: Wed, 15 Feb 2006 09:01:48 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
cc: linux-arch@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Andrew Morton <akpm@osdl.org>,
       Roland Dreier <rdreier@cisco.com>, Hugh Dickins <hugh@veritas.com>,
       Gleb Natapov <gleb@minantech.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       openib-general@openib.org, Petr Vandrovec <vandrove@vc.cvut.cz>,
       Badari Pulavarty <pbadari@us.ibm.com>, Hugh Dickins <hugh@veritas.com>,
       Matthew Wilcox <matthew@wil.cx>
Subject: Re: [PATCH] add asm-generic/mman.h
In-Reply-To: <20060215151649.GA12090@mellanox.co.il>
Message-ID: <Pine.LNX.4.64.0602150857490.3691@g5.osdl.org>
References: <20060215151649.GA12090@mellanox.co.il>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 15 Feb 2006, Michael S. Tsirkin wrote:
>
> How does the following look (against gc3-git)?

NACK!

This changes the values, and the values are visible to user space.

Different architectures really _do_ have different values, even if (a) 
it's sad and unnecessary and (b) 99% of all apps will never use these 
values and thus never care.

You've changed MS_INVALIDATE from 2 to 4 here.

		Linus
