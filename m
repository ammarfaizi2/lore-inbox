Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262570AbVCWAWP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262570AbVCWAWP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 19:22:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262572AbVCWAWP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 19:22:15 -0500
Received: from dsl027-180-174.sfo1.dsl.speakeasy.net ([216.27.180.174]:17820
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S262570AbVCWAWI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 19:22:08 -0500
Date: Tue, 22 Mar 2005 16:20:28 -0800
From: "David S. Miller" <davem@davemloft.net>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: hugh@veritas.com, akpm@osdl.org, tony.luck@intel.com,
       benh@kernel.crashing.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] freepgt: free_pgtables use vma list
Message-Id: <20050322162028.742d688f.davem@davemloft.net>
In-Reply-To: <4240B61A.9070909@yahoo.com.au>
References: <Pine.LNX.4.61.0503212048040.1970@goblin.wat.veritas.com>
	<20050322034053.311b10e6.akpm@osdl.org>
	<Pine.LNX.4.61.0503221617440.8666@goblin.wat.veritas.com>
	<20050322110144.3a3002d9.davem@davemloft.net>
	<20050322112125.0330c4ee.davem@davemloft.net>
	<20050322112329.70bde057.davem@davemloft.net>
	<Pine.LNX.4.61.0503221931150.9348@goblin.wat.veritas.com>
	<20050322123301.090cbfa6.davem@davemloft.net>
	<Pine.LNX.4.61.0503222142280.9761@goblin.wat.veritas.com>
	<4240AAFA.1040206@yahoo.com.au>
	<20050322154459.7afb4f4f.davem@davemloft.net>
	<4240B61A.9070909@yahoo.com.au>
X-Mailer: Sylpheed version 1.0.1 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Mar 2005 11:19:38 +1100
Nick Piggin <nickpiggin@yahoo.com.au> wrote:

> > dramatically, shell performance is way down on sparc64.
> > I'll post before and after numbers in a bit.  Note, this is
> > just with Hugh's base patch plus bug fixes.
> > 
> 
> That's interesting. The only "extra" stuff Hugh's should be
> doing is the vma traversal.

Like I said in another posting, ignore this anomaly.
It's some difference in the way the shell runs
when done from "init=/bin/sh" single user vs. full
multi-user.  Full sparc64 before/after in that posting,
go check it out it's nice :-)
