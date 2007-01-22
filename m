Return-Path: <linux-kernel-owner+w=401wt.eu-S1751486AbXAVKWR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751486AbXAVKWR (ORCPT <rfc822;w@1wt.eu>);
	Mon, 22 Jan 2007 05:22:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751517AbXAVKWQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Jan 2007 05:22:16 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:40213 "EHLO amd.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751486AbXAVKWO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Jan 2007 05:22:14 -0500
Date: Mon, 22 Jan 2007 11:21:56 +0100
From: Pavel Machek <pavel@ucw.cz>
To: yunfeng zhang <zyf.zeroos@gmail.com>
Cc: linux-kernel@vger.kernel.org, Rik van Riel <riel@redhat.com>,
       Al Boldi <a1426z@gawab.com>
Subject: Re: [PATCH 2.6.20-rc5 1/1] MM: enhance Linux swap subsystem
Message-ID: <20070122102156.GD16309@elf.ucw.cz>
References: <4df04b840701212309l2a283357jbdaa88794e5208a7@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4df04b840701212309l2a283357jbdaa88794e5208a7@mail.gmail.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi1

> My patch is based on my new idea to Linux swap subsystem, you can find more 
> in
> Documentation/vm_pps.txt which isn't only patch illustration but also file
> changelog. In brief, SwapDaemon should scan and reclaim pages on
> UserSpace::vmalist other than current zone::active/inactive. The change will
> conspicuously enhance swap subsystem performance by

No, this is not the way to submit major rewrite of swap subsystem.

You need to (at minimum, making fundamental changes _is_ hard):

1) Fix your mailer not to wordwrap.

2) Get some testing. Identify workloads it improves.

3) Get some _external_ testing. You are retransmitting wordwrapped
patch. That means noone other then you is actually using it.

4) Don't cc me; I'm not mm expert, and I tend to read l-k, anyway.

								Pavel

> +                         Pure Private Page System (pps)
> +                     Copyright by Yunfeng Zhang on GFDL 1.2

I am not sure GFDL is GPL compatible.

> +// Purpose <([{

You have certainly "interesting" heading style. What is this markup?
> +
> +// The prototype of the function is fit with the "func" of "int
> +// smp_call_function (void (*func) (void *info), void *info, int retry, int
> +// wait);" of include/linux/smp.h of 2.6.16.29. Call it with NULL.
> +void timer_flush_tlb_tasks(void* data /* = NULL */);

I thought I told you to read the CodingStyle in some previous mail?

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
