Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268453AbUILFUI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268453AbUILFUI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 01:20:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268455AbUILFUI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 01:20:08 -0400
Received: from fw.osdl.org ([65.172.181.6]:47539 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268453AbUILFUF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 01:20:05 -0400
Date: Sat, 11 Sep 2004 22:18:05 -0700
From: Andrew Morton <akpm@osdl.org>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: torvalds@osdl.org, paulus@samba.org, linux-kernel@vger.kernel.org,
       anton@samba.org, jun.nakajima@intel.com, ak@suse.de, mingo@elte.hu
Subject: Re: [PATCH] Yielding processor resources during lock contention
Message-Id: <20040911221805.6269d60e.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.53.0409120108310.2297@montezuma.fsmlabs.com>
References: <Pine.LNX.4.58.0409021231570.4481@montezuma.fsmlabs.com>
	<16703.60725.153052.169532@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.53.0409090810550.15087@montezuma.fsmlabs.com>
	<Pine.LNX.4.58.0409090751230.5912@ppc970.osdl.org>
	<Pine.LNX.4.58.0409090754270.5912@ppc970.osdl.org>
	<Pine.LNX.4.53.0409091107450.15087@montezuma.fsmlabs.com>
	<Pine.LNX.4.53.0409120009510.2297@montezuma.fsmlabs.com>
	<20040911220003.0e9061ad.akpm@osdl.org>
	<Pine.LNX.4.53.0409120108310.2297@montezuma.fsmlabs.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo <zwane@linuxpower.ca> wrote:
>
>  > Confused by all of this.
> 
>  Well currently it just enables preempt and spins like a mad man until the 
>  lock is free. The idea is to allow preempt to get some scheduling done 
>  during the spin..

Oh, Ok, I thought you were proposing that "yield" meant an actual yield().

yes, allowing the arch to hook into that busywait loop makes sense.

