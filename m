Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268458AbUILFhs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268458AbUILFhs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 01:37:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268479AbUILFhs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 01:37:48 -0400
Received: from smtp204.mail.sc5.yahoo.com ([216.136.130.127]:57678 "HELO
	smtp204.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S268458AbUILFhp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 01:37:45 -0400
Message-ID: <4143D491.6070006@yahoo.com.au>
Date: Sun, 12 Sep 2004 14:46:09 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040810 Debian/1.7.2-2
X-Accept-Language: en
MIME-Version: 1.0
To: Zwane Mwaikambo <zwane@linuxpower.ca>
CC: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org, paulus@samba.org,
       linux-kernel@vger.kernel.org, anton@samba.org, jun.nakajima@intel.com,
       ak@suse.de, mingo@elte.hu
Subject: Re: [PATCH] Yielding processor resources during lock contention
References: <Pine.LNX.4.58.0409021231570.4481@montezuma.fsmlabs.com> <16703.60725.153052.169532@cargo.ozlabs.ibm.com> <Pine.LNX.4.53.0409090810550.15087@montezuma.fsmlabs.com> <Pine.LNX.4.58.0409090751230.5912@ppc970.osdl.org> <Pine.LNX.4.58.0409090754270.5912@ppc970.osdl.org> <Pine.LNX.4.53.0409091107450.15087@montezuma.fsmlabs.com> <Pine.LNX.4.53.0409120009510.2297@montezuma.fsmlabs.com> <20040911220003.0e9061ad.akpm@osdl.org> <Pine.LNX.4.53.0409120108310.2297@montezuma.fsmlabs.com> <4143D16F.30500@yahoo.com.au> <Pine.LNX.4.53.0409120131000.2297@montezuma.fsmlabs.com>
In-Reply-To: <Pine.LNX.4.53.0409120131000.2297@montezuma.fsmlabs.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo wrote:
> On Sun, 12 Sep 2004, Nick Piggin wrote:

>>I presume the hypervisor switch much incur the same sorts of costs as
>>a context switch?
> 
> 
> In the PPC64 and P4/HT case the spinning on a lock is a bad utilisation of 
> the execution resources and that's what we're really trying to avoid, not 
> necessarily cache thrashing from a context switch.
> 

But isn't yielding to the hypervisor and thus causing it to schedule
something else basically the same as a context switch? (I don't know
anything about POWER).

If yes, then shouldn't your lock be a blocking lock anyway?
