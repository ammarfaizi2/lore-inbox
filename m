Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750722AbWAYRPr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750722AbWAYRPr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 12:15:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750703AbWAYRPr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 12:15:47 -0500
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:24020 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1750722AbWAYRPq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 12:15:46 -0500
Subject: Re: [patch, validator] fix proc_subdir_lock related deadlock
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20060125170331.GA29339@elte.hu>
References: <20060125170331.GA29339@elte.hu>
Content-Type: text/plain
Date: Wed, 25 Jan 2006 12:14:43 -0500
Message-Id: <1138209283.6695.55.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-01-25 at 18:03 +0100, Ingo Molnar wrote:
> proc_subdir_lock can also be used from softirq (tasklet) context, which 
> may lead to deadlocks.
> 
> This bug was found via the lock validator:
> 

Thanks Ingo,

I stressed in sending the patch that there was a big assumption that the
calls would not be done in (soft)irq context.  I just didn't want to add
overhead if it wasn't needed.  But I guess that this is needed until we
can remove all the instances that use it in softirq context. But that's
for a later patch.

Acked-by: Steven Rostedt <rostedt@goodmis.org>

-- Steve


