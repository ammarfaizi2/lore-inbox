Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131244AbRC3Jht>; Fri, 30 Mar 2001 04:37:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131246AbRC3Jhk>; Fri, 30 Mar 2001 04:37:40 -0500
Received: from mandrakesoft.mandrakesoft.com ([216.71.84.35]:36418 "EHLO
	mandrakesoft.mandrakesoft.com") by vger.kernel.org with ESMTP
	id <S131244AbRC3Jhc>; Fri, 30 Mar 2001 04:37:32 -0500
Date: Fri, 30 Mar 2001 03:36:40 -0600 (CST)
From: Jeff Garzik <jgarzik@mandrakesoft.com>
To: Tom Leete <tleete@mountain.net>
cc: Ulrich Drepper <drepper@cygnus.com>, dank@trellisinc.com,
   linux-kernel@vger.kernel.org, Eli Carter <eli.carter@inet.com>
Subject: Re: [PATCH] pcnet32 compilation fix for 2.4.3pre6
In-Reply-To: <3AC3BD64.7702CD7B@mountain.net>
Message-ID: <Pine.LNX.3.96.1010330033440.8826B-100000@mandrakesoft.mandrakesoft.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Mar 2001, Tom Leete wrote:
> Ulrich Drepper wrote:
> > 
> > dank@trellisinc.com writes:
> > 
> > > with the new ansi standard, this use of __inline__ is no longer
> > > necessary,
> > 
> > This is not correct.  Since the semantics of inline in C99 and gcc
> > differ all code which depends on the gcc semantics should continue to
> > use __inline__ since this keyword will hopefully forever signal the
> > gcc semantics.

> Unfortunately, it seems that gcc will define __inline__ as a synonym for
> inline, whatever inline is currently in use. I asked this on the gcc list a
> while ago. The archive there should have the replies.

None of this matters :)

The kernel standard is 'static inline', so that is the preferred
usage in standard kernel code, without overriding reasons.

(also note that it is an outstanding cleanup item to replace
 'extern [__]inline[__]' with 'static inline', unless there are
 overriding reasons not to do so.)

	Jeff



