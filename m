Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261420AbVCYGWS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261420AbVCYGWS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 01:22:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261425AbVCYGWJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 01:22:09 -0500
Received: from mx1.elte.hu ([157.181.1.137]:32955 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261420AbVCYGT3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 01:19:29 -0500
Date: Fri, 25 Mar 2005 07:19:07 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Esben Nielsen <simlo@phys.au.dk>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc1-V0.7.41-07
Message-ID: <20050325061907.GA20242@elte.hu>
References: <20050324113912.GA20911@elte.hu> <Pine.OSF.4.05.10503242307330.25274-100000@da410.phys.au.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.OSF.4.05.10503242307330.25274-100000@da410.phys.au.dk>
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


* Esben Nielsen <simlo@phys.au.dk> wrote:

> I like the idea of having the scheduler take care of it - it is a very 
> optimal coded queue-system after all. That will work on UP but not on 
> SMP. Having the unlock operation to set the mutex in a "partially 
> owned" state will work better. The only problem I see, relative to 
> Ingo's implementation, is that then the awoken task have to go in and 
> change the state of the mutex, i.e. it has to lock the wait_lock 
> again. Will the extra schedulings being the problem happen offen 
> enough in practise to have the extra overhead?

i think this should be covered by the 'unschedule/unwakeup' feature, 
mentioned in the latest mails.

	Ingo
