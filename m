Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263945AbTHWRUe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Aug 2003 13:20:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263394AbTHWRA4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Aug 2003 13:00:56 -0400
Received: from ns.aratech.co.kr ([61.34.11.200]:30643 "EHLO ns.aratech.co.kr")
	by vger.kernel.org with ESMTP id S264018AbTHWQee (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Aug 2003 12:34:34 -0400
Date: Sun, 24 Aug 2003 01:36:27 +0900
From: TeJun Huh <tejun@aratech.co.kr>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: TeJun Huh <tejun@aratech.co.kr>, linux-kernel@vger.kernel.org
Subject: Re: Race condition in 2.4 tasklet handling (cli() broken?)
Message-ID: <20030823163627.GA7226@atj.dyndns.org>
Mail-Followup-To: Stephan von Krawczynski <skraw@ithnet.com>,
	TeJun Huh <tejun@aratech.co.kr>, linux-kernel@vger.kernel.org
References: <20030823025448.GA32547@atj.dyndns.org> <20030823040931.GA3872@atj.dyndns.org> <20030823052633.GA4307@atj.dyndns.org> <20030823122813.0c90e241.skraw@ithnet.com> <20030823151315.GA6781@atj.dyndns.org> <20030823175604.1ddb119d.skraw@ithnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030823175604.1ddb119d.skraw@ithnet.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 23, 2003 at 05:56:04PM +0200, Stephan von Krawczynski wrote:
> On Sun, 24 Aug 2003 00:13:15 +0900
> TeJun Huh <tejun@aratech.co.kr> wrote:
> 
> >  Hello, Stephan.
> > 
> >  The race conditions I'm mentioning in this thread are not likely to
> > cause real troubles.  The first one does not make any difference on
> > x86, and AFAIK bh isn't used extensively anymore so the second one
> > isn't very relevant either.  Only the race condition mentioned in the
> > other thread is of relvance if there is any :-(.
> 
> Are you sure? bh is used in fs subtree to my knowledge ...
> 

 Wow, I'm not sure.  Because our application is mostly concerned with
network and raw DISK I/O, I haven't been paying attention to fs codes.
If bh can be problematic, I'll try to rethink about the bh
synchronization and make a patch tomorrow, probably another one or two
liner.  First thing tomorrow.

-- 
tejun
