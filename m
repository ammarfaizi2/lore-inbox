Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262221AbVBKIa0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262221AbVBKIa0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 03:30:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262222AbVBKIa0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 03:30:26 -0500
Received: from mx1.elte.hu ([157.181.1.137]:38275 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262221AbVBKIaW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 03:30:22 -0500
Date: Fri, 11 Feb 2005 09:28:41 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Sven Dietrich <sdietrich@mvista.com>
Cc: george@mvista.com, "'William Weston'" <weston@lysdexia.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.11-rc3-V0.7.38-01
Message-ID: <20050211082841.GA3349@elte.hu>
References: <420BC23F.6030308@mvista.com> <000701c50fcd$f42dc600$bc0a000a@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000701c50fcd$f42dc600$bc0a000a@mvista.com>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Sven Dietrich <sdietrich@mvista.com> wrote:

> This patch adds a config option to allow you to select whether timer
> IRQ runs in thread or not.

this patch only changes xtime_lock back and forth - it does in no way
impact the 'threadedness' of the timer IRQ. (it does not move the timer
IRQ into an interrupt thread.)

nor do we really want to make it configurable - it's non-threaded right
now and we'll see what effect this has on the worst-case latencies. 

	Ingo
