Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161078AbWAKBuM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161078AbWAKBuM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 20:50:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161059AbWAKBuL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 20:50:11 -0500
Received: from smtp.osdl.org ([65.172.181.4]:10128 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161078AbWAKBuJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 20:50:09 -0500
Date: Tue, 10 Jan 2006 17:52:00 -0800
From: Andrew Morton <akpm@osdl.org>
To: Martin Bligh <mbligh@google.com>
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu
Subject: Re: -mm seems significanty slower than mainline on kernbench
Message-Id: <20060110175200.456af1a7.akpm@osdl.org>
In-Reply-To: <43C4624D.4040604@google.com>
References: <43C45BDC.1050402@google.com>
	<20060110173159.55cce659.akpm@osdl.org>
	<43C4624D.4040604@google.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Bligh <mbligh@google.com> wrote:
>
> > Well, 1% slower.  -mm has permanent not-for-linus debug things, some of
> > which are expected to have a performance impact.  I don't know whether
> > they'd have a 1% impact though.
> 
> OK, fair enough. Can I turn them off somehow to check? it's 10% on 
> NUMA-Q. The good news is that it's stayed in -mm for long time, so ...
> am praying.

There are quite a lot of them.

list_del-debug.patch
page-owner-tracking-leak-detector.patch
page-owner-tracking-leak-detector-fix.patch
unplug-can-sleep.patch
firestream-warnings.patch
#periodically-scan-redzone-entries-and-slab-control-structures.patch
slab-leak-detector.patch
releasing-resources-with-children.patch
nr_blockdev_pages-in_interrupt-warning.patch
nmi-lockup-and-altsysrq-p-dumping-calltraces-on-_all_-cpus.patch
detect-atomic-counter-underflows.patch
sysfs-crash-debugging.patch
device-suspend-debug.patch
slab-cache-shrinker-statistics.patch
slab-cache-shrinker-statistics-fix.patch
mm-debug-dump-pageframes-on-bad_page.patch
debug-warn-if-we-sleep-in-an-irq-for-a-long-time.patch
debug-shared-irqs.patch
debug-shared-irqs-fix.patch
make-frame_pointer-default=y.patch


list_del-debug.patch, detect-atomic-counter-underflows.patch,
slab-cache-shrinker-statistics.patch will all have a small impact.

But not much.
