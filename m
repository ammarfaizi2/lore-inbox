Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263092AbREaM4a>; Thu, 31 May 2001 08:56:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263096AbREaM4U>; Thu, 31 May 2001 08:56:20 -0400
Received: from g126.dialup.pcsystems.de ([212.63.44.126]:58351 "HELO
	schottelius.org") by vger.kernel.org with SMTP id <S263092AbREaM4O>;
	Thu, 31 May 2001 08:56:14 -0400
Message-ID: <3B163F51.986D0D3@pcsystems.de>
Date: Thu, 31 May 2001 14:55:46 +0200
From: Nico Schottelius <nicos@pcsystems.de>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Daniel Phillips <phillips@bonn-fries.net>
CC: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Subject: Re: [ PATCH ]: disable pcspeaker kernel: 2.4.2 - 2.4.5
In-Reply-To: <Pine.LNX.4.33.0105301724570.2384-100000@localhost.localdomain> <0105302332211G.06233@starship>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips wrote:

> On Wednesday 30 May 2001 17:25, Ingo Molnar wrote:
> > On Wed, 30 May 2001, Nico Schottelius wrote:
> > > > the default value is 0, that is good enough.
> > >
> > > hmm.. I don't think so... value of 1 would be much better, because
> > > 0 normally disables the speaker.
> >
> > i confused the value. Yes, an initialization to 1 would be the
> > correct, ie.:
> >
> > +++ linux-2.4.5-nc/kernel/sysctl.c      Wed May  9 23:44:30 2001
> > @@ -48,6 +49,7 @@
> >  extern int nr_queued_signals, max_queued_signals;
> >  extern int sysrq_enabled;
> >
> > +int pcspeaker_enabled = 1;
>
> I'd go and change the whole patch so that speaker_disabled = 0 is the
> default, but that's just me.

Hmm...I thinking positive is more likely for humans, and double
negotation, like "not_disable" is less taken than just "enable".

So I agree with ingo, just setting pcspeaker_enabled = 1 at
normal would be the very best way.

Just after discussing about that, is it possible
someone adds the final patch ?


Nico

