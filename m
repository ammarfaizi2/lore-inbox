Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751375AbWCULct@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751375AbWCULct (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 06:32:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751391AbWCULct
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 06:32:49 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:12771 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1751375AbWCULcs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 06:32:48 -0500
Date: Tue, 21 Mar 2006 13:32:42 +0200 (EET)
From: Pekka J Enberg <penberg@cs.Helsinki.FI>
To: Bodo Eggert <7eggert@gmx.de>
cc: Balbir Singh <balbir@in.ibm.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] slab: introduce kmem_cache_zalloc allocator
In-Reply-To: <Pine.LNX.4.58.0603211137170.3292@be1.lrz>
Message-ID: <Pine.LNX.4.58.0603211331250.23993@sbz-30.cs.Helsinki.FI>
References: <5Ssjj-314-69@gated-at.bofh.it> <5Sv7o-7l5-23@gated-at.bofh.it>
 <5Svh9-7xW-61@gated-at.bofh.it> <5SvK8-88q-41@gated-at.bofh.it>
 <E1FLPjT-0000o9-Sy@be1.lrz> <20060321032520.GB8954@in.ibm.com>
 <Pine.LNX.4.58.0603211137170.3292@be1.lrz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Mar 2006, Bodo Eggert wrote:
> Yes. At least that's what I understand from the whole zalloc process.

Zalloc does two things: (1) reduce human error and (2) shrink kernel text 
size. Pre-zeroing is a possible optimization but needs to be measured. It 
is not necessarily a positive gain due to cache effects.

				Pekka 
