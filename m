Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261757AbULUNdL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261757AbULUNdL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Dec 2004 08:33:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261758AbULUNdL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Dec 2004 08:33:11 -0500
Received: from mx2.elte.hu ([157.181.151.9]:23431 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261757AbULUNdF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Dec 2004 08:33:05 -0500
Date: Tue, 21 Dec 2004 14:32:13 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Loic Domaigne <loic-dev@gmx.net>
Cc: Nick Piggin <piggin@cyberone.com.au>, nptl@bullopensource.org,
       Linux-Kernel@Vger.Kernel.ORG
Subject: Re: OSDL Bug 3770
Message-ID: <20041221133213.GA16238@elte.hu>
References: <41C8047E.1030403@cyberone.com.au> <25289.1103630797@www66.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25289.1103630797@www66.gmx.net>
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


* Loic Domaigne <loic-dev@gmx.net> wrote:

> > Yes, it does support hard CPU binding - sched_setaffinity
> 
> Yes, I believe that /sched_setaffinity()/ offers a practical solution
> to the problem we are faced. 

that's the short-term workaround. Another model for CPU-bound RT tasks
is the use of isolcpus. (see Documentation/kernel-parameters.txt)

but that's the thinking behind current RT scheduling: no global sorting
of priorities is done on SMP, but if you know the priorities and the
workload in advance you can manually bind them to specific CPUs.

> But I am eager to try the RT-patchset of Ingo. 

this is obviously more experimental stuff, and feedback is welcome. It
is the current 'playground' for RT related scheduling features.

	Ingo
