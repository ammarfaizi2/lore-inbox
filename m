Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263280AbSLFQMe>; Fri, 6 Dec 2002 11:12:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263321AbSLFQMe>; Fri, 6 Dec 2002 11:12:34 -0500
Received: from adsl-67-64-81-217.dsl.austtx.swbell.net ([67.64.81.217]:18322
	"HELO digitalroadkill.net") by vger.kernel.org with SMTP
	id <S263280AbSLFQMd>; Fri, 6 Dec 2002 11:12:33 -0500
Subject: Re: Maybe a VM bug in 2.4.18-18 from RH 8.0?
From: GrandMasterLee <masterlee@digitalroadkill.net>
To: Andrew Morton <akpm@digeo.com>
Cc: Andrea Arcangeli <andrea@suse.de>,
       William Lee Irwin III <wli@holomorphy.com>,
       Norman Gaywood <norm@turing.une.edu.au>, linux-kernel@vger.kernel.org
In-Reply-To: <3DF056EE.EA9ADE01@digeo.com>
References: <3DF050EB.108DCF8@digeo.com>
	 <1039160042.16565.15.camel@localhost>  <3DF056EE.EA9ADE01@digeo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Digitalroadkill.net
Message-Id: <1039191598.19066.9.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 06 Dec 2002 10:19:58 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-12-06 at 01:51, Andrew Morton wrote:
> GrandMasterLee wrote:
> > 
> > ...
> > > "crashes"?  kernel, or application?   What additional info is
> > > available?
> > 
> > Machine will panic. I've actually captured some and sent them to this
> > list, but I've been told that my stack was corrupt.
> 
> OK.  In your second oops trace the `swapper' process had used 5k of its
> 8k kernel stack processing an XFS IO completion interrupt.  And I don't
> think `swapper' uses much stack of its own.

The second Oops is the *best* one IMO. I got it just over 7 days. (like
7 days 6 hours or something. I've still been testing the crud out of
this kernel on like hardware, and can't reproduce it. I'd love to know a
method for reproducing this for my beta environment.

> If some other process happens to be using 3k of stack when the same 
> interrupt hits it, it's game over.
> 
> So at a guess, I'd say you're being hit by excessive stack use in
> the XFS filesystem.  I think the XFS team have done some work on that
> recently so an upgrade may help.

Since we run ~1TB dbs on the systems, and a LOT of IO, and Qlogic
drivers, I think that's the culprit. Will swapper use less stack in more
recent kernels?(XFS will be updated as part of a plan for the new year
I'm putting together. Till then, it's reboot every 7 days)


> Or it may be something completely different ;)

I hope not. :)

--The GrandMaster

