Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262113AbUEFNBO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262113AbUEFNBO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 09:01:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262109AbUEFNBD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 09:01:03 -0400
Received: from mail.tmr.com ([216.238.38.203]:3850 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S262132AbUEFM5K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 08:57:10 -0400
Date: Thu, 6 May 2004 08:54:07 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Helge Hafting <helgehaf@aitel.hist.no>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-rc3-mm2 (4KSTACK)
In-Reply-To: <409A0EEB.9080409@aitel.hist.no>
Message-ID: <Pine.LNX.3.96.1040506084858.20018C-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 May 2004, Helge Hafting wrote:

> Bill Davidsen wrote:
> 
> > Andrew Morton wrote:
> >
> >>
> >> We need to push this issue along quickly.  The single-page stack 
> >> generally
> >> gives us a better kernel and having the stack size configurable creates
> >> pain.
> >
> >
> > Add my voice to those who don't think 4k stacks are a good idea as a 
> > default, they break some things and seem to leave other paths (as 
> > others have noted) on the edge. I'm not sure what you have in mind as 
> > a "better kernel" but I'd rather have a worse kernel and not have to 
> > check 4k stack as a possible problem before looking at other things if 
> > I get bad behaviour. 
> 
> I think 4k stacks is perfectly ok for mm, as mm is an experimental
> testing ground anyway.  Not everything in mm goes into the next 2.6.x.
> 
> 
> Wether 4k goes into some 2.6 release or waits for 2.7 is another debate.

I think it's fine as an option, but taking it out of config and making it
an immutable part of the kernel is probably undesirable. It appears to be
a small gain (nothing I can easily measure), and a larger risk. I'd like
that to be an optional risk, like many other things in the kernel,
available to be used if the last drop of size or performance is desired.

Does someone has any numbers showing what this gains? I didn't see
anything obvious when I tried it, so it's either very small or only in
some case(s) I didn't try.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

