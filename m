Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261527AbVAXQ4g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261527AbVAXQ4g (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 11:56:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261492AbVAXQxL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 11:53:11 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:50838 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S261533AbVAXQuj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 11:50:39 -0500
Subject: Re: [patch 1/13] Qsort
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: Andi Kleen <ak@muc.de>, Felipe Alfaro Solana <lkml@mac.com>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Buck Huppmann <buchk@pobox.com>, Neil Brown <neilb@cse.unsw.edu.au>,
       Andreas Gruenbacher <agruen@suse.de>,
       "Andries E. Brouwer" <Andries.Brouwer@cwi.nl>,
       Andrew Morton <akpm@osdl.org>, Olaf Kirch <okir@suse.de>
In-Reply-To: <Pine.LNX.4.61.0501230600070.2748@dragon.hygekrogen.localhost>
References: <20050122203326.402087000@blunzn.suse.de>
	 <20050122203618.962749000@blunzn.suse.de>
	 <Pine.LNX.4.58.0501221257440.1982@shell3.speakeasy.net>
	 <FB9BAC88-6CE2-11D9-86B4-000D9352858E@mac.com> <m1r7kc27ix.fsf@muc.de>
	 <Pine.LNX.4.61.0501230357580.2748@dragon.hygekrogen.localhost>
	 <20050123044637.GA54433@muc.de>
	 <Pine.LNX.4.61.0501230600070.2748@dragon.hygekrogen.localhost>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1106512289.6148.31.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 24 Jan 2005 15:45:10 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2005-01-23 at 05:05, Jesper Juhl wrote:
> On Sun, 23 Jan 2005, Andi Kleen wrote:
> Even with large data sets that are mostly unsorted shell sorts performance 
> is close to qsort, and there's an optimization that gives it O(n^(3/2)) 
> runtime (IIRC), and another nice property is that it's iterative so it 
> doesn't eat up stack space (as oposed to qsort which is recursive and eats 
> stack like ****)...

qsort also has bad worst case performance which matters if you are
sorting data provided by a hostile source.

