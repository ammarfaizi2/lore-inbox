Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261861AbUKBNE3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261861AbUKBNE3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 08:04:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262841AbUKBM7J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 07:59:09 -0500
Received: from mx2.elte.hu ([157.181.151.9]:21156 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262964AbUKBM5f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 07:57:35 -0500
Date: Tue, 2 Nov 2004 13:58:34 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] add requeue task
Message-ID: <20041102125834.GI15290@elte.hu>
References: <418707E5.90705@kolivas.org> <20041102124252.GE15290@elte.hu> <41878318.8020801@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41878318.8020801@kolivas.org>
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

> >| Change the granularity code to requeue tasks at their best priority
> >| instead of changing priority while they're running. This keeps tasks 
> >| at their top interactive level during their whole timeslice.
> >
> >this is a behavioral change and should go into the 'possible negative
> >effect on interactivity' bucket. (of course it could very likely have a
> >positive effect as well - the bucket is just to separate the risks.)
> 
> Actually I'd like to say I did it for positive effect to counter the
> change that occurred with dropping interactive credit. That was what I
> found in my testing, and I'd like them both to go together into -mm.

just in case my splitout comment wasnt clear: ack for that fix too,
conditional on good -mm exposure. Unlike the interactive_credit change i
think this one would be borderline doable for 2.6.10 if in -mm for a
couple of weeks at least, because the regression fixed by this is fresh
in 2.6.9.

	Ingo
