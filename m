Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262758AbVCJRSU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262758AbVCJRSU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 12:18:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262706AbVCJRPv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 12:15:51 -0500
Received: from mail.tmr.com ([216.238.38.203]:47888 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S262192AbVCJRIg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 12:08:36 -0500
Date: Thu, 10 Mar 2005 11:56:45 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Arjan van de Ven <arjan@infradead.org>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Kai Makisara <Kai.Makisara@kolumbus.fi>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] make st seekable again
In-Reply-To: <1110456640.6291.79.camel@laptopd505.fenrus.org>
Message-ID: <Pine.LNX.3.96.1050310114027.11549B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Mar 2005, Arjan van de Ven wrote:

> >  critical user data.
> > 
> > In other words, it should work correctly or not at all. At the least this
> > should be a config option, like UNSAFE_TAPE_POSITIONING or some such.
> > And show the option if the build includes BROKEN features. That should put
> > the decision where it belongs and clarify the possible failures.
> 
> CONFIG_SECURITY_HOLES doesn't make sense.
> Better to just fix the security holes instead.

I think you're an idealist. If this were something other than tar it would
be simple, and you would be right. Well, you ARE right, but a change which
breaks tar, which many sites use for backups, is really not practical,
without a loophole until tar gets fixed. And as Alan noted, keeping track
of the physical position is very hard, and getting a tar fix might take a
while.

None of the choices is good; I see:
 - leave it the way it is
 - fix the hole and break tar
 - wait for FSF to fix tar, then fix the hole
 - try to fix it without breaking tar, which may not be really possible
   and could leave part of the problem and still break tar somehow
 - fix it, and leave the admin a way to build a kernel with the hole other
   than just reverting the fix

I proposed the last, I won't cry if no one else likes it, it just seemed
realistic for people who don't use certain features of tar.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

