Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275115AbRJTH0j>; Sat, 20 Oct 2001 03:26:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275449AbRJTH03>; Sat, 20 Oct 2001 03:26:29 -0400
Received: from zero.tech9.net ([209.61.188.187]:1811 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S275115AbRJTH0S>;
	Sat, 20 Oct 2001 03:26:18 -0400
Subject: [PATCH] updated preempt-kernel
From: Robert Love <rml@tech9.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.16.99+cvs.2001.10.18.15.19 (Preview Release)
Date: 20 Oct 2001 03:27:12 -0400
Message-Id: <1003562833.862.65.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Testers Wanted:

patches to enable a fully preemptible kernel are available at:
	http://tech9.net/rml/linux
for kernels 2.4.10, 2.4.12, 2.4.12-ac3, and 2.4.13-pre5.

What is this:

A preemptible kernel.  It lowers your latency.

What is New:

* sync with new kernel releases

* if HIGHMEM_DEBUG was on the preempt counter would be incremented at
times but never decremented.  this resulted in preemption becoming
permanently disabled.

* if HIGHMEM_DEBUG was not on, HIGHMEM would crash the system horribly
due to a case where preemption was enabled without a corresponding
disable.

* reapply dropped hunk to pgalloc to prevent reentrancy onto per-CPU
data

The next few patches are going to work on identifying any remaining
per-CPU variables that need explicit locking under preemption.

	Robert Love

