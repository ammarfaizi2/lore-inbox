Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751864AbWEPQrp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751864AbWEPQrp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 12:47:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751871AbWEPQrp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 12:47:45 -0400
Received: from rhlx01.fht-esslingen.de ([129.143.116.10]:34006 "EHLO
	rhlx01.fht-esslingen.de") by vger.kernel.org with ESMTP
	id S1751864AbWEPQro (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 12:47:44 -0400
Date: Tue, 16 May 2006 18:47:43 +0200
From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
To: Valerie Henson <val_henson@linux.intel.com>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Ulrich Drepper <drepper@redhat.com>,
       Blaisorblade <blaisorblade@yahoo.it>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org,
       Linux Memory Management <linux-mm@kvack.org>,
       Val Henson <val.henson@intel.com>
Subject: Re: [patch 00/14] remap_file_pages protection support
Message-ID: <20060516164743.GA23893@rhlx01.fht-esslingen.de>
References: <20060430172953.409399000@zion.home.lan> <4456D5ED.2040202@yahoo.com.au> <200605030225.54598.blaisorblade@yahoo.it> <445CC949.7050900@redhat.com> <445D75EB.5030909@yahoo.com.au> <4465E981.60302@yahoo.com.au> <20060513181945.GC9612@goober> <4469D3F8.8020305@yahoo.com.au> <20060516135135.GA28995@rhlx01.fht-esslingen.de> <20060516163111.GK9612@goober>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060516163111.GK9612@goober>
User-Agent: Mutt/1.4.2.1i
X-Priority: none
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, May 16, 2006 at 09:31:12AM -0700, Valerie Henson wrote:
> On Tue, May 16, 2006 at 03:51:35PM +0200, Andreas Mohr wrote:
> > 
> > I cannot offer much other than some random confirmation that from my own
> > oprofiling, whatever I did (often running a load test script consisting of
> > launching 30 big apps at the same time), find_vma basically always showed up
> > very prominently in the list of vmlinux-based code (always ranking within the
> > top 4 or 5 kernel hotspots, such as timer interrupts, ACPI idle I/O etc.pp.).
> > call-tracing showed it originating from mmap syscalls etc., and AFAIR quite
> > some find_vma activity from oprofile itself.
> 
> This is important: Which kernel?

I had some traces still showing find_vma prominently during a profiling run
just yesterday, with a very fresh 2.6.17-rc4-ck1 (IOW, basically 2.6.17-rc4).
I added some cache prefetching in the list traversal a while ago, and IIRC
that improved profiling times there, but cache prefetching is very often
a bandaid in search for a real solution: a better data-handling algorithm.

Andreas Mohr
