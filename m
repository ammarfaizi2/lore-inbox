Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751728AbWD1WTY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751728AbWD1WTY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 18:19:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751773AbWD1WTY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 18:19:24 -0400
Received: from smtp.osdl.org ([65.172.181.4]:55692 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751728AbWD1WTX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 18:19:23 -0400
Date: Fri, 28 Apr 2006 15:16:38 -0700
From: Andrew Morton <akpm@osdl.org>
To: Dave Peterson <dsp@llnl.gov>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, riel@surriel.com,
       nickpiggin@yahoo.com.au, ak@suse.de, pj@sgi.com
Subject: Re: [PATCH 1/2 (repost)] mm: serialize OOM kill operations
Message-Id: <20060428151638.32ca188e.akpm@osdl.org>
In-Reply-To: <200604281459.27895.dsp@llnl.gov>
References: <200604271308.10080.dsp@llnl.gov>
	<20060427155613.15d565b1.akpm@osdl.org>
	<200604281459.27895.dsp@llnl.gov>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Peterson <dsp@llnl.gov> wrote:
>
> Yes I am familiar with this sort of problem.  :-)

Andrea has long advocated that the memory allocator shouldn't infinitely
loop for small __GFP_WAIT allocations.  ie: ultimately we should return
NULL back to the caller.

Usually this will cause the correct process to exit.  Sometimes it won't.

Did you try it?
