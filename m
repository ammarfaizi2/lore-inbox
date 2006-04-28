Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751730AbWD1AMS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751730AbWD1AMS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 20:12:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751733AbWD1AMS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 20:12:18 -0400
Received: from nommos.sslcatacombnetworking.com ([67.18.224.114]:48022 "EHLO
	nommos.sslcatacombnetworking.com") by vger.kernel.org with ESMTP
	id S1751729AbWD1AMR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 20:12:17 -0400
In-Reply-To: <20060427153432.5f3f4c12.akpm@osdl.org>
References: <Pine.LNX.4.44.0604271242410.25641-100000@gate.crashing.org> <20060427153432.5f3f4c12.akpm@osdl.org>
Mime-Version: 1.0 (Apple Message framework v749.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <116674A8-64F4-4F49-8AAC-06C94159B3B3@kernel.crashing.org>
Cc: greg@kroah.com, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] PCI: Add pci_assign_resource_fixed -- allow fixed address assignments
Date: Thu, 27 Apr 2006 19:12:14 -0500
To: Andrew Morton <akpm@osdl.org>
X-Mailer: Apple Mail (2.749.3)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - nommos.sslcatacombnetworking.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - kernel.crashing.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Apr 27, 2006, at 5:34 PM, Andrew Morton wrote:

> Kumar Gala <galak@kernel.crashing.org> wrote:
>>
>> On some embedded systems the PCI address for hotplug devices are  
>> not only
>> known a priori but are required to be at a given PCI address for  
>> other
>> master in the system to be able to access.
>>
>> An example of such a system would be an FPGA which is setup from  
>> user space
>> after the system has booted.  The FPGA may be access by DSPs in  
>> the system
>> and those DSPs expect the FPGA at a fixed PCI address.
>>
>> Added pci_assign_resource_fixed() as a way to allow assignment of  
>> the PCI
>> devices's BARs at fixed PCI addresses.
>
> Is there any sane way in which we can arrange for this function to  
> not be
> present in vmlinux's which don't need it?
>
> Options would be
>
> a) Put it in a .a file.
>
>    - messy from a source perspective
>
>    - doesn't work if the only reference is from a module
>
>    - small gains anyway.
>
> b) Use CONFIG_EMBEDDED.

I'm fine with wrapping it in a CONFIG_EMBEDDED, Greg?

- k
