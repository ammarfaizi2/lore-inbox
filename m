Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932547AbVLJCeE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932547AbVLJCeE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 21:34:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932710AbVLJCeE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 21:34:04 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:39369 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S932547AbVLJCeD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 21:34:03 -0500
Subject: Re: [RT] fix delay in do_vgettimeofday() in
	arch/x86_64/kernel/vsyscall.c
From: john stultz <johnstul@us.ibm.com>
To: Serge Belyshev <belyshev@depni.sinp.msu.ru>
Cc: Ingo Molnar <mingo@elte.hu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <87d5k6ukky.fsf@foo.vault.bofh.ru>
References: <87d5k6ukky.fsf@foo.vault.bofh.ru>
Content-Type: text/plain
Date: Fri, 09 Dec 2005 18:33:40 -0800
Message-Id: <1134182041.4002.10.camel@leatherman>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-12-09 at 22:38 +0300, Serge Belyshev wrote:
> 
> There are occasional very very long (30..60 sec) delays happening when calling
> gettimeofday() vsyscall on x86_64 with 2.6.14-rt22 kernel.
> 
> These delays come from while() looping over invalid data that are
> going to be discarded by seqlock.

Ah, good catch! I just included a similar change (moved all the math
outside the lock) in my own tree.

Thanks for finding this!
-john

