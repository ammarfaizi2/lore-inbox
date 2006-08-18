Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751111AbWHRI1M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751111AbWHRI1M (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 04:27:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751112AbWHRI1M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 04:27:12 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:57724 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1751111AbWHRI1K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 04:27:10 -0400
Message-ID: <44E57A6D.4040608@sw.ru>
Date: Fri, 18 Aug 2006 12:29:33 +0400
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060417
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: Rik van Riel <riel@redhat.com>
CC: Dave Hansen <haveblue@us.ibm.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       rohitseth@google.com, Andi Kleen <ak@suse.de>,
       ckrm-tech@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Christoph Hellwig <hch@infradead.org>, Andrey Savochkin <saw@sw.ru>,
       devel@openvz.org, hugh@veritas.com, Ingo Molnar <mingo@elte.hu>,
       Pavel Emelianov <xemul@openvz.org>
Subject: Re: [ckrm-tech] [RFC][PATCH 5/7] UBC: kernel memory accounting	(core)
References: <44E33893.6020700@sw.ru>  <44E33C8A.6030705@sw.ru>	 <1155754029.9274.21.camel@localhost.localdomain>	 <1155755729.22595.101.camel@galaxy.corp.google.com>	 <1155758369.9274.26.camel@localhost.localdomain>	 <1155774274.15195.3.camel@localhost.localdomain> <1155824788.9274.32.camel@localhost.localdomain> <44E488EF.4090803@redhat.com>
In-Reply-To: <44E488EF.4090803@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:
> Dave Hansen wrote:
> 
>> My main thought is that _everybody_ is going to have to live with the
>> entry in the 'struct page'.  Distros ship one kernel for everybody, and
>> the cost will be paid by those not even using any kind of resource
>> control or containers.
> 
> 
> Every userspace or page cache page will be in an object
> though.  Could we do the pointer on a per object (mapping,
> anon vma, ...) basis?
in this case no memory fractions accounting is possible :/
please, note, this field added by this patchset is in union
and used by user pages accounting as well.
 
> Kernel pages are not using all of their struct page entries,
> so we could overload a field.
yeah, we can. probably mapping.
but as I said we use the same pointer for user pages accounting as well.

> It all depends on how much we really care about not growing
> struct page :)
so what is your opinion?
Kernel compiled w/o UBC do not introduce additional pointer.

Thanks,
Kirill

