Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264493AbTEaQaR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 May 2003 12:30:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264496AbTEaQaR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 May 2003 12:30:17 -0400
Received: from ns.suse.de ([213.95.15.193]:37390 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S264493AbTEaQaQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 May 2003 12:30:16 -0400
To: rwhron@earthlink.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BENCHMARKS] 2.5.70 for 4 filesystems
References: <20030531163339.GA9426@rushmore.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 31 May 2003 18:43:36 +0200
In-Reply-To: <20030531163339.GA9426@rushmore.suse.lists.linux.kernel>
Message-ID: <p73add36p8n.fsf@oldwotan.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

rwhron@earthlink.net writes: 
>                   --------------- Sequential ----------
>                   ----- Create -----   ---- Delete ----
>                    /sec  %CPU    Eff   /sec  %CPU   Eff
> 2.5.70-reiserfs    7584  86.7   8751   2628  37.3  7038
> 2.5.70-xfs         1710  39.3   4347   2053  28.3  7247
> 2.5.70-ext2         150  99.0    151  60883 100.0  6088
> 2.5.70-ext3         119  95.0    126  26319  87.7  3002

It's quite surprising that reiserfs is so slow at deletion. In my
normal experience reiserfs rm -rf is much faster than anything else
(e.g. with a big rm -rf on an ext2 you have a chance to ctrl-c still,
on reiserfs no such chance; XFS is really slow at this). Perhaps this
is some 2.5 regression? Do you have 2.4 comparison numbers?

-Andi 

