Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750994AbVJSOTz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750994AbVJSOTz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 10:19:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750998AbVJSOTz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 10:19:55 -0400
Received: from atlrel9.hp.com ([156.153.255.214]:6546 "EHLO atlrel9.hp.com")
	by vger.kernel.org with ESMTP id S1750970AbVJSOTz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 10:19:55 -0400
Subject: Re: [discuss] Re: x86_64: 2.6.14-rc4 swiotlb broken
From: Alex Williamson <alex.williamson@hp.com>
To: Yasunori Goto <y-goto@jp.fujitsu.com>
Cc: Ravikiran G Thirumalai <kiran@scalex86.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
       discuss@x86-64.org, tglx@linutronix.de, shai@scalex86.org
In-Reply-To: <20051019212041.6378.Y-GOTO@jp.fujitsu.com>
References: <20051018232203.GB4535@localhost.localdomain>
	 <1129684966.17545.50.camel@lts1.fc.hp.com>
	 <20051019212041.6378.Y-GOTO@jp.fujitsu.com>
Content-Type: text/plain
Organization: LOSL
Date: Wed, 19 Oct 2005 08:19:41 -0600
Message-Id: <1129731581.17545.60.camel@lts1.fc.hp.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-10-19 at 21:47 +0900, Yasunori Goto wrote:
> Hmm.....
> How is this patch? This is another way.
> 
> I think that true issue is there is no way for requester to
> specify maxmum address at __alloc_bootmem_core().
> 
> "goal" is just to keep space lower address as much as possible.
> and __alloc_bootmem_core() doesn't care about max address for requester.
> I suppose it is a bit strange. The swiotlb's case is good example
> by it.
> 
> So, I made a patch that __alloc_bootmem_core() cares it.

   This works on the Superdome.  The swiotlb is shown as:

Placing software IO TLB between 0x4d48000 - 0x8d48000

Thanks,

	Alex

