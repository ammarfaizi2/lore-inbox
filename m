Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262594AbVAVAse@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262594AbVAVAse (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 19:48:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262584AbVAVArV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 19:47:21 -0500
Received: from fw.osdl.org ([65.172.181.6]:39112 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262567AbVAVAo2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 19:44:28 -0500
Date: Fri, 21 Jan 2005 16:43:53 -0800
From: Andrew Morton <akpm@osdl.org>
To: Paul Mackerras <paulus@samba.org>
Cc: clameter@sgi.com, davem@davemloft.net, hugh@veritas.com,
       linux-ia64@vger.kernel.org, torvalds@osdl.org, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
Subject: Re: Extend clear_page by an order parameter
Message-Id: <20050121164353.6f205fbc.akpm@osdl.org>
In-Reply-To: <16881.40893.35593.458777@cargo.ozlabs.ibm.com>
References: <Pine.LNX.4.58.0501041512450.1536@schroedinger.engr.sgi.com>
	<Pine.LNX.4.44.0501082103120.5207-100000@localhost.localdomain>
	<20050108135636.6796419a.davem@davemloft.net>
	<Pine.LNX.4.58.0501211210220.25925@schroedinger.engr.sgi.com>
	<16881.33367.660452.55933@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.58.0501211545080.27045@schroedinger.engr.sgi.com>
	<16881.40893.35593.458777@cargo.ozlabs.ibm.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Mackerras <paulus@samba.org> wrote:
>
> A cluster of 2^n contiguous pages
>  isn't one page by any normal definition.

It is, actually, from the POV of the page allocator.  It's a "higher order
page" and is controlled by a struct page*, just like a zero-order page...
