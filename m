Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264531AbUEUWxk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264531AbUEUWxk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 18:53:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265022AbUEUWwb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 18:52:31 -0400
Received: from zeus.kernel.org ([204.152.189.113]:38309 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S264561AbUEUWqY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 18:46:24 -0400
From: Dimitri Sivanich <sivanich@sgi.com>
Message-Id: <200405211541.i4LFfpar001544@fsgi142.americas.sgi.com>
Subject: Slab cache reap and CPU availability
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Date: Fri, 21 May 2004 10:41:50 -0500 (CDT)
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I have a fairly general question about the slab cache reap code.

In running realtime noise tests on the 2.6 kernels (spinning to detect periods
of CPU unavailability to RT threads) on an IA/64 Altix system, I have found the
cache_reap code to be the source of a number of larger holdoffs (periods of
CPU unavailability).  These can last into the 100's of usec on 1300 MHz CPUs.
Since this code runs periodically every few seconds as a timer softirq on all
CPUs, holdoffs can occur frequently.

Has anyone looked into less interruptive alternatives to running cache_reap
this way (for the 2.6 kernel), or maybe looked into potential optimizations
to the routine itself?


Thanks in advance,

Dimitri Sivanich <sivanich@sgi.com>

