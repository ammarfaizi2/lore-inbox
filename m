Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262731AbVCPSdh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262731AbVCPSdh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 13:33:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262734AbVCPSdh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 13:33:37 -0500
Received: from mta2.cl.cam.ac.uk ([128.232.0.14]:48364 "EHLO mta2.cl.cam.ac.uk")
	by vger.kernel.org with ESMTP id S262731AbVCPScc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 13:32:32 -0500
In-Reply-To: <20050316181042.GA26788@infradead.org>
References: <E1DBX0o-0000sV-00@mta1.cl.cam.ac.uk> <20050316143130.GA21959@infradead.org> <Pine.LNX.4.61.0503160959530.4104@chimarrao.boston.redhat.com> <20050316181042.GA26788@infradead.org>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <521a4568db3e955cb245d10aaba2d3ce@cl.cam.ac.uk>
Content-Transfer-Encoding: 7bit
Cc: akpm@osdl.org, Ian.Pratt@cl.cam.ac.uk, linux-kernel@vger.kernel.org,
       Rik van Riel <riel@redhat.com>, kurt@garloff.de,
       Christian.Limpach@cl.cam.ac.uk
From: Keir Fraser <Keir.Fraser@cl.cam.ac.uk>
Subject: Re: [PATCH] Xen/i386 cleanups - AGP bus/phys cleanups
Date: Wed, 16 Mar 2005 18:35:28 +0000
To: Christoph Hellwig <hch@infradead.org>
X-Mailer: Apple Mail (2.619.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 16 Mar 2005, at 18:10, Christoph Hellwig wrote:

> On Wed, Mar 16, 2005 at 10:01:07AM -0500, Rik van Riel wrote:
>> In the case of AGP, the AGPGART effectively _is_ the
>> IOMMU.  Calculating the addresses right for programming
>> the AGPGART is probably worth fixing.
>
> Well, it's a half-assed one.  And some systems have a real one.
>
> But the real problem is that virt_to_bus doesn't exist at all
> on architectures like ppc64, and this patch touches files like
> generic.c and backend.c that aren't PC-specific.   So you
> effectively break agp support for them.

The AGP driver is only configurable for ppc32, alpha, x86, x86_64 and 
ia64, all of which have virt_to_bus.

  -- Keir

