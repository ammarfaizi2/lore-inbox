Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261375AbUHSG4P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261375AbUHSG4P (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 02:56:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261405AbUHSG4P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 02:56:15 -0400
Received: from mx2.elte.hu ([157.181.151.9]:18395 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261375AbUHSG4K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 02:56:10 -0400
Date: Thu, 19 Aug 2004 08:57:25 +0200
From: Ingo Molnar <mingo@elte.hu>
To: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
Cc: linux-kernel@vger.kernel.org, robustmutexes@lists.osdl.org,
       Andrew Morton <akpm@osdl.org>, Ulrich Drepper <drepper@redhat.com>
Subject: Re: PATCH futex on fusyn (Was: RE: [RFC/PATCH] FUSYN Realtime & robust mutexes for Linux, v2.3.1)
Message-ID: <20040819065725.GA29785@elte.hu>
References: <F989B1573A3A644BAB3920FBECA4D25A011F9422@orsmsx407>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F989B1573A3A644BAB3920FBECA4D25A011F9422@orsmsx407>
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


* Perez-Gonzalez, Inaky <inaky.perez-gonzalez@intel.com> wrote:

> Performance:

> Environment                       Seconds (10 continuous runs averaged)
> -----------                       -------------------
> plain NPTL and futexes            0.97
> plain NPTL, futexes use fuqueues  1.15
> Under RTNPTL, using fulocks       1.48

hm, nice - only ~18% slowdown for a very locking-intense workload. If
that could be made somewhat lower (without bad compromises) it would
kill most of the performance-based objections.

the RTNPTL overhead (+~30%) is to be expected i guess - but it's
optional so no pain.

	Ingo
