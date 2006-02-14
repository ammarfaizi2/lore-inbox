Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161097AbWBNP5j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161097AbWBNP5j (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 10:57:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161101AbWBNP5j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 10:57:39 -0500
Received: from gold.veritas.com ([143.127.12.110]:19030 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S1161097AbWBNP5i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 10:57:38 -0500
X-IronPort-AV: i="4.02,114,1139212800"; 
   d="scan'208"; a="55118073:sNHT30887688"
Date: Tue, 14 Feb 2006 15:58:16 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Gerald Britton <gbritton@alum.mit.edu>
cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       phil.el@wanadoo.fr, linux-kernel@vger.kernel.org,
       oprofile-list@lists.sourceforge.net
Subject: Re: [PATCH] x86: fix oprofile kernel callgraph regression
In-Reply-To: <20060214151904.GA30639@fog.sekrit.org>
Message-ID: <Pine.LNX.4.61.0602141555050.15589@goblin.wat.veritas.com>
References: <Pine.LNX.4.64.0602121709240.3691@g5.osdl.org>
 <20060212190520.244fcaec.akpm@osdl.org> <20060214151904.GA30639@fog.sekrit.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 14 Feb 2006 15:57:37.0552 (UTC) FILETIME=[6074E900:01C6317F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Feb 2006, Gerald Britton wrote:

> Fix x86 oprofile regression introduced by:
>   commit c34d1b4d165c67b966bca4aba026443d7ff161eb
>   [PATCH] mm: kill check_user_page_readable
> 
> That commit reorganized tests for the userspace stack walking moving all
> those tests into dump_backtrace(), however, dump_backtrace() was used for
> both userspace and kernel stalk walking.  The result is typically no
> recorded callgraph information for kernel samples.
> 
> Revive the original function as dump_kernel_backtrace() and rename the
> other to dump_user_backtrace() to avoid future confusion.
> 
> Signed-off-by: Gerald Britton <gbritton@alum.mit.edu>

Apology-from: Hugh Dickins <hugh@veritas.com>
