Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285050AbRLFIp4>; Thu, 6 Dec 2001 03:45:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285060AbRLFIpr>; Thu, 6 Dec 2001 03:45:47 -0500
Received: from mx2.elte.hu ([157.181.151.9]:20675 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S285050AbRLFIpe>;
	Thu, 6 Dec 2001 03:45:34 -0500
Date: Thu, 6 Dec 2001 11:41:29 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] scalable timers implementation, 2.4.16, 2.5.0
In-Reply-To: <20011206082949.400dffd5.rusty@rustcorp.com.au>
Message-ID: <Pine.LNX.4.33.0112061140260.2778-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 6 Dec 2001, Rusty Russell wrote:

> 	Hmm... there are some ugly hoops there to make sure that they
> don't conflict with bottom halves or cli().  I assume you want to take
> that out: what will break if that happens, and do we need a
> disable_timers() interface to move code over?

hm, those ugly hoops are really limited in scope - they cause no
scalability or other visible performance impact. So i thought we do the
threading first (and *just* the threading), then we might change the timer
interface. But that is a *huge* task.

	Ingo

