Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263994AbTKDImy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Nov 2003 03:42:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263996AbTKDImy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Nov 2003 03:42:54 -0500
Received: from natsmtp00.rzone.de ([81.169.145.165]:37536 "EHLO
	natsmtp00.webmailer.de") by vger.kernel.org with ESMTP
	id S263994AbTKDImw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Nov 2003 03:42:52 -0500
Message-ID: <3FA7663D.7060509@softhome.net>
Date: Tue, 04 Nov 2003 09:41:33 +0100
From: "Ihar 'Philips' Filipau" <filia@softhome.net>
Organization: Home Sweet Home
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20030927
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       David Mosberger <davidm@napali.hpl.hp.com>,
       Jes Sorensen <jes@wildopensource.com>
Subject: Re: virt_to_page/pci_map_page vs. pci_map_single
References: <NuZH.1a5.7@gated-at.bofh.it> <NI6s.1MM.3@gated-at.bofh.it> <NMtC.7Vs.21@gated-at.bofh.it> <NNSy.1Cd.1@gated-at.bofh.it> <NV3O.5w7.19@gated-at.bofh.it> <NWCA.7Qv.19@gated-at.bofh.it>
In-Reply-To: <NWCA.7Qv.19@gated-at.bofh.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

   Can any-one draw a conclusion?
   Which function should be used in which case?

   So this will be at least reflected in lkml archives ;-)

David S. Miller wrote:
> On Mon, 3 Nov 2003 14:02:57 -0800
> David Mosberger <davidm@napali.hpl.hp.com> wrote:
> 
> 
>>>>>>>On 03 Nov 2003 09:17:59 -0500, Jes Sorensen <jes@wildopensource.com> said:
>>
>>  Jes> Hmmm, my brain has gotten ia64ified ;-) It's basically the normal
>>  Jes> mappings of the kernel, ie. the kernel text/data/bss segments as well
>>  Jes> as anything you do not get back as a dynamic mapping such as
>>  Jes> ioremap/vmalloc/kmap.
>>
>>I don't think it's safe to use virt_to_page() on static kernel
>>addresses (text, data, and bss).  For example, ia64 linux nowadays
>>uses a virtual mapping for the static kernel memory, so it's not part
>>of the identity-mapped segment.
> 
> 
> That's correct and it'll break on sparc64 for similar reasons.
> 
> It's also not safe to do virt_to_page() on kernel stack addresses
> either.
> 


-- 
Ihar 'Philips' Filipau  / with best regards from Saarbruecken.
--                                                           _ _ _
  "... and for $64000 question, could you get yourself       |_|*|_|
    vaguely familiar with the notion of on-topic posting?"   |_|_|*|
                                 -- Al Viro @ LKML           |*|*|*|

