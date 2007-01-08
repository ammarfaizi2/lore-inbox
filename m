Return-Path: <linux-kernel-owner+w=401wt.eu-S1750818AbXAHXzr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750818AbXAHXzr (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 18:55:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750820AbXAHXzr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 18:55:47 -0500
Received: from smtp.osdl.org ([65.172.181.24]:55814 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750792AbXAHXzq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 18:55:46 -0500
Date: Mon, 8 Jan 2007 15:54:28 -0800
From: Andrew Morton <akpm@osdl.org>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: vatsa@in.ibm.com, David Howells <dhowells@redhat.com>,
       Christoph Hellwig <hch@infradead.org>, Ingo Molnar <mingo@elte.hu>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       Gautham shenoy <ego@in.ibm.com>
Subject: Re: [PATCH] flush_cpu_workqueue: don't flush an empty ->worklist
Message-Id: <20070108155428.d76f3b73.akpm@osdl.org>
In-Reply-To: <20070107210139.GA2332@tv-sign.ru>
References: <20070104113214.GA30377@in.ibm.com>
	<20070104142936.GA179@tv-sign.ru>
	<20070104091850.c1feee76.akpm@osdl.org>
	<20070106151036.GA951@tv-sign.ru>
	<20070106154506.GC24274@in.ibm.com>
	<20070106163035.GA2948@tv-sign.ru>
	<20070106163851.GA13579@in.ibm.com>
	<20070106111117.54bb2307.akpm@osdl.org>
	<20070107110013.GD13579@in.ibm.com>
	<20070107115957.6080aa08.akpm@osdl.org>
	<20070107210139.GA2332@tv-sign.ru>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Just a sad little note that I've utterly lost the plot on the workqueue
changes.

schedule_on_each_cpu-use-preempt_disable.patch
reimplement-flush_workqueue.patch
implement-flush_work.patch
implement-flush_work-sanity.patch
implement-flush_work_keventd.patch
flush_workqueue-use-preempt_disable-to-hold-off-cpu-hotplug.patch
flush_cpu_workqueue-dont-flush-an-empty-worklist.patch
aio-use-flush_work.patch
kblockd-use-flush_work.patch
relayfs-use-flush_keventd_work.patch
tg3-use-flush_keventd_work.patch
e1000-use-flush_keventd_work.patch
libata-use-flush_work.patch
phy-use-flush_work.patch
#bridge-avoid-using-noautorel-workqueues.patch
#
extend-notifier_call_chain-to-count-nr_calls-made.patch
extend-notifier_call_chain-to-count-nr_calls-made-fixes.patch
extend-notifier_call_chain-to-count-nr_calls-made-fixes-2.patch
define-and-use-new-eventscpu_lock_acquire-and-cpu_lock_release.patch
define-and-use-new-eventscpu_lock_acquire-and-cpu_lock_release-fix.patch
eliminate-lock_cpu_hotplug-in-kernel-schedc.patch
eliminate-lock_cpu_hotplug-in-kernel-schedc-fix.patch
handle-cpu_lock_acquire-and-cpu_lock_release-in-workqueue_cpu_callback.patch
fix-flush_workqueue-vs-cpu_dead-race.patch

I don't know which of these are good, bad or indifferent.

Furthermore I don't know which of these need to be tossed overboard if/when
we get around to using the task freezer for CPU hotplug synchronisation. 
Hopefully, a lot of them.  I don't really understand why we're continuing
to struggle with the existing approach before that question is settled.

