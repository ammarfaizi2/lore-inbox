Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266814AbUGLOTJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266814AbUGLOTJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 10:19:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266818AbUGLOTJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 10:19:09 -0400
Received: from mx1.elte.hu ([157.181.1.137]:52145 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S266814AbUGLOTG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 10:19:06 -0400
Date: Mon, 12 Jul 2004 16:19:12 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: Con Kolivas <kernel@kolivas.org>,
       ck kernel mailing list <ck@vds.kolivas.org>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjanv@redhat.com>
Subject: Re: [ck] Re: [announce] [patch] Voluntary Kernel Preemption Patch
Message-ID: <20040712141912.GA14710@elte.hu>
References: <20040711143853.GA6555@elte.hu> <40F29CF9.4000400@nortelnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40F29CF9.4000400@nortelnetworks.com>
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


* Chris Friesen <cfriesen@nortelnetworks.com> wrote:

> >it was reporting more accurate latencies, except that there were strange
> >spikes of latencies. It turned out that for whatever reason, userspace
> >RDTSC is not always reliable on my box (!).
> 
> Would the fact that rdtsc is not serializing have any effect here?  Or
> would that be a small enough error to not have any effect?

even though it's not serializing (to other instructions), one would
expect the '64-bit cycle counter' to be fetched atomically. And several
milliseconds cannot be explained with any micr-op delays anyway.

	Ingo
