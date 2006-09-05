Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030200AbWIEQxu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030200AbWIEQxu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 12:53:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030204AbWIEQxu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 12:53:50 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:61414 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030200AbWIEQxs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 12:53:48 -0400
Message-ID: <44FDAB81.5050608@in.ibm.com>
Date: Tue, 05 Sep 2006 22:23:21 +0530
From: Balbir Singh <balbir@in.ibm.com>
Reply-To: balbir@in.ibm.com
Organization: IBM India Private Limited
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.6) Gecko/20060730 SeaMonkey/1.0.4
MIME-Version: 1.0
To: Kirill Korotaev <dev@sw.ru>
Cc: Andrew Morton <akpm@osdl.org>,
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
References: <44FD918A.7050501@sw.ru>
In-Reply-To: <44FD918A.7050501@sw.ru>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kirill Korotaev wrote:
> Core Resource Beancounters (BC) + kernel/user memory control.
> 
> BC allows to account and control consumption
> of kernel resources used by group of processes.
> 
> Draft UBC description on OpenVZ wiki can be found at
> http://wiki.openvz.org/UBC_parameters
> 
> The full BC patch set allows to control:
> - kernel memory. All the kernel objects allocatable
> on user demand should be accounted and limited
> for DoS protection.
> E.g. page tables, task structs, vmas etc.

One of the key requirements of resource management for us is to be able to
migrate tasks across resource groups. Since bean counters do not associate
a list of tasks associated with them, I do not see how this can be done
with the existing bean counters.

-- 

	Balbir Singh,
	Linux Technology Center,
	IBM Software Labs
