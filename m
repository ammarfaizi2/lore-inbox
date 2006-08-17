Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965135AbWHQPUc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965135AbWHQPUc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 11:20:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965136AbWHQPUc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 11:20:32 -0400
Received: from mx1.redhat.com ([66.187.233.31]:27790 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S965135AbWHQPUa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 11:20:30 -0400
Message-ID: <44E488EF.4090803@redhat.com>
Date: Thu, 17 Aug 2006 11:19:11 -0400
From: Rik van Riel <riel@redhat.com>
Organization: Red Hat, Inc
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Dave Hansen <haveblue@us.ibm.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, rohitseth@google.com,
       Andi Kleen <ak@suse.de>, ckrm-tech@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Kirill Korotaev <dev@sw.ru>, Christoph Hellwig <hch@infradead.org>,
       Andrey Savochkin <saw@sw.ru>, devel@openvz.org, hugh@veritas.com,
       Ingo Molnar <mingo@elte.hu>, Pavel Emelianov <xemul@openvz.org>
Subject: Re: [ckrm-tech] [RFC][PATCH 5/7] UBC: kernel memory accounting	(core)
References: <44E33893.6020700@sw.ru>  <44E33C8A.6030705@sw.ru>	 <1155754029.9274.21.camel@localhost.localdomain>	 <1155755729.22595.101.camel@galaxy.corp.google.com>	 <1155758369.9274.26.camel@localhost.localdomain>	 <1155774274.15195.3.camel@localhost.localdomain> <1155824788.9274.32.camel@localhost.localdomain>
In-Reply-To: <1155824788.9274.32.camel@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen wrote:

> My main thought is that _everybody_ is going to have to live with the
> entry in the 'struct page'.  Distros ship one kernel for everybody, and
> the cost will be paid by those not even using any kind of resource
> control or containers.

Every userspace or page cache page will be in an object
though.  Could we do the pointer on a per object (mapping,
anon vma, ...) basis?

Kernel pages are not using all of their struct page entries,
so we could overload a field.

It all depends on how much we really care about not growing
struct page :)

-- 
What is important?  What you want to be true, or what is true?
