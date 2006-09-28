Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751748AbWI1Hcm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751748AbWI1Hcm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 03:32:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751746AbWI1Hcm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 03:32:42 -0400
Received: from mail.suse.de ([195.135.220.2]:61631 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751740AbWI1Hcl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 03:32:41 -0400
To: eranian@hpl.hp.com
Cc: perfmon@napali.hpl.hp.com, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: 2.6.18 perfmon new code base + libpfm + pfmon
References: <20060926143420.GF14550@frankl.hpl.hp.com>
	<20060926220951.39bd344f.akpm@osdl.org>
	<20060927224832.GA17883@frankl.hpl.hp.com>
From: Andi Kleen <ak@suse.de>
Date: 28 Sep 2006 09:32:39 +0200
In-Reply-To: <20060927224832.GA17883@frankl.hpl.hp.com>
Message-ID: <p7364f8jvjc.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephane Eranian <eranian@hpl.hp.com> writes:
> 
> [ak] : separate patch for _TIF_WORK_CTXSW
> 	- I think I submitted a TIF patch for x86-64, but unlike i386 it is not yet in mainline

If it's not in mainline yet I lost it somehow and you should resubmit.

> [ak] : may have to add __kprobes to some functions
> 	- started doing this on some functions. Need better understanding on when to use this

Basically when you could recurse in kprobes. 

> [ak] : cleaner integration with NMI watchdog
> 	- integration done on AMD K8. Issues on P4, P6, due to PMU design

What are the issues?

> [akpm]: documentation for syscall? Is there an API specification?
> 	- answered. In short, there exists a specification but it needs to be updated

Probably you should have man pages ready for submission to the manpage maintainer.
That might also the second review pass on l-k easier if you supply
them in the description.

-Andi
