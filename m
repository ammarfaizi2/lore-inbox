Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262408AbVCWXNa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262408AbVCWXNa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 18:13:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262441AbVCWXNa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 18:13:30 -0500
Received: from web53301.mail.yahoo.com ([206.190.39.230]:5537 "HELO
	web53301.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262408AbVCWXNZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 18:13:25 -0500
Message-ID: <20050323231324.96262.qmail@web53301.mail.yahoo.com>
Date: Wed, 23 Mar 2005 23:13:24 +0000 (GMT)
From: sounak chakraborty <sounakrin@yahoo.co.in>
Subject: Re: repeat a function after fixed time period
To: linux-os@analogic.com, linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: 6667
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- linux-os <linux-os@analogic.com> wrote:
> On Wed, 23 Mar 2005, Arjan van de Ven wrote:
> 
> > On Wed, 2005-03-23 at 15:56 -0500, linux-os wrote:
> >>>> static void start_timer(void)
> >>>> {
> >>>>      if(!atomic_read(&info->running))
> >>>>      {
> >>>>          atomic_inc(&info->running);
> >>>
> >>> same race.
> >>
> >> No such race at all.
> >
> > here there is one; you use add_timer() which isn't
> allowed on running
> > timers, only mod_timer() is. So yes there is a
> race.
> >
> 
> Well add_timer() is only executed after the timer
> has expired
> or hasn't started yet so the "isn't allowed" is
> pretty broad.
> If I should use mod_timer(), then there are a _lot_
> of buggy
> drivers in the kernel because that's how a lot
> repeat the
> sequence. Will mod_timer() actually restart the
> timer???
> 
> If so, I'll change it and thank you for the help.
    

   i have applied the code
as i was intedded to call a function repeated ly in
fork.c i written the code over there 
it compiled smoothly 
but while booting 
it is showing
kernel panic no init found
kjournal starting .commit interval after 5 seconds

sounak

________________________________________________________________________
Yahoo! India Matrimony: Find your partner online. http://yahoo.shaadi.com/india-matrimony/
