Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262655AbVG2Qlk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262655AbVG2Qlk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 12:41:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262653AbVG2Qld
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 12:41:33 -0400
Received: from mx1.elte.hu ([157.181.1.137]:9348 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262655AbVG2QlZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 12:41:25 -0400
Date: Fri, 29 Jul 2005 18:40:11 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: "Chen, Kenneth W" <kenneth.w.chen@intel.com>, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org
Subject: Re: Delete scheduler SD_WAKE_AFFINE and SD_WAKE_BALANCE flags
Message-ID: <20050729164011.GA12138@elte.hu>
References: <200507290627.j6T6Rrg06842@unix-os.sc.intel.com> <42E9ED47.1030003@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42E9ED47.1030003@yahoo.com.au>
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


* Nick Piggin <nickpiggin@yahoo.com.au> wrote:

> Chen, Kenneth W wrote:
> >Nick Piggin wrote on Thursday, July 28, 2005 7:01 PM
> 
> >This clearly outlines an issue with the implementation.  Optimize for one
> >type of workload has detrimental effect on another workload and vice versa.
> >
> 
> Yep. That comes up fairly regularly when tuning the scheduler :(

in this particular case we can clearly separate the two workloads 
though: CPU-overload (Ken's benchmark) vs. half-load (3-task tbench). So 
by checking for migration target/source idleness we can have a hard 
separator for wakeup balancing. (whether it works out for both types of 
workloads remains to be seen)

	Ingo
