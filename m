Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030243AbWGTN1X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030243AbWGTN1X (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jul 2006 09:27:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964886AbWGTN1X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jul 2006 09:27:23 -0400
Received: from gw.goop.org ([64.81.55.164]:23483 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S964883AbWGTN1X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jul 2006 09:27:23 -0400
Message-ID: <44BF84B4.2080700@goop.org>
Date: Thu, 20 Jul 2006 09:27:16 -0400
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060613)
MIME-Version: 1.0
To: Keir Fraser <Keir.Fraser@cl.cam.ac.uk>
CC: Adrian Bunk <bunk@stusta.de>, Ian Pratt <ian.pratt@xensource.com>,
       xen-devel@lists.xensource.com, linux-kernel@vger.kernel.org,
       virtualization@lists.osdl.org, Chris Wright <chrisw@sous-sol.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC PATCH 09/33] Add start-of-day setup hooks to subarch
References: <20060718091807.467468000@sous-sol.org> <20060718091950.750213000@sous-sol.org> <20060720060736.GA25367@stusta.de> <e4182acc9b5779fedf8f5b003126673c@cl.cam.ac.uk>
In-Reply-To: <e4182acc9b5779fedf8f5b003126673c@cl.cam.ac.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keir Fraser wrote:
>>> +struct shared_info *HYPERVISOR_shared_info = (struct shared_info 
>>> *)empty_zero_page;
>>> +EXPORT_SYMBOL(HYPERVISOR_shared_info);
>>> ...
>>
>> EXPORT_SYMBOL_GPL?
>
> Interrupt-control macros (local_irq_enable/disable and friends) used 
> this symbol, so GPLing it made non-GPL modules fail. We made a bunch 
> of the macros proper functions so this may no longer be the case.

Given that this is just a page exported from the hypervisor, it doesn't 
make much sense to impose a GPL requirement on this symbol (to put it 
another way, this is more part of the Xen ABI than the Linux API, so 
Linux can't make much claim to it).

    J
