Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266124AbUGLNww@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266124AbUGLNww (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 09:52:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266185AbUGLNwv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 09:52:51 -0400
Received: from ozlabs.org ([203.10.76.45]:57287 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S266124AbUGLNwu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 09:52:50 -0400
Date: Mon, 12 Jul 2004 18:57:52 +1000
From: Anton Blanchard <anton@samba.org>
To: Shai Fultheim <shai@scalex86.org>
Cc: "'Andrew Morton'" <akpm@osdl.org>,
       "'Linux Kernel ML'" <linux-kernel@vger.kernel.org>,
       "'Jes Sorensen'" <jes@trained-monkey.org>, mort@wildopensource.com
Subject: Re: [PATCH] PER_CPU [4/4] - PER_CPU-irq_stat
Message-ID: <20040712085752.GB2324@krispykreme>
References: <20040712000218.GC30109@krispykreme> <20040712044410.46293162B72@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040712044410.46293162B72@lists.samba.org>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Anyhow, since that also accesses by other CPUs (not a lot...), I think it's
> better to keep it aligned (the utilization of per-cpu areas is so low now
> that it doesn't really matter).

Ive seen the per cpu data area exceed 32kB on ppc64. Considering the L1
dcache on POWER4 is only 32kB Id prefer not to bloat it any more than
necessary.

Anton
