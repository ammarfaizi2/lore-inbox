Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932341AbWBNHgo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932341AbWBNHgo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 02:36:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932391AbWBNHgn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 02:36:43 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:12769 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932341AbWBNHgm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 02:36:42 -0500
Date: Tue, 14 Feb 2006 08:34:53 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: "Chen, Kenneth W" <kenneth.w.chen@intel.com>, nickpiggin@yahoo.com.au,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 0/2] fix perf. bug in wake-up load balancing for aim7 and db workload
Message-ID: <20060214073453.GA27466@elte.hu>
References: <200602140309.k1E394g17590@unix-os.sc.intel.com> <20060213193856.696bf1f0.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060213193856.696bf1f0.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrew Morton <akpm@osdl.org> wrote:

> > We should back out the above commit and add a sysctl variable to control the
> > behavior of load balancing in wake up path, so user can dynamically select
> > a mode that best fit for the workload environment.  And kernel can achieve
> > best performance in two extreme ends of incompatible workload environments.
> 
> Well I don't see any benchmark numbers in the original patch.  Just an 
> assertion that it "should" help something.
> 
> I'm more inclined to revert it and not add the sysctl (ugh) until we 
> have a good reason to do so.

yeah, we should do the revert:

 Acked-by: Ingo Molnar <mingo@elte.hu>

but i'm quite against a sysctl knob. Especially not for 2.6.16.

	Ingo
