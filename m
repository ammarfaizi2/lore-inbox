Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267325AbUHEMt0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267325AbUHEMt0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 08:49:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266692AbUHEMry
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 08:47:54 -0400
Received: from mx1.elte.hu ([157.181.1.137]:11954 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S266749AbUHEMrJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 08:47:09 -0400
Date: Thu, 5 Aug 2004 12:47:17 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Con Kolivas <kernel@kolivas.org>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.8-rc2-mm2
Message-ID: <20040805104717.GA20517@elte.hu>
References: <20040802015527.49088944.akpm@osdl.org> <410E3CAF.6080305@kolivas.org> <410F3423.3020409@yahoo.com.au> <cone.1091518501.973503.9648.502@pc.kolivas.org> <cone.1091519122.804104.9648.502@pc.kolivas.org> <41109FCC.4070906@yahoo.com.au> <20040804103143.GA13072@elte.hu> <cone.1091616443.996442.9775.502@pc.kolivas.org> <20040804124538.GA15505@elte.hu> <cone.1091674380.801763.9775.502@pc.kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cone.1091674380.801763.9775.502@pc.kolivas.org>
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


* Con Kolivas <kernel@kolivas.org> wrote:

> >sure: take a process that uses 85% of CPU time (and sleeps 15% of the
> >time) if running on an idle system. Start just two of these hogs at
> >normal priority. 2.6.8-rc2-mm2 becomes almost instantly unusable even
> >over a text console: a single 'top' refresh takes ages, 'ls' displays
> >one line per second or so. Start more of these and the system
> >effectively locks up.
> 
> It's only if I physically try and create such a test application that
> I can reproduce it. I haven't found any real world load that does that
> - but of course that doesn't mean I should discount it. However,
> interactive mode off doesn't exhibit it and it should be easy enough
> to fix for interactive mode on. Thanks for pointing it out.

cool. Will be curious how it will look like once staircase-sched gets
its time-shared slot in -mm next time around :-) But in general i'm
quite positive about the staircase scheduler.

	Ingo
