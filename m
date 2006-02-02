Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422878AbWBBCvr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422878AbWBBCvr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 21:51:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423066AbWBBCvr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 21:51:47 -0500
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:20195 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1422878AbWBBCvq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 21:51:46 -0500
Subject: Re: [PATCH] Avoid moving tasks when a schedule can be made.
From: Steven Rostedt <rostedt@goodmis.org>
To: Peter Williams <pwil3058@bigpond.net.au>
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
       Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <43E1636D.1000304@bigpond.net.au>
References: <1138736609.7088.35.camel@localhost.localdomain>
	 <20060201130818.GA26481@elte.hu> <20060201131111.GA27793@elte.hu>
	 <43E1636D.1000304@bigpond.net.au>
Content-Type: text/plain
Date: Wed, 01 Feb 2006 21:51:30 -0500
Message-Id: <1138848690.6632.44.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-02-02 at 12:42 +1100, Peter Williams wrote:
> Ingo Molnar wrote:

> BTW why do you assume that this problem is caused by can_migrate() 
> failing and is not just simply due to large numbers of tasks needing to 
> be moved (which is highly likely to be true when hackbench is running)?

That's my fault.  In another thread (-rt related) I told Ingo that the
problem was with the can_migrate function call.  But later I realized
that was because I miss read some of my logging output, and discovered
that it was indeed passing the can_migrate and getting further.

-- Steve


