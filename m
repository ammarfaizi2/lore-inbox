Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261350AbVCPTGC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261350AbVCPTGC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 14:06:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262733AbVCPTF6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 14:05:58 -0500
Received: from mta2.cl.cam.ac.uk ([128.232.0.14]:17024 "EHLO mta2.cl.cam.ac.uk")
	by vger.kernel.org with ESMTP id S261350AbVCPTFf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 14:05:35 -0500
In-Reply-To: <200503161042.03886.jbarnes@engr.sgi.com>
References: <E1DBX0o-0000sV-00@mta1.cl.cam.ac.uk> <20050316181042.GA26788@infradead.org> <521a4568db3e955cb245d10aaba2d3ce@cl.cam.ac.uk> <200503161042.03886.jbarnes@engr.sgi.com>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <c80dab1bc94747ee01d8c0cf9861e6d6@cl.cam.ac.uk>
Content-Transfer-Encoding: 7bit
Cc: akpm@osdl.org, Ian.Pratt@cl.cam.ac.uk, linux-kernel@vger.kernel.org,
       Rik van Riel <riel@redhat.com>, kurt@garloff.de,
       Christoph Hellwig <hch@infradead.org>, Christian.Limpach@cl.cam.ac.uk
From: Keir Fraser <Keir.Fraser@cl.cam.ac.uk>
Subject: Re: [PATCH] Xen/i386 cleanups - AGP bus/phys cleanups
Date: Wed, 16 Mar 2005 19:08:27 +0000
To: Jesse Barnes <jbarnes@engr.sgi.com>
X-Mailer: Apple Mail (2.619.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 16 Mar 2005, at 18:42, Jesse Barnes wrote:

>> The AGP driver is only configurable for ppc32, alpha, x86, x86_64 and
>> ia64, all of which have virt_to_bus.
>
> Yeah, but that doesn't mean it makes sense on all those platforms.  The
> biggest problem with virt_to_bus (well, depending on who you talk to) 
> is that
> it can't handle systems where the address translation must be done
> differently depending on *which* bus we're getting a bus address for.  
> Not
> sure what makes sense in this case though... is the DMA mapping 
> interface
> appropriate?

I think that makes sense. How much code refactoring is needed to make 
use of it, though?

Certainly it will work for Xen and it sounds better than 
virt_to_bus/bus_to_virt, if someone will cook up the alternative patch. 
Otherwise, virt_to_bus seems better than the status quo. :-)

  -- Keir

