Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261215AbUKBMex@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261215AbUKBMex (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 07:34:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261220AbUKBMex
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 07:34:53 -0500
Received: from mx1.elte.hu ([157.181.1.137]:13285 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261219AbUKBMeu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 07:34:50 -0500
Date: Tue, 2 Nov 2004 13:35:49 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] consolidate task preempts
Message-ID: <20041102123549.GA15290@elte.hu>
References: <418707E2.1060105@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <418707E2.1060105@kolivas.org>
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

> consolidate task preempts

nack. This change:

-               if (TASK_PREEMPTS_CURR(p, rq))
-                       resched_task(rq->curr);
+               preempt(p, rq);

hides a real decision made. It might be more acceptable if it was called
'maybe_preempt_curr(p, rq)', but i'm not so sure.

	Ingo


