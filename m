Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262695AbRE3VbI>; Wed, 30 May 2001 17:31:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262642AbRE3Va6>; Wed, 30 May 2001 17:30:58 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:22539 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S262632AbRE3Vam>; Wed, 30 May 2001 17:30:42 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Ingo Molnar <mingo@elte.hu>, Nico Schottelius <nicos@pcsystems.de>
Subject: Re: [ PATCH ]: disable pcspeaker kernel: 2.4.2 - 2.4.5
Date: Wed, 30 May 2001 23:32:21 +0200
X-Mailer: KMail [version 1.2]
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0105301724570.2384-100000@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.33.0105301724570.2384-100000@localhost.localdomain>
MIME-Version: 1.0
Message-Id: <0105302332211G.06233@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 30 May 2001 17:25, Ingo Molnar wrote:
> On Wed, 30 May 2001, Nico Schottelius wrote:
> > > the default value is 0, that is good enough.
> >
> > hmm.. I don't think so... value of 1 would be much better, because
> > 0 normally disables the speaker.
>
> i confused the value. Yes, an initialization to 1 would be the
> correct, ie.:
>
> +++ linux-2.4.5-nc/kernel/sysctl.c      Wed May  9 23:44:30 2001
> @@ -48,6 +49,7 @@
>  extern int nr_queued_signals, max_queued_signals;
>  extern int sysrq_enabled;
>
> +int pcspeaker_enabled = 1;

I'd go and change the whole patch so that speaker_disabled = 0 is the 
default, but that's just me.

--
Daniel
