Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965118AbWHQPFB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965118AbWHQPFB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 11:05:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965119AbWHQPFA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 11:05:00 -0400
Received: from nz-out-0102.google.com ([64.233.162.196]:55366 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S965118AbWHQPE6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 11:04:58 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=DGNheks8FJ9hZfx55RLhnmoyDYJV6qYWhpMxfqjS8XPlF9Bsb2SyZUFlWvCGc9uFPBeZNQK8o0Z3+ceRHYLjE/RM+Kn6PsAqI7yo7J0dhdVitnl34yhO1pnGAgcn4HK9MmFV7U5QuhqwFPoeDBJMcpYL4jhzILuAoGaqqaknJQQ=
Message-ID: <b0943d9e0608170804p11641244w1416290d39663eb7@mail.gmail.com>
Date: Thu, 17 Aug 2006 16:04:52 +0100
From: "Catalin Marinas" <catalin.marinas@gmail.com>
To: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
Subject: Re: [PATCH 2.6.18-rc4 00/10] Kernel memory leak detector 0.9
Cc: linux-kernel@vger.kernel.org, "Ingo Molnar" <mingo@elte.hu>
In-Reply-To: <6bffcb0e0608170748v332cc93cv3f1b79c45800d20d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060812215857.17709.79502.stgit@localhost.localdomain>
	 <6bffcb0e0608130459k1c7e142esbfc2439badf323bd@mail.gmail.com>
	 <b0943d9e0608130713j1e4a8836i943d31011169cf05@mail.gmail.com>
	 <6bffcb0e0608130726x8fc1c0v7717165a63391e80@mail.gmail.com>
	 <b0943d9e0608170602v13dea49bgf64dbf17b7a52273@mail.gmail.com>
	 <6bffcb0e0608170745s8145df4ya4e946c76ab83c1b@mail.gmail.com>
	 <6bffcb0e0608170748v332cc93cv3f1b79c45800d20d@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/08/06, Michal Piotrowski <michal.k.k.piotrowski@gmail.com> wrote:
> > On 17/08/06, Catalin Marinas <catalin.marinas@gmail.com> wrote:
> > > It leaves me with the options of either implementing my own memory
> > > allocator based on pages
>
> [MODSLAB 7/7] A slab allocator: Page Slab allocator
> "The page slab is a specialized slab allocator that can only handle
> page order size object. It directly uses the page allocator to
> track the objects and can therefore avoid the overhead of the
> slabifier."
> http://www.ussg.iu.edu/hypermail/linux/kernel/0608.1/3023.html

But this one allocates page-order size objects. I usually have plenty
of small objects in kmemleak.

-- 
Catalin
