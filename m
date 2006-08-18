Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964880AbWHRLuF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964880AbWHRLuF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 07:50:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964881AbWHRLuF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 07:50:05 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:57115 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S964880AbWHRLuE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 07:50:04 -0400
Message-ID: <44E5A9FC.70507@sw.ru>
Date: Fri, 18 Aug 2006 15:52:28 +0400
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060417
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: Matt Helsley <matthltc@us.ibm.com>
CC: Andrey Savochkin <saw@sw.ru>, Rik van Riel <riel@redhat.com>,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Christoph Hellwig <hch@infradead.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, rohitseth@google.com,
       hugh@veritas.com, Ingo Molnar <mingo@elte.hu>,
       Pavel Emelianov <xemul@openvz.org>, devel@openvz.org,
       Andi Kleen <ak@suse.de>
Subject: Re: [ckrm-tech] [PATCH 2/7] UBC: core (structures, API)
References: <44E33893.6020700@sw.ru> <44E33BB6.3050504@sw.ru>	<1155751868.22595.65.camel@galaxy.corp.google.com>	<44E458C4.9030902@sw.ru> <20060817223137.ca4951ff.akpm@osdl.org>	<20060818113525.A11407@castle.nmd.msu.ru> <1155889563.2510.303.camel@stark>
In-Reply-To: <1155889563.2510.303.camel@stark>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Helsley wrote:
> On Fri, 2006-08-18 at 11:35 +0400, Andrey Savochkin wrote:
> 
>>On Thu, Aug 17, 2006 at 10:31:37PM -0700, Andrew Morton wrote:
>>
>>>On Thu, 17 Aug 2006 15:53:40 +0400
>>>Kirill Korotaev <dev@sw.ru> wrote:
>>>
>>>
>>>>>>+struct user_beancounter
>>>>>>+{
>>>>>>+	atomic_t		ub_refcount;
>>>>>>+	spinlock_t		ub_lock;
>>>>>>+	uid_t			ub_uid;
>>>>>
>>>>>
>>>>>Why uid?  Will it be possible to club processes belonging to different
>>>>>users to same bean counter.
>>>>
>>>>oh, its a misname. Should be ub_id. it is ID of user_beancounter
>>>>and has nothing to do with user id.
>>>
>>>But it uses a uid_t.  That's more than a misnaming?
>>
>>It used to be uid-related in ancient times when the notion of container
>>hadn't formed up.
>>"user" part of user_beancounter name has the same origin :)
> 
> 
> Is it similarly irrelevant now? If so perhaps a big rename could be used
> to make the names clearer (s/user_//, s/ub_/bc_/, ...).
hm... let's try :)

Kirill
