Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261308AbVALJoG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261308AbVALJoG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 04:44:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261307AbVALJoG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 04:44:06 -0500
Received: from fw.osdl.org ([65.172.181.6]:46059 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261308AbVALJnF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 04:43:05 -0500
Date: Wed, 12 Jan 2005 01:42:35 -0800
From: Andrew Morton <akpm@osdl.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: clameter@sgi.com, torvalds@osdl.org, ak@muc.de, hugh@veritas.com,
       linux-mm@kvack.org, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org, benh@kernel.crashing.org
Subject: Re: page table lock patch V15 [0/7]: overview
Message-Id: <20050112014235.7095dcf4.akpm@osdl.org>
In-Reply-To: <41E4BCBE.2010001@yahoo.com.au>
References: <Pine.LNX.4.44.0411221457240.2970-100000@localhost.localdomain>
	<Pine.LNX.4.58.0411221343410.22895@schroedinger.engr.sgi.com>
	<Pine.LNX.4.58.0411221419440.20993@ppc970.osdl.org>
	<Pine.LNX.4.58.0411221424580.22895@schroedinger.engr.sgi.com>
	<Pine.LNX.4.58.0411221429050.20993@ppc970.osdl.org>
	<Pine.LNX.4.58.0412011539170.5721@schroedinger.engr.sgi.com>
	<Pine.LNX.4.58.0412011545060.5721@schroedinger.engr.sgi.com>
	<Pine.LNX.4.58.0501041129030.805@schroedinger.engr.sgi.com>
	<Pine.LNX.4.58.0501041137410.805@schroedinger.engr.sgi.com>
	<m1652ddljp.fsf@muc.de>
	<Pine.LNX.4.58.0501110937450.32744@schroedinger.engr.sgi.com>
	<41E4BCBE.2010001@yahoo.com.au>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <nickpiggin@yahoo.com.au> wrote:
>
> Christoph Lameter wrote:
>  > Changes from V14->V15 of this patch:
> 
>  Hi,
> 
>  I wonder what everyone thinks about moving forward with these patches?

I was waiting for them to settle down before paying more attention.

My general take is that these patches address a single workload on
exceedingly rare and expensive machines.  If they adversely affect common
and cheap machines via code complexity, memory footprint or via runtime
impact then it would be pretty hard to justify their inclusion.

Do we have measurements of the negative and/or positive impact on smaller
machines?
