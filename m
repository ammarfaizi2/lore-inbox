Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266256AbUGBBlX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266256AbUGBBlX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 21:41:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266372AbUGBBlX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 21:41:23 -0400
Received: from are.twiddle.net ([64.81.246.98]:15501 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id S266256AbUGBBkL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 21:40:11 -0400
Date: Thu, 1 Jul 2004 18:36:36 -0700
From: Richard Henderson <rth@twiddle.net>
To: Jamie Lokier <jamie@shareable.org>
Cc: linux-kernel@vger.kernel.org, David Mosberger-Tang <davidm@hpl.hp.com>,
       linux-ia64@linuxia64.org, Matthew Wilcox <matthew@wil.cx>,
       Grant Grundler <grundler@parisc-linux.org>,
       parisc-linux@parisc-linux.org,
       Richard Curnow <Richard.Curnow@superh.com>,
       Paul Mundt <lethal@linux-sh.org>,
       linuxsh-shmedia-dev@lists.sourceforge.net,
       Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Subject: Re: Comparing PROT_EXEC-only pages on different CPUs
Message-ID: <20040702013636.GA29154@twiddle.net>
Mail-Followup-To: Jamie Lokier <jamie@shareable.org>,
	linux-kernel@vger.kernel.org,
	David Mosberger-Tang <davidm@hpl.hp.com>, linux-ia64@linuxia64.org,
	Matthew Wilcox <matthew@wil.cx>,
	Grant Grundler <grundler@parisc-linux.org>,
	parisc-linux@parisc-linux.org,
	Richard Curnow <Richard.Curnow@superh.com>,
	Paul Mundt <lethal@linux-sh.org>,
	linuxsh-shmedia-dev@lists.sourceforge.net,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>
References: <20040701224016.GB7928@mail.shareable.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040701224016.GB7928@mail.shareable.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 01, 2004 at 11:40:16PM +0100, Jamie Lokier wrote:
> Richard raises an interesting point: exec-only pages are useless if
> the code needs to read jump tables and constant pools.  It seems very
> likely Alpha and IA64 have these.

Only if the processor is crippled enough that mixing jump tables and
constant pools in the same pages as code is considered reasonable.
Anyway, that's a strawman -- it's the toolchain's job to get the bits
on the pt_load segments correct.

If the pt_load segment or the mmap prot argument says execute-only,
then you should honor it.



r~
