Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261500AbUCUXHo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Mar 2004 18:07:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261533AbUCUXHn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Mar 2004 18:07:43 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:36008 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261500AbUCUXGj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Mar 2004 18:06:39 -0500
Message-ID: <405E1FF0.60805@pobox.com>
Date: Sun, 21 Mar 2004 18:06:24 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Woodhouse <dwmw2@infradead.org>
CC: Russell King <rmk+lkml@arm.linux.org.uk>,
       Linus Torvalds <torvalds@osdl.org>,
       Christoph Hellwig <hch@infradead.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       Andrew Morton <akpm@osdl.org>, Andrea Arcangeli <andrea@suse.de>,
       linux-kernel@vger.kernel.org
Subject: Re: can device drivers return non-ram via vm_ops->nopage?
References: <20040320144022.GC2045@holomorphy.com>	 <20040320150621.GO9009@dualathlon.random>	 <20040320121345.2a80e6a0.akpm@osdl.org>	 <20040320205053.GJ2045@holomorphy.com>	 <20040320222639.K6726@flint.arm.linux.org.uk>	 <20040320224500.GP2045@holomorphy.com>	 <1079901914.17681.317.camel@imladris.demon.co.uk>	 <20040321204931.A11519@infradead.org>	 <1079902670.17681.324.camel@imladris.demon.co.uk>	 <Pine.LNX.4.58.0403211349340.1106@ppc970.osdl.org>	 <20040321222327.D26708@flint.arm.linux.org.uk> <405E1859.5030906@pobox.com> <1079908923.17681.453.camel@imladris.demon.co.uk>
In-Reply-To: <1079908923.17681.453.camel@imladris.demon.co.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Woodhouse wrote:
> On Sun, 2004-03-21 at 17:34 -0500, Jeff Garzik wrote:
> 
>>Tell driver writers to call a standard platform function with a 
>>{dma|mmio|pio|vmalloc} handle+size+len for {dma|mmio|pio|vmalloc} mmap 
>>setup, and {fault|nopage} handler.  ;-)  IMO they shouldn't have to care 
>>about the details.
> 
> 
> Don't let drivers see the {fault|nopage} handler. On most arches it can
> probably continue to be nopage(); other arches may use the
> newly-proposed fault() or perhaps just put all the PTEs in place up
> front. The driver shouldn't be given an opportunity to care.

If that's possible within the MM APIs... certainly.  Have a standard 
struct vm_operations_struct for dma, dma s/g, mmio, ... I presume?

	Jeff



