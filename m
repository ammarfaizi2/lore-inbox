Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267571AbUHEG4q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267571AbUHEG4q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 02:56:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267578AbUHEG4q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 02:56:46 -0400
Received: from mx1.elte.hu ([157.181.1.137]:39822 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S267571AbUHEG4p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 02:56:45 -0400
Date: Thu, 5 Aug 2004 08:57:08 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Albert Cahalan <albert@users.sf.net>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       kernel@kolivas.org, Andrew Morton OSDL <akpm@osdl.org>
Subject: Re: SCHED_BATCH and SCHED_BATCH numbering
Message-ID: <20040805065708.GA10124@elte.hu>
References: <1091638227.1232.1750.camel@cube>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1091638227.1232.1750.camel@cube>
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


* Albert Cahalan <albert@users.sf.net> wrote:

> Are these going to be numbered consecutively, or might they better be
> done like the task state? [...]

this is quite unnecessary at the moment since p->prio < MAX_RT_PRIO is a
good enough check - but whenever the way p->prio works is changed it
will be easy to introduce a PF_REALTIME flag that is set/cleared in
setscheduler(). (instead of playing around with p->policy.)

	Ingo
