Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751134AbWHYHUU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751134AbWHYHUU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 03:20:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751150AbWHYHUU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 03:20:20 -0400
Received: from adsl-69-232-92-238.dsl.sndg02.pacbell.net ([69.232.92.238]:13207
	"EHLO gnuppy.monkey.org") by vger.kernel.org with ESMTP
	id S1751134AbWHYHUS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 03:20:18 -0400
Date: Fri, 25 Aug 2006 00:19:57 -0700
To: Robert Crocombe <rcrocomb@gmail.com>
Cc: Esben Nielsen <nielsen.esben@gmail.com>, Ingo Molnar <mingo@elte.hu>,
       Thomas Gleixner <tglx@linutronix.de>, rostedt@goodmis.org,
       linux-kernel <linux-kernel@vger.kernel.org>,
       "Bill Huey (hui)" <billh@gnuppy.monkey.org>
Subject: Re: rtmutex assert failure (was [Patch] restore the RCU callback...)
Message-ID: <20060825071957.GA30720@gnuppy.monkey.org>
References: <20060818115934.GA29919@gnuppy.monkey.org> <e6babb600608211721g739c5518sa14427d1e9f2334@mail.gmail.com> <20060822013722.GA628@gnuppy.monkey.org> <20060822232051.GA8991@gnuppy.monkey.org> <e6babb600608231014r23886965k9cbc1fd3b80930bb@mail.gmail.com> <20060823202046.GA17267@gnuppy.monkey.org> <20060823210558.GA17606@gnuppy.monkey.org> <20060823210842.GB17606@gnuppy.monkey.org> <e6babb600608231822s1ce8b229ubdc85ce7544c6b4@mail.gmail.com> <20060824014658.GB19314@gnuppy.monkey.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060824014658.GB19314@gnuppy.monkey.org>
User-Agent: Mutt/1.5.11+cvs20060403
From: Bill Huey (hui) <billh@gnuppy.monkey.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 23, 2006 at 06:46:58PM -0700, Bill Huey wrote:
> On Wed, Aug 23, 2006 at 06:22:03PM -0700, Robert Crocombe wrote:
...
> > I'll post the config, too, just so there's a clear understanding of
> > where we are.
> 
> Ok, yeah, I've been trying to get a clean stack trace output and not
> really focused on the core issue. The debug output stuff seemed to need
> some attention because of the hanging and continuous output of stack
> traces. It makes it difficult to figure out what's going on when there
> are a cascade of failures going on.
> 
> I'll upload those small changes next and try to figure out what's going
> on with kjournald and the rtmutex. This is going to be a pain.

I still can't replicate the problem here with my made up test suite, so
I'm going to take a guess and shove some memory barriers in the rt mutex
code. That code looked a bit suspect.

	http://mmlinux.sourceforge.net/public/against-2.6.17-rt8-2.diff

bill

