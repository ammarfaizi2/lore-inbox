Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262645AbVCKJb4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262645AbVCKJb4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 04:31:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262647AbVCKJb4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 04:31:56 -0500
Received: from mx2.elte.hu ([157.181.151.9]:24018 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262645AbVCKJbu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 04:31:50 -0500
Date: Fri, 11 Mar 2005 10:31:32 +0100
From: Ingo Molnar <mingo@elte.hu>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: linux-kernel@vger.kernel.org, "'Andrew Morton'" <akpm@osdl.org>
Subject: Re: re-inline sched functions
Message-ID: <20050311093132.GA19954@elte.hu>
References: <200503110024.j2B0OFg06087@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200503110024.j2B0OFg06087@unix-os.sc.intel.com>
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


* Chen, Kenneth W <kenneth.w.chen@intel.com> wrote:

> # size vmlinux.*
>    text    data     bss     dec     hex filename
> 3261844  717184  262020 4241048  40b698 vmlinux.x86.orig
> 3262772  717488  262020 4242280  40bb68 vmlinux.x86.inline

> Possible we can introduce them back?

> -static unsigned int task_timeslice(task_t *p)
> +static inline unsigned int task_timeslice(task_t *p)

the patch looks good except this one - could you try to undo it and
re-measure? task_timeslice() is not used in any true fastpath, if it
makes any difference then the performance difference must be some other
artifact.

	Ingo
