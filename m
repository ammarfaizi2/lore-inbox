Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264885AbSLBTDj>; Mon, 2 Dec 2002 14:03:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264889AbSLBTDj>; Mon, 2 Dec 2002 14:03:39 -0500
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:32008
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S264885AbSLBTDh>; Mon, 2 Dec 2002 14:03:37 -0500
Subject: Re: [PATCH] set_cpus_allowed() for 2.4
From: Robert Love <rml@tech9.net>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: Christoph Hellwig <hch@sgi.com>, linux-kernel@vger.kernel.org
In-Reply-To: <15851.40133.974155.446342@harpo.it.uu.se>
References: <1033513407.12959.91.camel@phantasy>
	 <20021104223725.A23168@sgi.com> <15851.37989.723028.614451@harpo.it.uu.se>
	 <20021202195120.A25954@sgi.com>  <15851.40133.974155.446342@harpo.it.uu.se>
Content-Type: text/plain
Organization: 
Message-Id: <1038856253.1221.33.camel@phantasy>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 02 Dec 2002 14:10:53 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-12-02 at 12:47, Mikael Pettersson wrote:

> I knew RH8.0 has set_cpus_allowed(), but I wanted to avoid having to check
> for being compiled in a RH-hacked kernel. LINUX_VERSION_CODE doesn't
> distinguish between standard and "with tons of vendor-specific changes" :-(
> 
> I'll use your code then on stock 2.4 kernels, and work out some kludge
> for the RH case.

The code only works on the stock scheduler.  It is the same interface
and has the same behavior as the O(1) scheduler version, but the code is
very very different.

If this patch is merged, you can safely use set_cpus_allowed() in either
kernel (which is the intention).  But you cannot use this routine's code
on either scheduler.

	Robert Love

