Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932188AbWCaSSS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932188AbWCaSSS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 13:18:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932196AbWCaSSS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 13:18:18 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:29595 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932188AbWCaSSR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 13:18:17 -0500
Date: Fri, 31 Mar 2006 20:15:48 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Ulrich Drepper <drepper@gmail.com>, linux-kernel@vger.kernel.org,
       jakub@redhat.com
Subject: Re: [PATCH] 2.6.16 - futex: small optimization (?)
Message-ID: <20060331181548.GA25053@elte.hu>
References: <4428E7B7.8040408@bull.net> <a36005b50603280702n2979d8ddh97484615ea9d4f3a@mail.gmail.com> <4429BCAC.80208@tmr.com> <20060329152643.GA13194@elte.hu> <442C3F3F.5050107@tmr.com> <20060331060155.GA21975@elte.hu> <442D41B1.1070005@tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <442D41B1.1070005@tmr.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Bill Davidsen <davidsen@tmr.com> wrote:

> >What are you suggesting here, that the implementation of 
> >FUTEX_WAKE_OP is "ignoring inefficiencies"? Please explain why and 
> >what you would do differently to solve that inefficiency.
>
> I am suggesting that "There are no such situations anymore in an 
> optimal userlevel implementation" is not the right approach to the 
> original post. What I would do differently is to evaluate the original 
> suggestion to see if it would in fact be more efficient. [...]

that's what we did a year ago for a similar futex rescheduling 
inefficiency, and came up with the FUTEX_WAKE_OP solution, which is now 
part of the kernel and is used by glibc. But we are all ears for 
alternative suggestions.

	Ingo
