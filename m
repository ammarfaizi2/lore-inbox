Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319295AbSH2THL>; Thu, 29 Aug 2002 15:07:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319296AbSH2THL>; Thu, 29 Aug 2002 15:07:11 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:55825
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S319295AbSH2THK>; Thu, 29 Aug 2002 15:07:10 -0400
Subject: Re: [PATCH] misc. kernel preemption bits
From: Robert Love <rml@tech9.net>
To: Andrew Morton <akpm@zip.com.au>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
In-Reply-To: <3D6E66D5.A97E5CF3@zip.com.au>
References: <1030635181.978.2559.camel@phantasy> 
	<3D6E66D5.A97E5CF3@zip.com.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 29 Aug 2002 15:11:26 -0400
Message-Id: <1030648286.979.2597.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-08-29 at 14:24, Andrew Morton wrote:

> Robert Love wrote:
> > 
> > ...
> >         - we have a debug check in preempt_schedule that, even
> >           on detecting a schedule with irqs disabled, still goes
> >           ahead and reschedules.  We should return. (me)
> > 
> 
> OK, but that warning will still come out of the mess in mm/slab.c.

Yah I saw your previous post.  There is also a report or two re oops on
poisoned memory with SLAB_DEBUG and preempt enabled - which should be
fixed by the above return but one report says it does not.

Anyhow, your new methods are fine... if they work, they work.

I am starting to get concerned over the number of routines we are having
to define.  It is getting complicated (i.e. the
inc_preempt_non_preempt() stuff).

Maybe keep these local to mm/slab.c ?

	Robert Love

