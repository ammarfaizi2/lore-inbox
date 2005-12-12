Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751100AbVLLEt7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751100AbVLLEt7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Dec 2005 23:49:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751102AbVLLEt7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Dec 2005 23:49:59 -0500
Received: from ozlabs.org ([203.10.76.45]:43663 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1751100AbVLLEt7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Dec 2005 23:49:59 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17309.366.751356.538376@cargo.ozlabs.ibm.com>
Date: Mon, 12 Dec 2005 15:49:50 +1100
From: Paul Mackerras <paulus@samba.org>
To: Andrew Morton <akpm@osdl.org>
Cc: paulmck@us.ibm.com, oleg@tv-sign.ru, vatsa@in.ibm.com,
       linux-kernel@vger.kernel.org, dipankar@in.ibm.com
Subject: Re: [PATCH] Fix RCU race in access of nohz_cpu_mask
In-Reply-To: <20051211203226.4deafd59.akpm@osdl.org>
References: <439889FA.BB08E5E1@tv-sign.ru>
	<20051209024623.GA14844@in.ibm.com>
	<4399D852.47E0BB4E@tv-sign.ru>
	<20051210151951.GA2798@in.ibm.com>
	<439B24A7.E2508AAE@tv-sign.ru>
	<20051212031053.GA8748@us.ibm.com>
	<20051211203226.4deafd59.akpm@osdl.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton writes:

> So foo_mb() in preemptible code is potentially buggy.
> 
> I guess we assume that a context switch accidentally did enough of the
> right types of barriers for things to work OK.

The context switch code on powerpc includes an mb() for exactly this
reason.

Paul.
