Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261243AbVECAQS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261243AbVECAQS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 May 2005 20:16:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261245AbVECAQS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 May 2005 20:16:18 -0400
Received: from gate.crashing.org ([63.228.1.57]:9641 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261243AbVECAQO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 May 2005 20:16:14 -0400
Subject: Re: [PATCH] fix __mod_timer vs __run_timers deadlock.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Juergen Kreileder <jk@blackdown.de>
Cc: Andrew Morton <akpm@osdl.org>, Oleg Nesterov <oleg@tv-sign.ru>,
       linux-kernel@vger.kernel.org, maneesh@in.ibm.com
In-Reply-To: <87vf61kztb.fsf@blackdown.de>
References: <42748B75.D6CBF829@tv-sign.ru>
	 <20050501023149.6908c573.akpm@osdl.org>  <87vf61kztb.fsf@blackdown.de>
Content-Type: text/plain
Date: Tue, 03 May 2005 10:13:50 +1000
Message-Id: <1115079230.6155.35.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-05-03 at 00:50 +0200, Juergen Kreileder wrote:
> Andrew Morton <akpm@osdl.org> writes:
> 
> > Oleg Nesterov <oleg@tv-sign.ru> wrote:
> >>
> >> When __mod_timer() changes timer's base it waits for the completion
> >> of timer->function. It is just stupid: the caller of __mod_timer()
> >> can held locks which would prevent completion of the timer's
> >> handler.
> >>
> >> Solution: do not change the base of the currently running timer.
> >
> > OK, fingers crossed.  Juergen, it would be great if you could test
> > Oleg's patch sometime.
> 
> I had one more lockup yesterday but that probably was caused by
> something else because Azureus is running fine for 24 hours now.

Well, there may be other issues brought by this new timer code though.
I'm running G5s regulary without a lockup or anything for weeks, so it
would be interesting if you could try to find out what's involved in
that other lockup you had.

Ben


