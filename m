Return-Path: <linux-kernel-owner+w=401wt.eu-S1422698AbWLUE0v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422698AbWLUE0v (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 23:26:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422703AbWLUE0v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 23:26:51 -0500
Received: from smtp.osdl.org ([65.172.181.25]:36615 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422698AbWLUE0u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 23:26:50 -0500
Date: Wed, 20 Dec 2006 20:26:21 -0800
From: Andrew Morton <akpm@osdl.org>
To: john stultz <johnstul@us.ibm.com>
Cc: Roman Zippel <zippel@linux-m68k.org>, Ingo Molnar <mingo@elte.hu>,
       Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] HZ free ntp
Message-Id: <20061220202621.8e147b1d.akpm@osdl.org>
In-Reply-To: <1166579658.5594.6.camel@localhost>
References: <20061204204024.2401148d.akpm@osdl.org>
	<Pine.LNX.4.64.0612060348150.1868@scrub.home>
	<20061205203013.7073cb38.akpm@osdl.org>
	<1165393929.24604.222.camel@localhost.localdomain>
	<Pine.LNX.4.64.0612061334230.1867@scrub.home>
	<20061206131155.GA8558@elte.hu>
	<Pine.LNX.4.64.0612061422190.1867@scrub.home>
	<1165956021.20229.10.camel@localhost>
	<Pine.LNX.4.64.0612131338420.1867@scrub.home>
	<1166037549.6425.21.camel@localhost.localdomain>
	<Pine.LNX.4.64.0612132125450.1867@scrub.home>
	<1166578357.5594.3.camel@localhost>
	<1166579658.5594.6.camel@localhost>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Dec 2006 17:54:18 -0800
john stultz <johnstul@us.ibm.com> wrote:

> On Tue, 2006-12-19 at 17:32 -0800, john stultz wrote:
> > On Wed, 2006-12-13 at 21:40 +0100, Roman Zippel wrote:
> > > On Wed, 13 Dec 2006, john stultz wrote:
> > > > > You don't have to introduce anything new, it's tick_length that changes
> > > > > and HZ that becomes a variable in this function.
> > > >
> > > > So, forgive me for rehashing this, but it seems we're cross talking
> > > > again. The context here is the dynticks code. Where HZ doesn't change,
> > > > but we get interrupts at much reduced rates.
> > > 
> > > I know and all you have to change in the ntp and some related code is to
> > > replace HZ there with a variable, thus make it changable, so you can
> > > increase the update interval (i.e. it becomes 1s/hz instead of 1s/HZ).
> > 
> > Untested patch below. Does this vibe better with you are suggesting?
> 
> And here would be the follow on patch (again *untested*) for
> CONFIG_NO_HZ slowing the time accumulation down to once per second.

I'm still awaiting a final-looking version of this patch, fyi.

I don't understand whether this is a theoretical might-happen thing,
or if NTP problems have actually been observed in the field?

Either way, I'm sure the final changelog will clear that up ;)
