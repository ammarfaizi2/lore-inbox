Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263624AbUEXHLa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263624AbUEXHLa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 03:11:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263664AbUEXHLa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 03:11:30 -0400
Received: from mx1.elte.hu ([157.181.1.137]:11144 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S263624AbUEXHL0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 03:11:26 -0400
Date: Mon, 24 May 2004 11:12:43 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Con Kolivas <kernel@kolivas.org>, Billy Biggs <vektor@dumbterm.net>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: tvtime and the Linux 2.6 scheduler
Message-ID: <20040524091243.GB26183@elte.hu>
References: <20040523154859.GC22399@dumbterm.net> <200405240254.20171.kernel@kolivas.org> <20040524084334.GB24967@elte.hu> <40B19D15.1090105@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40B19D15.1090105@yahoo.com.au>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.26.8-itk2 (ELTE 1.1) SpamAssassin 2.63 ClamAV 0.65
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Nick Piggin <nickpiggin@yahoo.com.au> wrote:

> Just one other thing - realtime scheduling was basically broken up
> until around 2.6.5. Before starting any tests, please ensure first
> that you are using at least the 2.6.5 kernel. Thanks.

you mean the spurious 'queue to end of prio-queue' bug noticed by Joe
Korty? tvtime should not be affected by this one. This bug only hits if
there are multiple SCHED_FIFO tasks on the same priority level - tvtime
is a single-process application.

	Ingo
