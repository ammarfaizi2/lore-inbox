Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261245AbVALJbv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261245AbVALJbv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 04:31:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261306AbVALJbv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 04:31:51 -0500
Received: from wproxy.gmail.com ([64.233.184.199]:61351 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261245AbVALJbs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 04:31:48 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=CJbelYGRGuq/6IdpshRLwb6Q66+kH/3Dxh+araj65kmq9RfYH6quthkxmzQWHPdPZ4f0AbaEi0zc0nYnEz6kZIhmfuNDTgKnginiX5whRnEmEwHqyTWKPJtRFyPLfuXq9mGKXOSmRpqV4U0rQfSkLiY2moqRjjKlmGo/3/IacWk=
Message-ID: <4d6522b9050112013123535a0b@mail.gmail.com>
Date: Wed, 12 Jan 2005 11:31:47 +0200
From: Edjard Souza Mota <edjard@gmail.com>
Reply-To: Edjard Souza Mota <edjard@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>
Subject: Re: User space out of memory approach
Cc: Ilias Biris <xyz.biris@gmail.com>, tglx@linutronix.de,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Andrew Morton <akpm@osdl.org>, Andrea Arcangeli <andrea@suse.de>
In-Reply-To: <1105477069.17853.126.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <3f250c71050110134337c08ef0@mail.gmail.com>
	 <4d6522b9050110144017d0c075@mail.gmail.com>
	 <20050110200514.GA18796@logos.cnet>
	 <1105403747.17853.48.camel@tglx.tec.linutronix.de>
	 <4d6522b90501101803523eea79@mail.gmail.com>
	 <1105433093.17853.78.camel@tglx.tec.linutronix.de>
	 <1105461106.16168.41.camel@localhost.localdomain>
	 <4e1a70d1050111111614670f32@mail.gmail.com>
	 <4e1a70d10501111246391176b@mail.gmail.com>
	 <1105477069.17853.126.camel@tglx.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


On Tue, 11 Jan 2005 21:57:49 +0100, Thomas Gleixner <tglx@linutronix.de> wrote:
> On Tue, 2005-01-11 at 16:46 -0400, Ilias Biris wrote:
> > well looking into Alan's email again I think I answered thinking on
> > the wrong side :-) that the suggestion was to switch off OOM
> > altogether and be done with all the discussion... tsk tsk tsk too
> > defensive and hasty I guess :-)
> >
> > Thinking it in another way alan's email could have the dimension of
> > switching off overcommitment (and thus OOM) whilst in the user-space
> > ranking stage to avoid reentrancy and invocation of oom again and
> > again before killing something. It also solves the issue of using
> > timed/counted resources  which is plain ugly and evil. It would though
> > be necessary to switch OOM back on when the OOMK has finally done the
> > kill.
> >
> > Did I get it right this time Alan?
> 
> I don't get it at all.
> 
> Fixes for wrong invocation, reentrancy avoidance, removal of the ugly
> and evil timer,counter hacks are in the wild since more than 6 weeks.
> They solve the problem without any userspace interaction.
> 
> The userspace provided preferrable victim list is an improvement of the
> generic heuristic and therefor imperfect selection mechanism and nothing
> else.

Once again the user space ranking of PIDs for OOM killer purposes didn't
propose a new selection mechanism. This misinterpretation is misleading the
discussion of whether it may have som use in embedded devices or not.
Even though, I believe that for PCs environment it has a great potential
when you think that admins don't stay all the time in front of a computer.
Once and while they also have a rest :). In these cases, instead of simply
start ranking a deamon could dispatch a msg to her/him saying the system
is approaching a red zone.

br,

Edjard
-- 
"In a world without fences ... who needs Gates?"
