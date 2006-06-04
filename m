Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1751516AbWFDPjM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751516AbWFDPjM (ORCPT <rfc822;akpm@zip.com.au>);
	Sun, 4 Jun 2006 11:39:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751512AbWFDPjM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jun 2006 11:39:12 -0400
Received: from mx1.redhat.com ([66.187.233.31]:7093 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751516AbWFDPjL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jun 2006 11:39:11 -0400
Date: Sun, 4 Jun 2006 11:38:42 -0400
From: Alan Cox <alan@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Arjan van de Ven <arjan@infradead.org>, Alan Cox <alan@redhat.com>,
        Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [patch, -rc5-mm1] locking validator: special rule: 8390.c disable_irq()
Message-ID: <20060604153842.GA14801@devserv.devel.redhat.com>
References: <1149107500.3114.75.camel@laptopd505.fenrus.org> <20060531214139.GA8196@devserv.devel.redhat.com> <1149111838.3114.87.camel@laptopd505.fenrus.org> <20060531214729.GA4059@elte.hu> <1149112582.3114.91.camel@laptopd505.fenrus.org> <1149345421.13993.81.camel@localhost.localdomain> <20060603215323.GA13077@devserv.devel.redhat.com> <1149374090.14408.4.camel@localhost.localdomain> <1149413649.3109.92.camel@laptopd505.fenrus.org> <1149426961.27696.7.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1149426961.27696.7.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 04, 2006 at 09:16:01AM -0400, Steven Rostedt wrote:
> that had its irq misrouted, couldn't it cause a storm if we don't call
> the handler for it?  So really disable_irq is broken for the misrouting
> case, and perhaps needs to be replaced with a spin_lock_irqsave?

For the ne2k at least that simply is not possible, the latencies are so
bad that you start dropping serial characters and the like if you do.

The disease is not as bad as the cure..

