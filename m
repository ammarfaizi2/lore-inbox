Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265164AbTLZKpb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Dec 2003 05:45:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265165AbTLZKpb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Dec 2003 05:45:31 -0500
Received: from dbl.q-ag.de ([80.146.160.66]:58243 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S265164AbTLZKpa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Dec 2003 05:45:30 -0500
Message-ID: <3FEC1142.7050803@colorfullife.com>
Date: Fri, 26 Dec 2003 11:45:22 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Page aging broken in 2.6
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ben wrote:

>I can imagine that an architecture with TLBs will usually evict
>the entry from the TLB sooner or later and the accessed bit will end
>up beeing set again. On PPC, that isn't the case, the entry can well
>stay a loooong time in the hash and if not evicted, _PAGE_ACCESSED
>will never be set again.
>
One risk for i386 are the huge tlbs that AMD uses (512 entries?) - hot 
pages might stay in the TLB forever.

>Or does it snoop accesses
>to the PTE to "catch" somebody clearing the bits ?
>
No. AMD K8 cpu partially snoop PDE/PTE accesses and ignore tlb flush 
instructions if they are certain that the tlb is valid, but I'm not 
aware that anyone snoops the complete tlb cache.

--
    Manfred

