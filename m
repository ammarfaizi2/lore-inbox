Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932453AbVL1Cld@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932453AbVL1Cld (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Dec 2005 21:41:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932456AbVL1Cld
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Dec 2005 21:41:33 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:14043 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932453AbVL1Cld (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Dec 2005 21:41:33 -0500
Subject: Re: 2.6.15-rc5: latency regression vs 2.6.14 in
	exit_mmap->free_pgtables
From: Lee Revell <rlrevell@joe-job.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Ingo Molnar <mingo@elte.hu>, Hugh Dickins <hugh@veritas.com>,
       Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <1135726300.22744.25.camel@mindpipe>
References: <1135726300.22744.25.camel@mindpipe>
Content-Type: text/plain
Date: Tue, 27 Dec 2005 21:46:59 -0500
Message-Id: <1135738020.22744.70.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-12-27 at 18:31 -0500, Lee Revell wrote:
> The problem is that we now do a lot more work in free_pgtables under the
> mm->page_table_lock spinlock so preemption can be delayed for a long
> time.  Here is the change responsible:

Hugh,

I have found the commit that introduced the regression:

[PATCH 16/21] mm: unlink vma before pagetables

http://lkml.org/lkml/2005/10/12/227

Lee

