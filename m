Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285023AbSBDStK>; Mon, 4 Feb 2002 13:49:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285073AbSBDSsv>; Mon, 4 Feb 2002 13:48:51 -0500
Received: from FORT-POINT-STATION.MIT.EDU ([18.7.7.76]:60650 "EHLO
	fort-point-station.mit.edu") by vger.kernel.org with ESMTP
	id <S285023AbSBDSsl>; Mon, 4 Feb 2002 13:48:41 -0500
Message-Id: <200202041848.NAA04094@coleco-sidewinder.mit.edu>
X-Mailer: exmh version 2.1.1 10/15/1999
To: Aaron Sethman <androsyn@ratbox.org>
cc: Darren Smith <data@barrysworld.com>, "'Andrew Morton'" <akpm@zip.com.au>,
        "'Dan Kegel'" <dank@kegel.com>,
        "'Vincent Sweeney'" <v.sweeney@barrysworld.com>,
        linux-kernel@vger.kernel.org, coder-com@undernet.org,
        "'Kevin L. Mitchell'" <klmitch@MIT.EDU>
Subject: Re: [Coder-Com] Re: PROBLEM: high system usage / poor SMP network performance
In-Reply-To: Your message of "Mon, 04 Feb 2002 13:30:40 EST."
             <Pine.LNX.4.44.0202041327420.4584-100000@simon.ratbox.org> 
Date: Mon, 04 Feb 2002 13:48:21 -0500
From: Kev <klmitch@MIT.EDU>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I mean I added a usleep() before the poll in s_bsd.c for the undernet
> > 2.10.10 code.
> >
> >  timeout = (IRCD_MIN(delay2, delay)) * 1000;
> >  + usleep(100000); <- New Line
> >  nfds = poll(poll_fds, pfd_count, timeout);
> Why not just add the additional delay into the poll() timeout?  It just
> seems like you were not doing enough of a delay in poll().

Wouldn't have the effect.  The original point was that adding the usleep()
gives some time for some more file descriptors to become ready before calling
poll(), thus increasing the number of file descriptors poll() can return
per system call.  Adding the time to timeout would have no effect.
-- 
Kevin L. Mitchell <klmitch@mit.edu>

