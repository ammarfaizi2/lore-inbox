Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288477AbSBDFK6>; Mon, 4 Feb 2002 00:10:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288484AbSBDFKs>; Mon, 4 Feb 2002 00:10:48 -0500
Received: from PACIFIC-CARRIER-ANNEX.MIT.EDU ([18.7.21.83]:42971 "EHLO
	pacific-carrier-annex.mit.edu") by vger.kernel.org with ESMTP
	id <S288477AbSBDFKg>; Mon, 4 Feb 2002 00:10:36 -0500
Message-Id: <200202040510.AAA21897@multics.mit.edu>
X-Mailer: exmh version 2.1.1 10/15/1999
To: Dan Kegel <dank@kegel.com>
cc: Kev <klmitch@MIT.EDU>, Arjen Wolfs <arjen@euro.net>,
        coder-com@undernet.org, feedback@distributopia.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [Coder-Com] Re: PROBLEM: high system usage / poor SMPnetwork performance
In-Reply-To: Your message of "Sun, 03 Feb 2002 19:25:03 PST."
             <3C5DFF0F.3B5EFFC0@kegel.com> 
Date: Mon, 04 Feb 2002 00:10:29 -0500
From: Kev <klmitch@MIT.EDU>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > If I'm reading Poller_sigio::waitForEvents correctly, the rtsig stuff at
> > least tries to return a list of which sockets have become ready, and your
> > implementation falls back to some other interface when the signal queue
> > overflows.  It also seems to extract what state the socket's in at that
> > point.
> > 
> > If that's true, I confess I can't quite see your point even still.  Once
> > the event is generated, ircd should read or write as much as it can, then
> > not pay any attention to the socket until readiness is again signaled by
> > the generation of an event.  Sorry if I'm being dense here...
> 
> If you actually do read or write *until an EWOULDBLOCK*, no problem.
> If your code has a path where it fails to do so, it will get stuck,
> as no further readiness events will be forthcoming.  That's all.

Ah ha!  And you may indeed have a point there...
-- 
Kevin L. Mitchell <klmitch@mit.edu>

