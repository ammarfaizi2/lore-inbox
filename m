Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265756AbTGIGiQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 02:38:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265762AbTGIGiQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 02:38:16 -0400
Received: from [66.212.224.118] ([66.212.224.118]:3076 "EHLO
	hemi.commfireservices.com") by vger.kernel.org with ESMTP
	id S265756AbTGIGiP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 02:38:15 -0400
Date: Wed, 9 Jul 2003 02:41:36 -0400 (EDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
X-X-Sender: zwane@montezuma.mastecende.com
To: "Nakajima, Jun" <jun.nakajima@intel.com>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       "Saxena, Sunil" <sunil.saxena@intel.com>,
       "Mallick, Asit K" <asit.k.mallick@intel.com>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Subject: RE: [PATCH] idle using PNI monitor/mwait
In-Reply-To: <3014AAAC8E0930438FD38EBF6DCEB5640204345B@fmsmsx407.fm.intel.com>
Message-ID: <Pine.LNX.4.53.0307090237110.5414@montezuma.mastecende.com>
References: <3014AAAC8E0930438FD38EBF6DCEB5640204345B@fmsmsx407.fm.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Jul 2003, Nakajima, Jun wrote:

> That's right. If we have a lot of high-contention locks in the kernel,
> we need to fix the code first, to get benefits for the other
> architectures. 
> 
> "mwait" granularity (64-byte, for example) is given by the cpuid
> instruction, and we did not use it because 1) it's unlikely that the
> other fields of the task structure are modified when it's idle, 2) the
> processor needs to check the flag after mwait anyway, to avoid waking up
> with a false signal caused by other break events (i.e. mwait is a hint).

It could still be very handy for polling loops of the form;

while (!ready)
	__asm__ ("pause;");

Jun would there be any thermal advantages over using poll and pause ?

Thanks,
	Zwane
-- 
function.linuxpower.ca
