Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750915AbWG3BAt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750915AbWG3BAt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jul 2006 21:00:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750917AbWG3BAt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jul 2006 21:00:49 -0400
Received: from adsl-69-232-92-238.dsl.sndg02.pacbell.net ([69.232.92.238]:7875
	"EHLO gnuppy.monkey.org") by vger.kernel.org with ESMTP
	id S1750913AbWG3BAs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jul 2006 21:00:48 -0400
Date: Sat, 29 Jul 2006 18:00:20 -0700
To: Nicholas Miell <nmiell@comcast.net>
Cc: Edgar Toernig <froese@gmx.de>, Neil Horman <nhorman@tuxdriver.com>,
       Jim Gettys <jg@laptop.org>, "H. Peter Anvin" <hpa@zytor.com>,
       Dave Airlie <airlied@gmail.com>,
       Segher Boessenkool <segher@kernel.crashing.org>,
       linux-kernel@vger.kernel.org, a.zummo@towertech.it, jg@freedesktop.org,
       Keith Packard <keithp@keithp.com>, Ingo Molnar <mingo@elte.hu>,
       Steven Rostedt <rostedt@goodmis.org>,
       "Bill Huey (hui)" <billh@gnuppy.monkey.org>
Subject: Re: itimer again (Re: [PATCH] RTC: Add mmap method to rtc character driver)
Message-ID: <20060730010020.GA23288@gnuppy.monkey.org>
References: <44C6875F.4090300@zytor.com> <1153862087.1230.38.camel@localhost.localdomain> <44C68AA8.6080702@zytor.com> <1153863542.1230.41.camel@localhost.localdomain> <20060729042820.GA16133@gnuppy.monkey.org> <20060729125427.GA6669@localhost.localdomain> <20060729204107.GA20890@gnuppy.monkey.org> <20060729234948.0768dbf4.froese@gmx.de> <20060729225138.GA22390@gnuppy.monkey.org> <1154216151.2467.5.camel@entropy>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1154216151.2467.5.camel@entropy>
User-Agent: Mutt/1.5.11+cvs20060403
From: Bill Huey (hui) <billh@gnuppy.monkey.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 29, 2006 at 04:35:51PM -0700, Nicholas Miell wrote:
> On Sat, 2006-07-29 at 15:51 -0700, Bill Huey wrote:
> > [CCing Steve and Ingo on this thread]
> > 
> > It's a different topic than what Keith needs, but this is useful for another
> > set of purposes. It's something that's really useful in the RT patch since
> > there isn't a decent API to get at high resolution timers in userspace. What
> > you've written is something that I articulated to Steve Rostedt over a dinner
> > at OLS and is badly needed in the -rt patches IMO. I suggest targeting that
> > for some kind of inclusion to Ingo Molnar's patchset.
> > 
> 
> Do you mind summarizing what's wrong with the existing interfaces for
> those of us who didn't have the opportunity to join you for dinner at
> OLS?

Think edge triggered verse level triggered. Event interfaces in the Linux
kernel are sort of just that, edge triggered events. What RT folks generally
want is control over scheduling policies over a particular time period in
relation to a scheduling policy. A general kernel event interface isn't
going to cut it for those purpose and wasn't design to deal with those cases
in the first place.

bill

