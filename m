Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263665AbUEWV5a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263665AbUEWV5a (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 May 2004 17:57:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263679AbUEWV5a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 May 2004 17:57:30 -0400
Received: from holomorphy.com ([207.189.100.168]:19589 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S263665AbUEWV52 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 May 2004 17:57:28 -0400
Date: Sun, 23 May 2004 14:53:30 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Horst von Brand <vonbrand@inf.utfsm.cl>,
       Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.7-rc1
Message-ID: <20040523215330.GG1833@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Jeff Garzik <jgarzik@pobox.com>,
	Horst von Brand <vonbrand@inf.utfsm.cl>,
	Linus Torvalds <torvalds@osdl.org>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200405231619.i4NGJBe18903@pincoya.inf.utfsm.cl> <40B0EE6C.70400@pobox.com> <20040523211154.GC1833@holomorphy.com> <40B1180F.8000501@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40B1180F.8000501@pobox.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
>> I wouldn't qualify either of the major VM patch series merged as
>> rewrites. I saw:
>> (1) move unmapping function/helpers to different algorithm to save space
>> (2) NUMA API and support functions

On Sun, May 23, 2004 at 05:30:55PM -0400, Jeff Garzik wrote:
> You missed the pte chains going away, a fundamental change in the way 
> reverse mapping is done?

(1) describes that in more detail than "pte_chains going away". It's
just a search algorithm. For anonymous pages, anon_vma just strobes
offsets into vma inheritance chains, and anonmm just strobes vaddrs in
all forks between execs, for file-backed memory they both use ->i_mmap.
Yes, they can both be summarized in the same sentence. The scope of the
changes are very limited and the presentation of them is a very clearly
documented and incremental series of small changes.


-- wli
