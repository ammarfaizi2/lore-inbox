Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261837AbSJZCs2>; Fri, 25 Oct 2002 22:48:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261839AbSJZCs2>; Fri, 25 Oct 2002 22:48:28 -0400
Received: from franka.aracnet.com ([216.99.193.44]:54943 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S261837AbSJZCsX>; Fri, 25 Oct 2002 22:48:23 -0400
Date: Fri, 25 Oct 2002 19:51:59 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: "Martin J. Bligh" <mbligh@aracnet.com>
To: "J.A. Magallon" <jamagallon@able.es>
cc: "Nakajima, Jun" <jun.nakajima@intel.com>, Robert Love <rml@tech9.net>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "'Dave Jones'" <davej@codemonkey.org.uk>,
       "'akpm@digeo.com'" <akpm@digeo.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'chrisl@vmware.com'" <chrisl@vmware.com>, colpatch@us.ibm.com
Subject: Re: [PATCH] hyper-threading information in /proc/cpuinfo
Message-ID: <2964027205.1035575518@[10.10.2.3]>
In-Reply-To: <20021026004726.GC1676@werewolf.able.es>
References: <20021026004726.GC1676@werewolf.able.es>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> processor : 0  processor : 2  processor : 4  processor  : 6 
>> package   : 0  package   : 0  package   : 0  package    : 0  
>> core      : 0  core      : 1  core      : 2  core       : 3  
>> 
>> processor : 1  processor : 3  processor : 5  processor  : 7 
>> package   : 1  package   : 1  package   : 1  package    : 1  
>> core      : 0  core      : 1  core      : 2  core       : 3  
>> 
> 
> Er, while you're at it, would it be worthy to add ad:
> 
> node:	x
> 
> for NUMA boxes ?

We also need to indicate other things here though, which is why
Matt Dobson implemented a more complete topology description
under driverfs. If you're really interested in that level of 
detail from userspace, you probably also want to know things 
like whether the evil twins share a TLB cache or L1/L2 cache.
I can't help feeling that's the more correct & complete solution
to the problem. His patches are in the latest -mm tree, and would
need some more work to be extended to hyperthreading, but that
seems like the better way (for 2.5 at least).

M.

