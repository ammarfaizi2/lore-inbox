Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263125AbUCMQKR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Mar 2004 11:10:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263124AbUCMQKR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Mar 2004 11:10:17 -0500
Received: from ns.suse.de ([195.135.220.2]:16102 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263121AbUCMQKM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Mar 2004 11:10:12 -0500
Date: Sat, 13 Mar 2004 17:10:10 +0100
From: Andi Kleen <ak@suse.de>
To: William Lee Irwin III <wli@holomorphy.com>, Andi Kleen <ak@suse.de>,
       Ray Bryant <raybry@sgi.com>, lse-tech@lists.sourceforge.net,
       "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [Lse-tech] Re: Hugetlbpages in very large memory machines.......
Message-ID: <20040313161010.GB15118@wotan.suse.de>
References: <40528383.10305@sgi.com> <20040313034840.GF4638@wotan.suse.de> <20040313054910.GA655@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040313054910.GA655@holomorphy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > fall back to smaller pages if possible (I was told it isn't easily
> > possible on IA64)
> 
> That's not entirely true. Whether it's feasible depends on how the
> MMU is used. The HPW (Hardware Pagetable Walker) and short mode of the
> VHPT insist upon pagesize being a per-region attribute, where regions
> are something like 60-bit areas of virtualspace, which is likely what
> they're referring to. The VHPT in long mode should be capable of
> arbitrary virtual placement (modulo alignment of course).

Redesigning the low level TLB fault handling for this would not count as
"easily" in my book.

-Andi
