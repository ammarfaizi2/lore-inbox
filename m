Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261728AbUKUCNS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261728AbUKUCNS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 21:13:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261745AbUKUCNS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Nov 2004 21:13:18 -0500
Received: from dp.samba.org ([66.70.73.150]:14515 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S261728AbUKUCNO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Nov 2004 21:13:14 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16799.63876.623759.664933@samba.org>
Date: Sun, 21 Nov 2004 13:12:20 +1100
To: Andrew Morton <akpm@osdl.org>
Cc: reiser@namesys.com, linux-kernel@vger.kernel.org
Subject: Re: performance of filesystem xattrs with Samba4
In-Reply-To: <20041119162651.2d62a6a8.akpm@osdl.org>
References: <16797.41728.984065.479474@samba.org>
	<419E1297.4080400@namesys.com>
	<16798.31565.306237.930372@samba.org>
	<20041119162651.2d62a6a8.akpm@osdl.org>
X-Mailer: VM 7.19 under Emacs 21.3.1
Reply-To: tridge@samba.org
From: tridge@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

 > Is it reproducible with your tricked-up dbench?
 > 
 > If so, please send me a machine description and the relevant command line
 > and I'll do a bsearch.

I should explain a little more ....

The current dbench is showing way too much variance on this test to be
really useful. Here are the numbers for 5 runs of dbench 10 on
2.6.10-rc2 and 2.6.10-rc2-mm2:

2.6.10-rc2          325
		    320
		    364
		    360
		    347


-mm2                347
		    371
		    411
		    322
		    384

I've solved this variance problem in NBENCH by making the runs fixed
time rather than fixed number of operations, and adding a warmup
phase. I need to do the same to dbench in order to get sane numbers
out that would be at all useful for a binary patch search.

The current dbench worked OK when computers were slower, but now it is
completing its runs so fast that the noise is just silly.

Cheers, Tridge
