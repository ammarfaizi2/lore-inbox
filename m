Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964828AbWHQLwB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964828AbWHQLwB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 07:52:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964832AbWHQLwB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 07:52:01 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:1059 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S964828AbWHQLwA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 07:52:00 -0400
Message-ID: <44E458ED.3060404@sw.ru>
Date: Thu, 17 Aug 2006 15:54:21 +0400
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060417
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: rohitseth@google.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Ingo Molnar <mingo@elte.hu>,
       Christoph Hellwig <hch@infradead.org>,
       Pavel Emelianov <xemul@openvz.org>, Andrey Savochkin <saw@sw.ru>,
       devel@openvz.org, Rik van Riel <riel@redhat.com>, hugh@veritas.com,
       ckrm-tech@lists.sourceforge.net, Andi Kleen <ak@suse.de>
Subject: Re: [RFC][PATCH 2/7] UBC: core (structures, API)
References: <44E33893.6020700@sw.ru>	<44E33BB6.3050504@sw.ru>	<1155751868.22595.65.camel@galaxy.corp.google.com> <20060816111818.de1e4339.akpm@osdl.org>
In-Reply-To: <20060816111818.de1e4339.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Wed, 16 Aug 2006 11:11:08 -0700
> Rohit Seth <rohitseth@google.com> wrote:
> 
> 
>>>+struct user_beancounter
>>>+{
>>>+	atomic_t		ub_refcount;
>>>+	spinlock_t		ub_lock;
>>>+	uid_t			ub_uid;
>>
>>Why uid?  Will it be possible to club processes belonging to different
>>users to same bean counter.
> 
> 
> hm.  I'd have expected to see a `struct user_struct *' here, not a uid_t.

Sorry, misused name. should be ub_id. not related to user_struct or user.

Thanks,
Kirill
