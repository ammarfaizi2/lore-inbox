Return-Path: <linux-kernel-owner+w=401wt.eu-S965223AbWL2WZV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965223AbWL2WZV (ORCPT <rfc822;w@1wt.eu>);
	Fri, 29 Dec 2006 17:25:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755070AbWL2WZV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Dec 2006 17:25:21 -0500
Received: from smtp.osdl.org ([65.172.181.25]:59599 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752978AbWL2WZU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Dec 2006 17:25:20 -0500
Date: Fri, 29 Dec 2006 14:24:35 -0800
From: Andrew Morton <akpm@osdl.org>
To: Linus Torvalds <torvalds@osdl.org>,
       Segher Boessenkool <segher@kernel.crashing.org>,
       David Miller <davem@davemloft.net>, nickpiggin@yahoo.com.au,
       kenneth.w.chen@intel.com, guichaz@yahoo.fr, hugh@veritas.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ranma@tdiedrich.de, gordonfarquharson@gmail.com, a.p.zijlstra@chello.nl,
       tbm@cyrius.com, arjan@infradead.org, andrei.popa@i-neo.ro
Subject: Re: Ok, explained.. (was Re: [PATCH] mm: fix page_mkclean_one)
Message-Id: <20061229142435.d78a1293.akpm@osdl.org>
In-Reply-To: <20061229141632.51c8c080.akpm@osdl.org>
References: <Pine.LNX.4.64.0612281125100.4473@woody.osdl.org>
	<20061228114517.3315aee7.akpm@osdl.org>
	<Pine.LNX.4.64.0612281156150.4473@woody.osdl.org>
	<20061228.143815.41633302.davem@davemloft.net>
	<3d6d8711f7b892a11801d43c5996ebdf@kernel.crashing.org>
	<Pine.LNX.4.64.0612282155400.4473@woody.osdl.org>
	<Pine.LNX.4.64.0612290017050.4473@woody.osdl.org>
	<Pine.LNX.4.64.0612290202350.4473@woody.osdl.org>
	<20061229141632.51c8c080.akpm@osdl.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Dec 2006 14:16:32 -0800
Andrew Morton <akpm@osdl.org> wrote:

> - Poor old IO accounting broke again.

No it didn't - we're relying upon the behaviour of __set_page_dirty_buffers()
against an already-dirty page.
