Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261587AbVALX3T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261587AbVALX3T (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 18:29:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261584AbVALX0s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 18:26:48 -0500
Received: from fw.osdl.org ([65.172.181.6]:35246 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261560AbVALX0J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 18:26:09 -0500
Date: Wed, 12 Jan 2005 15:30:33 -0800
From: Andrew Morton <akpm@osdl.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: clameter@sgi.com, torvalds@osdl.org, ak@muc.de, hugh@veritas.com,
       linux-mm@kvack.org, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org, benh@kernel.crashing.org
Subject: Re: page table lock patch V15 [0/7]: overview
Message-Id: <20050112153033.6e2e4c6e.akpm@osdl.org>
In-Reply-To: <41E5AFE6.6000509@yahoo.com.au>
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
	<20050112014235.7095dcf4.akpm@osdl.org>
	<Pine.LNX.4.58.0501120833060.10380@schroedinger.engr.sgi.com>
	<20050112104326.69b99298.akpm@osdl.org>
	<41E5AFE6.6000509@yahoo.com.au>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <nickpiggin@yahoo.com.au> wrote:
>
> So my patches cost about 7% in lmbench fork benchmark.

OK, well that's the sort of thing we need to understand fully.  What sort
of CPU was that on?

Look, -7% on a 2-way versus +700% on a many-way might well be a tradeoff we
agree to take.  But we need to fully understand all the costs and benefits.
