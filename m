Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S143817AbRAHOHl>; Mon, 8 Jan 2001 09:07:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S143871AbRAHOHb>; Mon, 8 Jan 2001 09:07:31 -0500
Received: from smtpgw.bnl.gov ([130.199.3.16]:28678 "EHLO smtpgw.sec.bnl.local")
	by vger.kernel.org with ESMTP id <S143817AbRAHOH1>;
	Mon, 8 Jan 2001 09:07:27 -0500
Date: Mon, 8 Jan 2001 09:06:45 -0500
From: Tim Sailer <sailer@bnl.gov>
To: Andrew Morton <andrewm@uow.edu.au>
Cc: linux-kernel@vger.kernel.org, jfung@bnl.gov
Subject: Re: Network Performance?
Message-ID: <20010108090644.A12440@bnl.gov>
In-Reply-To: <20010104013340.A20552@bnl.gov>, <20010104013340.A20552@bnl.gov>; <20010105140021.A2016@bnl.gov> <3A56FD6C.93D09ABB@uow.edu.au>, <3A56FD6C.93D09ABB@uow.edu.au>; <20010107235123.B6028@bnl.gov> <3A5995CF.7AEFFBBD@uow.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <3A5995CF.7AEFFBBD@uow.edu.au>; from andrewm@uow.edu.au on Mon, Jan 08, 2001 at 09:26:23PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 08, 2001 at 09:26:23PM +1100, Andrew Morton wrote:
> Tim Sailer wrote:
> > 
> > On Sat, Jan 06, 2001 at 10:11:40PM +1100, Andrew Morton wrote:
> > > this issue was discussed on the netdev mailing list a few weeks
> > > back.
> > >
> > > It's very unfortunate that the web archives of netdev
> > > stopped working several months ago and there now appears
> > > to be no web archive of netdev@oss.sgi.com.
> > >
> > > Go to http://oss.sgi.com/projects/netdev/archive/ and
> > > pull down the November and December archives.
> > >
> > > The subject was "linux to solaris tcp issues on WAN".
> > >
> > > The conclusion was "The problem is also fixed with
> > > 2.4.0-test12pre3". Dunno about kernel 2.2 though.
> > 
> > Well, on Friday, we pulled down the 'official' 2.4.0, and had the
> > same experience... nothing better. Should I get the -test12-pre3 kernel
> > and try that one specifically?
> 
> I doubt if that would help.
> 
> I claim no expertise in this area, but perhaps we can
> get some protocol gurus interested.
> 
> To recap:
> 
> You're sending and receiving FTP/TCP/IP4 to Solaris and AIX hosts

Yup

> You have a 1000kbyte window size

Yup

> You have an 80 megabit/sec pipe.

Actually, 100 to the router, and then the WAN connection to the remote
system is OC-3

> You're getting 1.8 megabits/sec.

Yup

> What is the round-trip time on the WAN?
> 
> Packet loss?

101 packets transmitted, 101 packets received, 0% packet loss
round-trip min/avg/max = 109.6/110.3/112.2 ms

> Does the problem occur in both directions?

Good question. I'll find out.

> Are you _sure_ the window size is being set correctly? How
> is it being set?

I'm fairly sure. We echo the value to the file. catting it back
shows the correct value. If we go lower than default, it slows
down even more.

> Are you able to generate TCP dumps when the problem is happening?

We can, if it will help.

Tim

-- 
Tim Sailer <sailer@bnl.gov> Cyber Security Operations
Brookhaven National Laboratory  (631) 344-3001
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
