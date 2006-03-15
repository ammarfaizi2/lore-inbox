Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751200AbWCOV3p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751200AbWCOV3p (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 16:29:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751364AbWCOV3p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 16:29:45 -0500
Received: from nommos.sslcatacombnetworking.com ([67.18.224.114]:59807 "EHLO
	nommos.sslcatacombnetworking.com") by vger.kernel.org with ESMTP
	id S1751200AbWCOV3o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 16:29:44 -0500
In-Reply-To: <20060315211335.GD25361@kvack.org>
References: <20060315193114.GA7465@in.ibm.com> <20060315205306.GC25361@kvack.org> <46E23BE4-4353-472B-90E6-C9E7A3CFFC15@kernel.crashing.org> <20060315211335.GD25361@kvack.org>
Mime-Version: 1.0 (Apple Message framework v746.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <90BA5A4C-6EC1-47E2-954A-5EDEB240DD4B@kernel.crashing.org>
Cc: Vivek Goyal <vgoyal@in.ibm.com>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Fastboot mailing list <fastboot@lists.osdl.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Morton Andrew Morton <akpm@osdl.org>, gregkh@suse.de
Content-Transfer-Encoding: 7bit
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [RFC][PATCH] Expanding the size of "start" and "end" field in "struct resource"
Date: Wed, 15 Mar 2006 15:30:14 -0600
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


On Mar 15, 2006, at 3:13 PM, Benjamin LaHaise wrote:

> On Wed, Mar 15, 2006 at 03:05:30PM -0600, Kumar Gala wrote:
>> I disagree.  I think we need to look to see what the "bloat" is
>> before we go and make start/end config dependent.
>
> Eh?  32 bit kernels get used in embedded systems, which includes those
> with only 8MB of RAM.  The upper 32 bits will never be anything other
> than 0.

Why do people equate embedded with small amounts of memory.  I know  
of embedded systems which use 32-bit PowerPCs that have >4G of system  
memory.

>> It seems clear that drivers dont handle the fact that "start"/"end"
>> change an 32-bit vs 64-bit archs to begin with.  By making this even
>> more config dependent seems to be asking for more trouble.
>
> You can't get a non-32 bit value on a 32 bit platform, so why should a
> driver be expected to handle anything?

I dont follow.  I would say that most drivers shouldn't care about  
the fact that they are on a 32-bit platform or 64-bit platform.  The  
point is that drivers have made assumptions about being on 32-bit  
platforms which breaks when a 32-bit platform supports a larger  
physical address space.

- kumar
