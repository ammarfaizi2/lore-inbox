Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269949AbUJHA4B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269949AbUJHA4B (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 20:56:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269894AbUJHAxM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 20:53:12 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:10661 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S269952AbUJHAqS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 20:46:18 -0400
Date: Fri, 08 Oct 2004 09:51:40 +0900
From: Hiroyuki KAMEZAWA <kamezawa.hiroyu@jp.fujitsu.com>
Subject: Re: [PATCH]  no buddy bitmap patch : intro and includes [0/2]
In-reply-to: <1260090000.1097164623@[10.10.2.4]>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Dave Hansen <haveblue@us.ibm.com>,
       Matthew E Tolentino <matthew.e.tolentino@intel.com>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>, lhms <lhms-devel@lists.sourceforge.net>,
       Andrew Morton <akpm@osdl.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       "Luck, Tony" <tony.luck@intel.com>,
       Hirokazu Takahashi <taka@valinux.co.jp>,
       Dave McCracken <dmccr@us.ibm.com>
Message-id: <4165E49C.6080604@jp.fujitsu.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.6)
 Gecko/20040113
References: <D36CE1FCEFD3524B81CA12C6FE5BCAB007ED31D6@fmsmsx406.amr.corp.intel.com>
 <1097163578.3625.43.camel@localhost> <1260090000.1097164623@[10.10.2.4]>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Martin J. Bligh wrote:
 >>>>What was the purpose behind this, again? Sorry, has been too long since
 >>>>I last looked.

>>On Thu, 2004-10-07 at 08:03, Tolentino, Matthew E wrote:
>>
>>For one, it avoids the otherwise requisite resizing of the bitmaps=20
>>during memory hotplug operations...
>>

 >> Dave McCracken wrote:
>> The memory allocator bitmaps are the main remaining reason we need the
>> concept of linear memory.  If we can get rid of them, it's one step closer
>> to managing memory as a set of sections.

 >>--Dave Hansen <haveblue@us.ibm.com> wrote (on Thursday, October 07, 2004 08:39:38 -0700)
>>It also simplifies the nonlinear implementation.  The whole reason we
>>had the lpfn (Linear) stuff was so that the bitmaps could represent a
>>sparse physical address space in a much more linear fashion.  With no
>>bitmaps, this isn't an issue, and gets rid of a lot of code, and a
>>*huge* source of bugs where lpfns and pfns are confused for each other. 
> 
> 
> Makese sense on both counts. Would be nice to add the justification to 
> the changelog ;-)
> 

It seems all I should answer is already answered.
Thank you all.

I'll add the purpose to the changelog.

Kame <kamezawa.hiroyu@jp.fujitsu.com>

> M.
> 

