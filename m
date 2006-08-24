Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965333AbWHXBrU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965333AbWHXBrU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 21:47:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965334AbWHXBrU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 21:47:20 -0400
Received: from adsl-69-232-92-238.dsl.sndg02.pacbell.net ([69.232.92.238]:49827
	"EHLO gnuppy.monkey.org") by vger.kernel.org with ESMTP
	id S965333AbWHXBrT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 21:47:19 -0400
Date: Wed, 23 Aug 2006 18:46:58 -0700
To: Robert Crocombe <rcrocomb@gmail.com>
Cc: Esben Nielsen <nielsen.esben@gmail.com>, Ingo Molnar <mingo@elte.hu>,
       Thomas Gleixner <tglx@linutronix.de>, rostedt@goodmis.org,
       linux-kernel <linux-kernel@vger.kernel.org>,
       "Bill Huey (hui)" <billh@gnuppy.monkey.org>
Subject: Re: rtmutex assert failure (was [Patch] restore the RCU callback...)
Message-ID: <20060824014658.GB19314@gnuppy.monkey.org>
References: <e6babb600608151053u6b902b80k9e3b399fe34ee10f@mail.gmail.com> <20060818115934.GA29919@gnuppy.monkey.org> <e6babb600608211721g739c5518sa14427d1e9f2334@mail.gmail.com> <20060822013722.GA628@gnuppy.monkey.org> <20060822232051.GA8991@gnuppy.monkey.org> <e6babb600608231014r23886965k9cbc1fd3b80930bb@mail.gmail.com> <20060823202046.GA17267@gnuppy.monkey.org> <20060823210558.GA17606@gnuppy.monkey.org> <20060823210842.GB17606@gnuppy.monkey.org> <e6babb600608231822s1ce8b229ubdc85ce7544c6b4@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e6babb600608231822s1ce8b229ubdc85ce7544c6b4@mail.gmail.com>
User-Agent: Mutt/1.5.11+cvs20060403
From: Bill Huey (hui) <billh@gnuppy.monkey.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 23, 2006 at 06:22:03PM -0700, Robert Crocombe wrote:
> On 8/23/06, hui Bill Huey <billh@gnuppy.monkey.org> wrote:
> >On Wed, Aug 23, 2006 at 02:05:58PM -0700, Bill Huey wrote:
> >> I'm on irc.oftc.net as "bh" if you want somebody that's interactive. It
> >> might help with things here.
> >
> >#kernelnewbies is the channel.
> 
> Firewall where only port 80 is open.  I tried this thing:
> 
> http://www.polarhome.com/cgi-bin/chat/irc.cgi
> 
> but it looks like it connects to the wrong port (8888 vs 6667?), or
> something.  I see that some Windows *shudder* client supposedly
> supports thru-firewill connections, and additionally some instructions
> about port-forwarding off an outside machine, but I'm kinda stuck for
> the moment.

This is IRC and the #kernelnewbies channel is where a number of us (folks
following Rik van Riel) lurk. Any client like BitchX should work if you
have those ports open from where you're coming from.

> Okay, tried the patch.  I actually made it through one full kernel
> compile without going bang, but did crap out on the second iteration
> (after a 'make clean').
> 
> I'll post the config, too, just so there's a clear understanding of
> where we are.

Ok, yeah, I've been trying to get a clean stack trace output and not
really focused on the core issue. The debug output stuff seemed to need
some attention because of the hanging and continuous output of stack
traces. It makes it difficult to figure out what's going on when there
are a cascade of failures going on.

I'll upload those small changes next and try to figure out what's going
on with kjournald and the rtmutex. This is going to be a pain.

bill

