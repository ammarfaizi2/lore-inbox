Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261483AbVBHIkH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261483AbVBHIkH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 03:40:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261485AbVBHIkH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 03:40:07 -0500
Received: from mx2.elte.hu ([157.181.151.9]:40332 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261483AbVBHIkC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 03:40:02 -0500
Date: Tue, 8 Feb 2005 09:39:35 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Esben Nielsen <simlo@phys.au.dk>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org
Subject: Re: Real-Time Preemption and UML?
Message-ID: <20050208083935.GB24669@elte.hu>
References: <200502071835.j17IZMlS003456@ccure.user-mode-linux.org> <Pine.OSF.4.05.10502072330140.29801-200000@da410.phys.au.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.OSF.4.05.10502072330140.29801-200000@da410.phys.au.dk>
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


* Esben Nielsen <simlo@phys.au.dk> wrote:

> Well, I keep trying a little bit more. In the mean while you can get
> some of the stuff I needed to change to at least get it to compile:
> 
> One of the problems was use of direct architecture specific semaphores
> (which doesn't work under PREEMPT_REALTIME) and in places where a
> quick (maybe too quick) look at the code told me that completions
> ought to be used. Therefore I changed two semaphores to completions
> which compiled fine. I have tried the change on 2.6.11-rc2, and it
> seemed to work, but I have not tested it heavily.

Jeff, any objections against adding this change to UML at some point? 
It's at most a cleanup for now (PREEMPT_RT not being an upstream
feature), but it makes life easier if 'more exotic' semaphore details
are not being relied on (even if that reliance is 100% correct
currently).

	Ingo
