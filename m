Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261856AbVEWH36@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261856AbVEWH36 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 May 2005 03:29:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261858AbVEWH36
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 May 2005 03:29:58 -0400
Received: from mx2.elte.hu ([157.181.151.9]:7042 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261856AbVEWH34 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 May 2005 03:29:56 -0400
Date: Mon, 23 May 2005 09:28:34 +0200
From: Ingo Molnar <mingo@elte.hu>
To: ganzinger@mvista.com
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       Corey Minyard <cminyard@mvista.com>
Subject: Re: [PATCH] BUG_ON() in ksoftirqd is a bit too agressive...
Message-ID: <20050523072834.GB3539@elte.hu>
References: <428BD501.5020905@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <428BD501.5020905@mvista.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* George Anzinger <george@mvista.com> wrote:

> Ksoftirqd is created by init, long after the timer system is up and 
> running.  We have hit the BUG_ON(tasklet_... in this code, i.e. 
> tasklets pending at ksoftirqd create time.  Since, with the RT option 
> to push all softirq code to a thread, any softirqs are defered to this 
> time, it is easy to hit this bug.  Clearly only a problem for cpu 0.  
> Here is a patch:

thanks, i've applied this to my -RT tree (will show up in .47-05 and 
later trees).

	Ingo
