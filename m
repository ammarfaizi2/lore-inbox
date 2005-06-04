Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261198AbVFDA7g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261198AbVFDA7g (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Jun 2005 20:59:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261199AbVFDA7g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Jun 2005 20:59:36 -0400
Received: from holomorphy.com ([66.93.40.71]:59045 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261198AbVFDA7e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Jun 2005 20:59:34 -0400
Date: Fri, 3 Jun 2005 17:59:30 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Subrahmanyam Ongole <songole@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: x86-64: Kernel with large page size
Message-ID: <20050604005930.GA31508@holomorphy.com>
References: <a8447f24050603175061598809@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a8447f24050603175061598809@mail.gmail.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 03, 2005 at 05:50:55PM -0700, Subrahmanyam Ongole wrote:
> When we run our application on AMD Opteron processors, we are seeing a
> large number of   L1_AND_L2_DTLB_MISSES. We used oprofile to measure
> these numbers.
> We wanted to try with a bigger page size and see if we could bring it
> down. TLB caches 4k page translations. I don't  know if larger page
> size would even help here.
> I  changed PAGE_SHIFT to 14 ( 16k page size ) in include/asm/page.h
> and recompiled kernel and modules.   It crashed ( PANIC: early
> exception ) at the very initial stage of loading the image.
> I looked at some of the mailing list archives for any information on
> this. I couldn't find anything on this subject . I appreciate any help
> on this.
> There seem to be two 2-4MB page translations in L1 TLB cache on AMD
> machines. Will it be used only when the page size is 2MB or can they
> be used with smaller page sizes too.

PAGE_SIZE at the moment is intimately tied to the MMU's notions of
address translation, which are determined by hardware.


-- wli
