Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750711AbWIFIe3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750711AbWIFIe3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 04:34:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750720AbWIFIe3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 04:34:29 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:20497 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1750711AbWIFIe3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 04:34:29 -0400
Message-ID: <44FE8819.9020005@openvz.org>
Date: Wed, 06 Sep 2006 12:34:33 +0400
From: Pavel Emelianov <xemul@openvz.org>
User-Agent: Thunderbird 1.5 (X11/20060317)
MIME-Version: 1.0
To: balbir@in.ibm.com
CC: Kirill Korotaev <dev@sw.ru>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>,
       Pavel Emelianov <xemul@openvz.org>, Andrey Savochkin <saw@sw.ru>,
       devel@openvz.org, Rik van Riel <riel@redhat.com>,
       Andi Kleen <ak@suse.de>, Oleg Nesterov <oleg@tv-sign.ru>,
       Alexey Dobriyan <adobriyan@mail.ru>, Matt Helsley <matthltc@us.ibm.com>,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>,
       Hugh Dickins <hugh@veritas.com>, Srivatsa <vatsa@in.ibm.com>,
       Dave Hansen <haveblue@us.ibm.com>
Subject: Re: [ckrm-tech] [PATCH] BC: resource beancounters (v4) (added user
 memory)
References: <44FD918A.7050501@sw.ru> <44FDAB81.5050608@in.ibm.com>
In-Reply-To: <44FDAB81.5050608@in.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Balbir Singh wrote:
> Kirill Korotaev wrote:
>> Core Resource Beancounters (BC) + kernel/user memory control.
>>
>> BC allows to account and control consumption
>> of kernel resources used by group of processes.
>>
>> Draft UBC description on OpenVZ wiki can be found at
>> http://wiki.openvz.org/UBC_parameters
>>
>> The full BC patch set allows to control:
>> - kernel memory. All the kernel objects allocatable
>> on user demand should be accounted and limited
>> for DoS protection.
>> E.g. page tables, task structs, vmas etc.
>
> One of the key requirements of resource management for us is to be
> able to
> migrate tasks across resource groups. Since bean counters do not
> associate
Then could you tell me please what to do with all the resources allocated
by the task you are moving to another group?
> a list of tasks associated with them, I do not see how this can be done
> with the existing bean counters.
>
Associating a list of tasks with beancounter is not so hard actually.
The question is wether this is usefull (regarding my previous comment).
