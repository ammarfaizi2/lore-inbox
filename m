Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264096AbUEXHcz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264096AbUEXHcz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 03:32:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264117AbUEXHcz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 03:32:55 -0400
Received: from mx1.elte.hu ([157.181.1.137]:22674 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S264113AbUEXHcs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 03:32:48 -0400
Date: Mon, 24 May 2004 11:34:07 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Con Kolivas <kernel@kolivas.org>, Billy Biggs <vektor@dumbterm.net>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: tvtime and the Linux 2.6 scheduler
Message-ID: <20040524093407.GB26715@elte.hu>
References: <20040523154859.GC22399@dumbterm.net> <200405240254.20171.kernel@kolivas.org> <20040524084334.GB24967@elte.hu> <40B19D15.1090105@yahoo.com.au> <20040524091243.GB26183@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040524091243.GB26183@elte.hu>
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


* Ingo Molnar <mingo@elte.hu> wrote:

> you mean the spurious 'queue to end of prio-queue' bug noticed by Joe
> Korty? tvtime should not be affected by this one. This bug only hits
> if there are multiple SCHED_FIFO tasks on the same priority level -
> tvtime is a single-process application.

i checked out the source and it uses multiple threads if recording is
done to disk - but the disk writer thread is at normal priority, only
the capture thread is using SCHED_FIFO.

	Ingo
