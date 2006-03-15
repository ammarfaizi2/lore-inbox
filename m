Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751359AbWCOVFA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751359AbWCOVFA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 16:05:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751363AbWCOVFA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 16:05:00 -0500
Received: from nommos.sslcatacombnetworking.com ([67.18.224.114]:45977 "EHLO
	nommos.sslcatacombnetworking.com") by vger.kernel.org with ESMTP
	id S1751359AbWCOVE7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 16:04:59 -0500
In-Reply-To: <20060315205306.GC25361@kvack.org>
References: <20060315193114.GA7465@in.ibm.com> <20060315205306.GC25361@kvack.org>
Mime-Version: 1.0 (Apple Message framework v746.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <46E23BE4-4353-472B-90E6-C9E7A3CFFC15@kernel.crashing.org>
Cc: Vivek Goyal <vgoyal@in.ibm.com>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Fastboot mailing list <fastboot@lists.osdl.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Morton Andrew Morton <akpm@osdl.org>, gregkh@suse.de
Content-Transfer-Encoding: 7bit
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [RFC][PATCH] Expanding the size of "start" and "end" field in "struct resource"
Date: Wed, 15 Mar 2006 15:05:30 -0600
To: Benjamin LaHaise <bcrl@kvack.org>
X-Mailer: Apple Mail (2.746.3)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - nommos.sslcatacombnetworking.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - kernel.crashing.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mar 15, 2006, at 2:53 PM, Benjamin LaHaise wrote:

> On Wed, Mar 15, 2006 at 02:31:14PM -0500, Vivek Goyal wrote:
>> Is there a reason why "start" and "end" field of "struct resource"  
>> are of
>> type unsigned long. My understanding is that "struct resource" can  
>> be used
>> to represent any system resource including physical memory. But  
>> unsigned
>> long is not suffcient to represent memory more than 4GB on PAE  
>> systems.
>> and compiler starts throwing warnings.
>
> Please make this depend on the kernel being compiled with PAE.  We  
> don't
> need to bloat 32 bit kernels needlessly.

I disagree.  I think we need to look to see what the "bloat" is  
before we go and make start/end config dependent.

It seems clear that drivers dont handle the fact that "start"/"end"  
change an 32-bit vs 64-bit archs to begin with.  By making this even  
more config dependent seems to be asking for more trouble.

- kumar
