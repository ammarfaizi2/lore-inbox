Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264685AbUHWOb0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264685AbUHWOb0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 10:31:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264668AbUHWOb0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 10:31:26 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:43946 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S264697AbUHWOas (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 10:30:48 -0400
To: "Mukund JB." <mukundjb@esntechnologies.co.in>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Support for HIGHMEM ...can any one explain my Q&A ..
References: <4EE0CBA31942E547B99B3D4BFAB348110B1385@mail.esn.co.in>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 23 Aug 2004 08:29:28 -0600
In-Reply-To: <4EE0CBA31942E547B99B3D4BFAB348110B1385@mail.esn.co.in>
Message-ID: <m18yc6x707.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Mukund JB." <mukundjb@esntechnologies.co.in> writes:

> Hi all,
> Sorry if I asked any thing that basic level stuff?
> This is the paasge I found in the net while surfing for details about
> HIGHMEM stuff.
> 
> During 2.3 kernel development (I think), "HIGHMEM" support was added.
> Normally, the kernel can only address (4GB-PAGE_OFFSET)/PAGE_SIZE pages
> of RAM, since all physical pages must be mapped to kernel addresses
> between PAGE_OFFSET and 4GB. (So if PAGE_OFFSET is 3GB, only 1GB of
> physical RAM can be used - not even that, in practice, due to fixed
> kernel mappings and so forth.) The HIGHMEM patches allow the kernel to
> use more than 1G of memory by mapping the additional pages into the high
> part of the kernel address space just below 4GB as necessary. They also
> allow high-memory pages to be mapped into user process address space.
> 
> 
> ***) Does the above passage mean that PAGE_OFFSET is the starting
> address of my RAM ?

No.  PAGE_OFFSET is the virtual address at which physical address
0 is mapped into an arch/i386 kernel.  

> I understood so from the below line
> "since all physical pages must be mapped to kernel addresses between
> PAGE_OFFSET and 4GB".
> 
> ***) Does it mean that the lowest portion of the 4GB os nothing but RAM
> ?

No.  0-PAGE_OFFSET is the virtual address space provided to user space.
So it has an arbitrary mapping to virtual memory.

Eric
