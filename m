Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268483AbUILFxt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268483AbUILFxt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 01:53:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268484AbUILFxt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 01:53:49 -0400
Received: from smtp201.mail.sc5.yahoo.com ([216.136.129.91]:41349 "HELO
	smtp201.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S268483AbUILFxr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 01:53:47 -0400
Message-ID: <4143D855.9070005@yahoo.com.au>
Date: Sun, 12 Sep 2004 15:02:13 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040810 Debian/1.7.2-2
X-Accept-Language: en
MIME-Version: 1.0
To: Zwane Mwaikambo <zwane@linuxpower.ca>
CC: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org, paulus@samba.org,
       linux-kernel@vger.kernel.org, anton@samba.org, jun.nakajima@intel.com,
       ak@suse.de, mingo@elte.hu
Subject: Re: [PATCH] Yielding processor resources during lock contention
References: <Pine.LNX.4.58.0409021231570.4481@montezuma.fsmlabs.com> <16703.60725.153052.169532@cargo.ozlabs.ibm.com> <Pine.LNX.4.53.0409090810550.15087@montezuma.fsmlabs.com> <Pine.LNX.4.58.0409090751230.5912@ppc970.osdl.org> <Pine.LNX.4.58.0409090754270.5912@ppc970.osdl.org> <Pine.LNX.4.53.0409091107450.15087@montezuma.fsmlabs.com> <Pine.LNX.4.53.0409120009510.2297@montezuma.fsmlabs.com> <20040911220003.0e9061ad.akpm@osdl.org> <Pine.LNX.4.53.0409120108310.2297@montezuma.fsmlabs.com> <4143D16F.30500@yahoo.com.au> <Pine.LNX.4.53.0409120131000.2297@montezuma.fsmlabs.com> <4143D491.6070006@yahoo.com.au> <Pine.LNX.4.53.0409120146020.2297@montezuma.fsmlabs.com>
In-Reply-To: <Pine.LNX.4.53.0409120146020.2297@montezuma.fsmlabs.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo wrote:

>>If yes, then shouldn't your lock be a blocking lock anyway?
> 
> 
> We just happen to allow preemption since we know we're at an upper level 
> lock, so we may as well not disable preemption during contention. It 
> wouldn't be as straightforward to switch to a blocking lock.
> 

OK that sounds alight.

If it is a "I'm going to be spinning for ages, so schedule me off *now*"
then I think it is wrong... but if it just allows you to keep the hypervisor
preemption turned on, then fine.
