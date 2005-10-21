Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964861AbVJUD5R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964861AbVJUD5R (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Oct 2005 23:57:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964862AbVJUD5R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Oct 2005 23:57:17 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:4264 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S964861AbVJUD5Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Oct 2005 23:57:16 -0400
Message-ID: <435866E0.8080305@jp.fujitsu.com>
Date: Fri, 21 Oct 2005 12:56:16 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: mike kravetz <kravetz@us.ibm.com>
CC: Andrew Morton <akpm@osdl.org>, Christoph Lameter <clameter@sgi.com>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org, magnus.damm@gmail.com,
       marcelo.tosatti@cyclades.com
Subject: Re: [PATCH 0/4] Swap migration V3: Overview
References: <20051020225935.19761.57434.sendpatchset@schroedinger.engr.sgi.com> <20051020160638.58b4d08d.akpm@osdl.org> <20051020234621.GL5490@w-mikek2.ibm.com> <43585EDE.3090704@jp.fujitsu.com> <20051021033223.GC6846@w-mikek2.ibm.com>
In-Reply-To: <20051021033223.GC6846@w-mikek2.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mike kravetz wrote:
>>>Just to be clear, there are at least two distinct requirements for hotplug.
>>>One only wants to remove a quantity of memory (location unimportant).  The
>>>other wants to remove a specific section of memory (location specific).  I
>>>think the first is easier to address.
>>>
>>
>>The only difficulty to remove a quantity of memory is how to find
>>where is easy to be removed. If this is fixed, I think it is
>>easier to address.
> 
> 
> We have been using Mel's fragmentation patches.  One of the data structures
> created by these patches is a 'usemap' thats tracks how 'blocks' of memory
> are used.  I exposed the usemaps via sysfs along with other hotplug memory
> section attributes.  So, you can then have a user space program scan the
> usemaps looking for sections that can be easily offlined.
> 
yea, looks nice :)
But such pages are already shown as hotpluggable, I think.
ACPI/SRAT will define the range, in ia64.

The difficulty is how to find hard-to-migrate pages, as Andrew pointed out.



Thanks,
-- Kame

