Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264833AbUGIKRc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264833AbUGIKRc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 06:17:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265009AbUGIKRc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 06:17:32 -0400
Received: from mx1.elte.hu ([157.181.1.137]:18386 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S264833AbUGIKRb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 06:17:31 -0400
Date: Fri, 9 Jul 2004 12:17:33 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Con Kolivas <kernel@kolivas.org>
Cc: Andrew Morton <akpm@osdl.org>, Nick Piggin <piggin@cyberone.com.au>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Likelihood of rt_tasks
Message-ID: <20040709101733.GA19011@elte.hu>
References: <40EE6CC2.8070001@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40EE6CC2.8070001@kolivas.org>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Con Kolivas <kernel@kolivas.org> wrote:

> While rt tasks are normally unlikely, what happens in the case when
> you are scheduling one or many running rt_tasks and the majority of
> your scheduling is rt? Would it be such a good idea in this setting
> that it is always hitting the slow path of branching all the time?

it's really not that big of an issue to hit the 'slow' path. And if it
is that common then the BTB of the CPU ought to cover it just fine.

	Ingo
