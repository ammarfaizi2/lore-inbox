Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030630AbWBIKmN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030630AbWBIKmN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 05:42:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030628AbWBIKmN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 05:42:13 -0500
Received: from ns2.suse.de ([195.135.220.15]:47291 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030627AbWBIKmL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 05:42:11 -0500
From: Andi Kleen <ak@suse.de>
To: discuss@x86-64.org
Subject: Re: [discuss] Re: [RFC:PATCH(003/003)] Memory add to onlined node. (ver. 2) (For x86_64)
Date: Thu, 9 Feb 2006 11:41:43 +0100
User-Agent: KMail/1.8.2
Cc: Yasunori Goto <y-goto@jp.fujitsu.com>,
       "Tolentino, Matthew E" <matthew.e.tolentino@intel.com>,
       "Brown, Len" <len.brown@intel.com>, naveen.b.s@intel.com,
       Bjorn Helgaas <bjorn.helgaas@hp.com>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>,
       ACPI-ML <linux-acpi@vger.kernel.org>,
       Linux Hotplug Memory Support 
	<lhms-devel@lists.sourceforge.net>
References: <20060209153803.6CF4.Y-GOTO@jp.fujitsu.com> <20060209164036.6CFC.Y-GOTO@jp.fujitsu.com>
In-Reply-To: <20060209164036.6CFC.Y-GOTO@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602091141.44456.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 09 February 2006 10:50, Yasunori Goto wrote:

> Current code adds memory to ZONE_NORMAL like this.
> But, ZONE_DMA32 is available on 2.6.15. So, I'm afraid there are
> 2 types trouble.
> 
>   a) When new memory is added to < 4GB, this should be added to 
>      Zone_DMA32.
>      Are there any real machine which allow to add memory under
>      4GB?

x86-64 machines usually use a continuous memory map 
because Windows gets unhappy with too big memory holes (and even
Linux is not completely troublefree for UP install kernels)  And for a small
system this implies memory < 4GB.

>   b) If machine boots up with under 4GB memory, and new memory 
>      is added to over 4GB, then kernel might panic due to Zone Normal's
>      initialization is imcomplete.
>   
> Q2) 
>   Are there any real machine which can add memory with NUMA feature?

There are and will be.

-Andi
