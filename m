Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261220AbVFMTFv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261220AbVFMTFv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 15:05:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261205AbVFMTDn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 15:03:43 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:22197 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261222AbVFMTDN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 15:03:13 -0400
Date: Mon, 13 Jun 2005 20:03:10 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Kristian Benoit <kbenoit@opersys.com>, linux-kernel@vger.kernel.org
Subject: Re: network driver disabled interrupts in PREEMPT_RT
Message-ID: <20050613190310.GB4308@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Ingo Molnar <mingo@elte.hu>, Kristian Benoit <kbenoit@opersys.com>,
	linux-kernel@vger.kernel.org
References: <1118688347.5792.12.camel@localhost> <20050613185642.GA12463@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050613185642.GA12463@elte.hu>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 13, 2005 at 08:56:42PM +0200, Ingo Molnar wrote:
> 
> * Kristian Benoit <kbenoit@opersys.com> wrote:
> 
> > Hi,
> > I got lots of these messages when accessing the net running
> > 2.6.12-rc6-RT-V0.7.48-25 :
> > 
> > "network driver disabled interrupts: tg3_start_xmit+0x0/0x629 [tg3]"
> > 
> > it seem to come from net/sched/sch_generic.c.
> 
> does the patch below fix it?

Wouldn't it be much more useful to add spin_trylock_irq?

