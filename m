Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751864AbWHUK7l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751864AbWHUK7l (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 06:59:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751862AbWHUK7k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 06:59:40 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:15131 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1751864AbWHUK7k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 06:59:40 -0400
Message-ID: <44E992B9.8080908@sw.ru>
Date: Mon, 21 Aug 2006 15:02:17 +0400
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060417
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: Matt Helsley <matthltc@us.ibm.com>
CC: "Chandra S. Seetharaman" <sekharan@us.ibm.com>,
       Rik van Riel <riel@redhat.com>,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@suse.de>, Christoph Hellwig <hch@infradead.org>,
       Andrey Savochkin <saw@sw.ru>, devel@openvz.org, hugh@veritas.com,
       Ingo Molnar <mingo@elte.hu>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Pavel Emelianov <xemul@openvz.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [ckrm-tech] [RFC][PATCH 2/7] UBC: core (structures, API)
References: <44E33893.6020700@sw.ru>  <44E33BB6.3050504@sw.ru>	 <1155866328.2510.247.camel@stark>  <44E5A637.1020407@sw.ru> <1155955116.2510.445.camel@stark>
In-Reply-To: <1155955116.2510.445.camel@stark>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>+	for (p = ub; p != NULL; p = p->parent) {
>>>
>>>
>>>Seems rather expensive to walk up the tree for every charge. Especially
>>>if the administrator wants a fine degree of resource control and makes a
>>>tall tree. This would be a problem especially when it comes to resources
>>>that require frequent and fast allocation.
>>
>>in heirarchical accounting you always have to update all the nodes :/
>>with flat UBC this doesn't introduce significant overhead.
> 
> 
> Except that you eventually have to lock ub0. Seems that the cache line
> for that spinlock could bounce quite a bit in such a hot path.
do you mean by ub0 host system ub which we call ub0
or you mean a top ub?

> Chandra, doesn't Resource Groups avoid walking more than 1 level up the
> hierarchy in the "charge" paths?

Kirill

