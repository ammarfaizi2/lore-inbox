Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261286AbVCOOpF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261286AbVCOOpF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 09:45:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261288AbVCOOpF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 09:45:05 -0500
Received: from mx2.elte.hu ([157.181.151.9]:59877 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261286AbVCOOom (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 09:44:42 -0500
Date: Tue, 15 Mar 2005 15:44:28 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrea Arcangeli <andrea@cpushare.com>
Cc: Andrew Morton <akpm@osdl.org>, Adrian Bunk <bunk@stusta.de>,
       linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
Subject: Re: [-mm patch] seccomp: don't say it was more or less mandatory
Message-ID: <20050315144428.GA13318@elte.hu>
References: <20050224224134.GE20715@opteron.random> <20050225211453.GC3311@stusta.de> <20050226013137.GO20715@opteron.random> <20050301003247.GY4021@stusta.de> <20050301004449.GV8880@opteron.random> <20050303145147.GX4608@stusta.de> <20050303135556.5fae2317.akpm@osdl.org> <20050315100903.GA32198@elte.hu> <20050315112712.GA3497@elte.hu> <20050315130046.GK7699@opteron.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050315130046.GK7699@opteron.random>
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


* Andrea Arcangeli <andrea@cpushare.com> wrote:

> > technical comment: seccomp goes outside the audit/selinux framework,
> > which i believe is a bug. Andrea?
> 
> I intentionally left it out of audit/selinux. To the less dependencies
> it has on other parts of the kernel and the simpler it is, the better
> IMHO. Seccomp should be fixed in stone, people shouldn't go hack on it
> every day.

let me put it another way: this is a security hole. seccomp is now a way
to evade the auditing of read/write syscalls done to an opened file. 
Please fix this.

	Ingo
