Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272652AbTHKONA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 10:13:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272639AbTHKOMm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 10:12:42 -0400
Received: from mail.cpt.sahara.co.za ([196.41.29.142]:28920 "EHLO
	workshop.saharact.lan") by vger.kernel.org with ESMTP
	id S272712AbTHKOJ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 10:09:58 -0400
Subject: Re: [PATCH]O14int
From: Martin Schlemmer <azarah@gentoo.org>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: Con Kolivas <kernel@kolivas.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <3F376597.9000708@cyberone.com.au>
References: <200308090149.25688.kernel@kolivas.org>
	 <200308111608.18241.kernel@kolivas.org> <3F375EBD.5030106@cyberone.com.au>
	 <200308111943.49235.kernel@kolivas.org>  <3F376597.9000708@cyberone.com.au>
Content-Type: text/plain
Message-Id: <1060610663.13256.76.camel@workshop.saharacpt.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 11 Aug 2003 16:04:24 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-08-11 at 11:44, Nick Piggin wrote:

> >
> >Sigh..,
> >
> >No, it sounds to me like things are expiring faster than on default. He didn't 
> >say make -j10, it was multiple -j10s. This is one where you simply cannot let 
> >the scheduler keep starving the make -j10s indefinitely for X; on a server or 
> >multiuser box X will simply cause unfair starvation. I'm trying to find a 
> >workaround for this without rewriting whole sections of the scheduler code, 
> >but I'm just not sure I should be trying to optimise for a desktop that runs 
> >loads >16 per cpu. (I'll keep trying though, but if there is no workaround 
> >that remains fair it wont happen)
> >
> >
> 
> Yep, I did see the multiple j10s ;)
> I wasn't aware that there was longer term starvation of gccs by X. I
> thought the scheduler had always been quite good at evening up the
> total CPU time used and a change you made had recently introduced a
> latency or interactiveness problem.
> 

I did not say the 'make -j10s' starved.  I am saying that mouse
is laggish, as well as window/desktop switching.

Also, I am not saying Con should fix it - I am asking if we really
want one scheduler that should try to do the right thing for SMP
*and* UP.


-- 
Martin Schlemmer


