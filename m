Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268712AbUHaXMl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268712AbUHaXMl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 19:12:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269284AbUHaXGd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 19:06:33 -0400
Received: from zero.aec.at ([193.170.194.10]:38916 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S269292AbUHaXGK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 19:06:10 -0400
To: Ingo Molnar <mingo@elte.hu>
cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk4-Q5
References: <2yiVZ-IZ-15@gated-at.bofh.it> <2ylhi-2hg-3@gated-at.bofh.it>
	<2ynLU-42D-7@gated-at.bofh.it> <2yqJJ-5ZL-1@gated-at.bofh.it>
	<2yQkS-6Zh-13@gated-at.bofh.it> <2zaCV-4FE-3@gated-at.bofh.it>
	<2zaWk-4Yj-9@gated-at.bofh.it> <2zmE8-4Zz-11@gated-at.bofh.it>
	<2zngP-5wD-9@gated-at.bofh.it> <2zngP-5wD-7@gated-at.bofh.it>
	<2znJS-5Pm-25@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Wed, 01 Sep 2004 01:06:02 +0200
In-Reply-To: <2znJS-5Pm-25@gated-at.bofh.it> (Ingo Molnar's message of "Wed,
 01 Sep 2004 00:10:15 +0200")
Message-ID: <m3llfuj4bp.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> writes:

> The question is, does any of the Intel (or AMD) docs
> say that the CPU cache has to be write-back flushed when setting MTRRs,
> or were those calls only done out of paranoia?

Both the Intel and AMD docs require the cache flush for MTRR
caching attribute changes. 

At least in pageattr (which is related) i know of cases where
not doing them caused data corruption in real loads.

-Andi


