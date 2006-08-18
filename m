Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751276AbWHRIw3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751276AbWHRIw3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 04:52:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751290AbWHRIw2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 04:52:28 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:22873 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1751276AbWHRIw0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 04:52:26 -0400
Message-ID: <44E58059.6020605@sw.ru>
Date: Fri, 18 Aug 2006 12:54:49 +0400
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060417
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: rohitseth@google.com
CC: Dave Hansen <haveblue@us.ibm.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Rik van Riel <riel@redhat.com>, Andi Kleen <ak@suse.de>,
       ckrm-tech@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Christoph Hellwig <hch@infradead.org>, Andrey Savochkin <saw@sw.ru>,
       devel@openvz.org, hugh@veritas.com, Ingo Molnar <mingo@elte.hu>,
       Pavel Emelianov <xemul@openvz.org>
Subject: Re: [ckrm-tech] [RFC][PATCH 5/7] UBC: kernel memory accounting	(core)
References: <44E33893.6020700@sw.ru>  <44E33C8A.6030705@sw.ru>	 <1155754029.9274.21.camel@localhost.localdomain>	 <1155755729.22595.101.camel@galaxy.corp.google.com>	 <1155758369.9274.26.camel@localhost.localdomain>	 <1155774274.15195.3.camel@localhost.localdomain>	 <1155824788.9274.32.camel@localhost.localdomain>	 <1155835003.14617.45.camel@galaxy.corp.google.com>	 <1155835401.9274.64.camel@localhost.localdomain> <1155836198.14617.61.camel@galaxy.corp.google.com>
In-Reply-To: <1155836198.14617.61.camel@galaxy.corp.google.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rohit Seth wrote:
> On Thu, 2006-08-17 at 10:23 -0700, Dave Hansen wrote:
> 
>>On Thu, 2006-08-17 at 10:16 -0700, Rohit Seth wrote:
>>
>>>>That said, it sure is simpler to implement, so I'm all for it!
>>>
>>>hmm, not sure why it is simpler.
>>
>>When you ask the question, "which container owns this page?", you don't
>>have to look far, 
> 
> 
> as in page->mapping->container for user land?
in case of anon_vma, page->mapping can be the same
for 2 pages beloning to different containers.

>>nor is it ambiguous in any way.  It is very strict,
>>and very straightforward.
> 
> What additional ambiguity you have when inode or task structures have
> the required information.
inodes can belong to multiple containers and so do the pages.

Kirill
