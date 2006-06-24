Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933066AbWFXLiL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933066AbWFXLiL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jun 2006 07:38:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933067AbWFXLiL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jun 2006 07:38:11 -0400
Received: from mail.gmx.net ([213.165.64.21]:25744 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S933066AbWFXLiJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jun 2006 07:38:09 -0400
X-Authenticated: #14349625
Subject: Re: Measuring tools - top and interrupts
From: Mike Galbraith <efault@gmx.de>
To: =?ISO-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Cc: danial_thom@yahoo.com, linux-kernel@vger.kernel.org
In-Reply-To: <1151142716.7797.10.camel@Homer.TheSimpsons.net>
References: <20060622165808.71704.qmail@web33303.mail.mud.yahoo.com>
	 <1151128763.7795.9.camel@Homer.TheSimpsons.net>
	 <1151130383.7545.1.camel@Homer.TheSimpsons.net>
	 <20060624092156.GA13142@atjola.homenet>
	 <1151142716.7797.10.camel@Homer.TheSimpsons.net>
Content-Type: text/plain; charset=utf-8
Date: Sat, 24 Jun 2006 13:41:57 +0200
Message-Id: <1151149317.7646.14.camel@Homer.TheSimpsons.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 8bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-06-24 at 11:52 +0200, Mike Galbraith wrote:
> On Sat, 2006-06-24 at 11:21 +0200, Björn Steinbrink wrote:
> > 
> > The non-SMP call to update_process_times() is in do_timer_interrupt_hook(),
> > so I guess the above is not the Right Thing to do.
> 
> Ah, there it is.  That's what I was looking for.  I figured that doing
> what I did had to be wrong, but tried it for grins anyway... was pretty
> surprised when it worked (kinda).

Calling update_process_times() in do_timer_interrupt_hook() flat does
not work here.  Calling it in smp_local_timer_interrupt() works fine.  

Oh joy.

	-Mike

