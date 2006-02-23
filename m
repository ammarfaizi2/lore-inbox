Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751733AbWBWQuF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751733AbWBWQuF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 11:50:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751743AbWBWQuF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 11:50:05 -0500
Received: from fmr20.intel.com ([134.134.136.19]:34733 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751740AbWBWQuB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 11:50:01 -0500
Message-ID: <43FDE7A7.3090605@linux.intel.com>
Date: Thu, 23 Feb 2006 17:49:43 +0100
From: Arjan van de Ven <arjan@linux.intel.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: linux-kernel@vger.kernel.org, torvalds@osdl.org, akpm@osdl.org,
       mingo@elte.hu
Subject: Re: Patch to reorder functions in the vmlinux to a defined order
References: <1140700758.4672.51.camel@laptopd505.fenrus.org> <200602231700.36333.ak@suse.de> <1140713001.4672.73.camel@laptopd505.fenrus.org> <200602231748.50610.ak@suse.de>
In-Reply-To: <200602231748.50610.ak@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> On Thursday 23 February 2006 17:43, Arjan van de Ven wrote:
>> On Thu, 2006-02-23 at 17:00 +0100, Andi Kleen wrote:
>>> On Thursday 23 February 2006 16:09, Arjan van de Ven wrote:
>>>
>>>> This patch puts the infrastructure in place to allow for a reordering of
>>>> functions based inside the vmlinux. The general idea is that it is possible
>>>> to put all "common" functions into the first 2Mb of the code, so that they
>>>> are covered by one TLB entry. This as opposed to the current situation where
>>>> a typical vmlinux covers about 3.5Mb (on x86-64) and thus 2 TLB entries.
>>>> (This patch depends on the previous patch to pin head.S as first in the order)
>>> I think you would first need to move the code first for that. Currently it starts
>>> at 1MB, which means 1MB is already wasted of the aligned 2MB TLB entry.
>>>
>>> I wouldn't have a problem with moving the 64bit kernel to 2MB though.
>> that was easy since it's a Config entry already ;)
> 
> 
> I assume you boot tested it?

yes it booted on my testbox, and system.map showed the 2 instead of the 1
