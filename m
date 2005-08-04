Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262508AbVHDMXj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262508AbVHDMXj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 08:23:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262505AbVHDMVS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 08:21:18 -0400
Received: from zproxy.gmail.com ([64.233.162.199]:32876 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262508AbVHDMU6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 08:20:58 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=mDcRZlinrkXk4gZAzHieVnvGHA5WTUF4o5I5kDkVl/5ox5+n/344GJzSINmtiwhiwTB+TNu9eDpDyCfpbexA3IAzXIstO84nVamQcWgPsr31LGtWnZsTi9rWdznfp51F5eH6QFRjkad5UN9UBpbFAyUTs4hcDy4y/4GgIPLLsf8=
Message-ID: <3684cc7005080405203b2e8841@mail.gmail.com>
Date: Thu, 4 Aug 2005 14:20:50 +0200
From: Andrzej Nowak <warzywo@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.13-rc4-V0.7.52-01
Cc: Ingo Molnar <mingo@elte.hu>
In-Reply-To: <20050730160345.GA3584@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050730160345.GA3584@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/30/05, Ingo Molnar <mingo@elte.hu> wrote:
> 
> i have released the -V0.7.52-01 Real-Time Preemption patch, which can be
> downloaded from the usual place:
> ...
> reports, patches, suggestions welcome.

I can't get it to run on x86_64. The kernel won't build with
"voluntary preemption" enabled, it's complaining about mce_read_sem
being undeclared. Including linux/semaphore.h in
arch/x86_64/kernel/mce.c does get the compilation past that point, but
later on mtrr and kprobes won't build. I can turn those off, but the
build stops on kernel/printk.c with a "console_sem undeclared" error.

Everything builds fine with "real-time preemption" enabled, though the
linux system as a whole still won't run, as init crashes on startup
(kernel panic).

I saw earlier postings on lkml related to RT and x86_64, but
unfortunately the suggestions made, such as turning off latency
timing, didn't help. I tried this on a dual Xeon HT server with SLES
9.1 64bit installed (config has SMP/SMT set to yes). I used the
2.6.13-rc4 kernel patched with
realtime-preempt-2.6.13-rc4-RT-V0.7.52-10.

Any suggestions or any extra info I've missed would be appreciated.

Andrzej Nowak
