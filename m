Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129273AbQJaHMN>; Tue, 31 Oct 2000 02:12:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129436AbQJaHMD>; Tue, 31 Oct 2000 02:12:03 -0500
Received: from mta5.snfc21.pbi.net ([206.13.28.241]:4512 "EHLO
	mta5.snfc21.pbi.net") by vger.kernel.org with ESMTP
	id <S129273AbQJaHMA>; Tue, 31 Oct 2000 02:12:00 -0500
Date: Mon, 30 Oct 2000 11:18:20 -0800
From: Dan Kegel <dank@alumni.caltech.edu>
Subject: Re: Readiness vs. completion (was: Re: Linux's implementation
 ofpoll()not scalable?)
To: John Gardiner Myers <jgmyers@netscape.com>
Cc: linux-kernel@vger.kernel.org
Reply-to: dank@alumni.caltech.edu
Message-id: <39FDC97C.456478E1@alumni.caltech.edu>
MIME-version: 1.0
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.14-5.0 i686)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
X-Accept-Language: en
In-Reply-To: <39FCC2B8.DA281B4C@alumni.caltech.edu>
 <39FDC42A.CD9C3D12@netscape.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Gardiner Myers wrote:
> 
> Dan Kegel wrote:
> > IMHO you're describing a situation where a 'completion notification event'
> > (as with aio) would be more appropriate than a 'readiness notification event'
> > (as with poll).
> 
> I've found that I want both types of events, preferably through the same
> interface.  

That's good to know.

> To provide a "completion notification event" interface on
> top of an existing nonblocking interface, one needs an "async poll"
> mechanism with edge-triggered events with no event coalescing.

If you have a top-notch completion notification event interface
provided natively by the OS, though, does that get rid of the
need for the "async poll" mechanism?
 
> You are correct in recognizing NT completion ports from my description.
> While the NT completion port interface is ugly as sin, it gets a number
> of performance issues right.
> 
> > And, come to think of it, network programmers usually can be categorized
> > into the same two groups :-)  Each style of programming is an acquired taste.
> 
> I would say that the "completion notification" style is a paradigm
> beyond the "readiness notification" style.  I started with the select()
> model of network programming and have since learned the clear
> superiority of the "completion notificatin" style.

Both seem to have their place, and deserve good support, IMHO.

- Dan
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
