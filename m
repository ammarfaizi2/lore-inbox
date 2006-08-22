Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932212AbWHVMoL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932212AbWHVMoL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 08:44:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932218AbWHVMoK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 08:44:10 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:60949 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S932212AbWHVMoJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 08:44:09 -0400
Message-ID: <44EAFCBA.10400@sw.ru>
Date: Tue, 22 Aug 2006 16:46:50 +0400
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060417
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: vatsa@in.ibm.com
CC: Matt Helsley <matthltc@us.ibm.com>, Rik van Riel <riel@redhat.com>,
       "Chandra S. Seetharaman" <sekharan@us.ibm.com>,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@suse.de>, Christoph Hellwig <hch@infradead.org>,
       Andrey Savochkin <saw@sw.ru>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       hugh@veritas.com, Ingo Molnar <mingo@elte.hu>, devel@openvz.org,
       Pavel Emelianov <xemul@openvz.org>
Subject: Re: [ckrm-tech] [RFC][PATCH 2/7] UBC: core (structures, API)
References: <44E33893.6020700@sw.ru> <44E33BB6.3050504@sw.ru> <1155866328.2510.247.camel@stark> <44E5A637.1020407@sw.ru> <1155955116.2510.445.camel@stark> <44E992B9.8080908@sw.ru> <20060822122329.GA7125@in.ibm.com>
In-Reply-To: <20060822122329.GA7125@in.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Srivatsa Vaddagiri wrote:
> On Mon, Aug 21, 2006 at 03:02:17PM +0400, Kirill Korotaev wrote:
> 
>>>Except that you eventually have to lock ub0. Seems that the cache line
>>>for that spinlock could bounce quite a bit in such a hot path.
>>
>>do you mean by ub0 host system ub which we call ub0
>>or you mean a top ub?
> 
> 
> If this were used for pure resource management purpose (w/o containers)
> then the top ub would be ub0 right? "How bad would the contention on the
> ub0->lock be then" is I guess Matt's question.
Probably we still misunderstand here each other.
top ub can be any UB. it's children do account resources
to the whole chain of UBs to the top parent.

i.e. ub0 is not a tree root.

Kirill

