Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751213AbWJHPHf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751213AbWJHPHf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 11:07:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751214AbWJHPHf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 11:07:35 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:40107 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751213AbWJHPHe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 11:07:34 -0400
Subject: Re: + clocksource-initialize-list-value.patch added to -mm tree
From: Arjan van de Ven <arjan@infradead.org>
To: Daniel Walker <dwalker@mvista.com>
Cc: tglx@linutronix.de, akpm@osdl.org, johnstul@us.ibm.com, mingo@elte.hu,
       zippel@linux-m68k.org, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1160318579.3693.8.camel@c-67-180-230-165.hsd1.ca.comcast.net>
References: <200610070153.k971rsDf020869@shell0.pdx.osdl.net>
	 <1160301039.22911.22.camel@localhost.localdomain>
	 <1160318579.3693.8.camel@c-67-180-230-165.hsd1.ca.comcast.net>
Content-Type: text/plain
Organization: Intel International BV
Date: Sun, 08 Oct 2006 17:07:23 +0200
Message-Id: <1160320043.3000.178.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-10-08 at 07:42 -0700, Daniel Walker wrote:
> On Sun, 2006-10-08 at 11:50 +0200, Thomas Gleixner wrote:
> > On Fri, 2006-10-06 at 18:53 -0700, akpm@osdl.org wrote:
> > > A change to clocksource initialization.  It's optional for new clocksources,
> > > but prefered.  If the list field is initialized it allows clocksource_register
> > > to complete faster since it doesn't have the scan the list of clocks doing
> > > strcmp on each.
> > 
> > Either make it required or not.
> 
> This is for compatability with all those clocksources people are writing
> that just haven't been released (assuming they will be eventually
> released). I would love to make this required.

so do it. The ones that are in development are easily fixed and
consistency is worth a LOT in terms of API. Bonus points if the kernel
printk's a helpful message on abuse.



