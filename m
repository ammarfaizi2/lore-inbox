Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932433AbWHRMdz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932433AbWHRMdz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 08:33:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932457AbWHRMdz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 08:33:55 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:42304 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S932433AbWHRMdz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 08:33:55 -0400
Message-ID: <44E5B441.5090404@sw.ru>
Date: Fri, 18 Aug 2006 16:36:17 +0400
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060417
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: Dave Hansen <haveblue@us.ibm.com>
CC: Rik van Riel <riel@redhat.com>, ckrm-tech@lists.sourceforge.net,
       Greg KH <greg@kroah.com>, Andi Kleen <ak@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Christoph Hellwig <hch@infradead.org>, Andrey Savochkin <saw@sw.ru>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, hugh@veritas.com,
       Ingo Molnar <mingo@elte.hu>, devel@openvz.org,
       Pavel Emelianov <xemul@openvz.org>
Subject: Re: [ckrm-tech] [RFC][PATCH 2/7] UBC: core (structures, API)
References: <44E33893.6020700@sw.ru> <44E33BB6.3050504@sw.ru>	<20060816171527.GB27898@kroah.com>  <44E456F4.10001@sw.ru> <1155825160.9274.35.camel@localhost.localdomain>
In-Reply-To: <1155825160.9274.35.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen wrote:
> On Thu, 2006-08-17 at 15:45 +0400, Kirill Korotaev wrote:
> 
>>We need more complex decrement/locking scheme than krefs
>>provide. e.g. in __put_beancounter() we need
>>atomic_dec_and_lock_irqsave() semantics for performance optimizations.
> 
> 
> Is it possible to put the locking in the destructor?  It seems like that
> should give similar behavior.
objects live in hashes also so you need to distinguish objects being freed
on lookup somehow.

Kirill

