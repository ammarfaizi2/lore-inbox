Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266850AbUFYUv6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266850AbUFYUv6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 16:51:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266704AbUFYUv5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 16:51:57 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:65238 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S266786AbUFYUv1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 16:51:27 -0400
Subject: Re: [Lhms-devel] Re: Merging Nonlinear and Numa style memory
	hotplug
From: Dave Hansen <haveblue@us.ibm.com>
To: Yasunori Goto <ygoto@us.fujitsu.com>
Cc: Linux Kernel ML <linux-kernel@vger.kernel.org>,
       Linux Hotplug Memory Support 
	<lhms-devel@lists.sourceforge.net>,
       Linux-Node-Hotplug <lhns-devel@lists.sourceforge.net>,
       linux-mm <linux-mm@kvack.org>,
       "BRADLEY CHRISTIANSEN [imap]" <bradc1@us.ibm.com>
In-Reply-To: <20040625121110.2937.YGOTO@us.fujitsu.com>
References: <20040625114720.2935.YGOTO@us.fujitsu.com>
	 <1088189973.29059.231.camel@nighthawk>
	 <20040625121110.2937.YGOTO@us.fujitsu.com>
Content-Type: text/plain
Message-Id: <1088196579.29059.344.camel@nighthawk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 25 Jun 2004 13:49:40 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-06-25 at 13:45, Yasunori Goto wrote:
> > > Are you sure that all architectures need phys_section?
> > 
> > You don't *need* it, but the alternative is a scan of the mem_section[]
> > array, which would be much, much slower.
> > 
> > Do you have an idea for an alternate implementation?
> 
> I didn't find that scan of the mem_section[] is necessary.
> I thought just that mem_section index = phys_section index.
> May I ask why scan of mem_section is necessary?
> I might still have misunderstood something.

For now, the indexes happen to be the same.  However, for discontiguous
memory systems, this will not be the case

mem | phys
----+-----
    | 
    | 
    | 
    | 

-- Dave

