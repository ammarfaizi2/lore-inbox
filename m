Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964851AbWEaUdd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964851AbWEaUdd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 16:33:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964849AbWEaUdd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 16:33:33 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:47858 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S964851AbWEaUdc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 16:33:32 -0400
Subject: Re: [patch, -rc5-mm1] locking validator: special rule: 3c59x.c
	disable_irq()
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjan@infradead.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060531200900.GA32482@elte.hu>
References: <20060531200900.GA32482@elte.hu>
Content-Type: text/plain
Date: Wed, 31 May 2006 16:32:20 -0400
Message-Id: <1149107540.9978.5.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-05-31 at 22:09 +0200, Ingo Molnar wrote:
> Subject: locking validator: special rule: 3c59x.c disable_irq()
> From: Ingo Molnar <mingo@elte.hu>
> 
> 3c59x.c's vortex_timer() function knows that vp->lock can only be used
> by an irq context that it disabled - and can hence take the vp->lock
> without disabling hardirqs. Teach lockdep about this.

Ingo,

Did you update your
http://people.redhat.com/mingo/lockdep-patches/lockdep-combo-2.6.17-rc5-mm1.patch
or did I miss the patch to add the disable_irq_lockdep function?

-- Steve


