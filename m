Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261319AbVG1Hm3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261319AbVG1Hm3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 03:42:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261323AbVG1HmV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 03:42:21 -0400
Received: from mx2.elte.hu ([157.181.151.9]:53184 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261319AbVG1Hl4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 03:41:56 -0400
Date: Thu, 28 Jul 2005 09:41:18 +0200
From: Ingo Molnar <mingo@elte.hu>
To: David.Mosberger@acm.org
Cc: Andrew Morton <akpm@osdl.org>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Re: Add prefetch switch stack hook in scheduler function
Message-ID: <20050728074118.GA20581@elte.hu>
References: <200507272207.j6RM7fg18695@unix-os.sc.intel.com> <20050727161316.0593d762.akpm@osdl.org> <ed5aea4305072716233491f7f8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed5aea4305072716233491f7f8@mail.gmail.com>
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


* david mosberger <dmosberger@gmail.com> wrote:

> Also, should this be called prefetch_stack() or perhaps even just 
> prefetch_task()?  Not every architecture defines a switch_stack 
> structure.

yeah. I'd too suggest to call it prefetch_stack(), and not make it a 
macro & hook but something defined on all arches, with for now only ia64 
having any real code in the inline function.

i'm wondering, is the switch_stack at the same/similar place as 
next->thread_info? If yes then we could simply do a 
prefetch(next->thread_info).

	Ingo
