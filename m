Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130427AbRAFLGA>; Sat, 6 Jan 2001 06:06:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131130AbRAFLFu>; Sat, 6 Jan 2001 06:05:50 -0500
Received: from isis.its.uow.edu.au ([130.130.68.21]:63677 "EHLO
	isis.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S130427AbRAFLFn>; Sat, 6 Jan 2001 06:05:43 -0500
Message-ID: <3A56FD6C.93D09ABB@uow.edu.au>
Date: Sat, 06 Jan 2001 22:11:40 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0-test8 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Tim Sailer <sailer@bnl.gov>
CC: linux-kernel@vger.kernel.org
Subject: Re: Network Performance?
In-Reply-To: <20010104013340.A20552@bnl.gov>,
		<20010104013340.A20552@bnl.gov>; from sailer@bnl.gov on Thu, Jan 04, 2001 at 01:33:40AM -0500 <20010105140021.A2016@bnl.gov>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Sailer wrote:
> 
> On Thu, Jan 04, 2001 at 01:33:40AM -0500, Tim Sailer wrote:
> > This may not be the right forum to ask this. If not, please let me know
> > where to ask.
> >
> > I have a Debian box with 2 NICs. Both 100/full duplex. This machine is
> > running as a ftp proxy (T.Rex suite). As part of the traffic going through the
> > box, some streams have 1000k window size for a certain reason. How do
> > I tune the NICs to handle the streams better? There are ways of doing this
> > on other OSs. Right now, the box only does about 1.8Mb when it should be doing
> > 80+Mb.
> >
> > Thanks,
> > Tim
> >
> > PS: This is really something to do with the window size and WAN latency.
> > The ultimate source and destination points are either Solaris or AIX
> > boxes. The files being sent are > 1GB in size.
> > The box does well when traffic goes in one NIC and out the other, as long
> > as the end point is local When it hits the WAN, it all dies. Traffic not
> > going through the box just flies right along, as long as both the end points
> > have the large tcp window size. Putting the Linux box in the middle is a
> > severe choke point. :(
> 
> I have followed the suggestions in http://www.psc.edu/networking/perf_tune.html
> but I still can not get any kind of real throughput. 250kB is all I can
> get from the Linux box. Setting [r|w]mem_[default|max] larger than 16k
> makes no difference, smaller slows things down even more. Has anyone else
> ran across this and fixed it? I can't be the only one with a Linux box
> on a fat pipe looking for maximum throughput...

Tim,

this issue was discussed on the netdev mailing list a few weeks
back.

It's very unfortunate that the web archives of netdev
stopped working several months ago and there now appears
to be no web archive of netdev@oss.sgi.com.

Go to http://oss.sgi.com/projects/netdev/archive/ and
pull down the November and December archives.

The subject was "linux to solaris tcp issues on WAN".

The conclusion was "The problem is also fixed with
2.4.0-test12pre3". Dunno about kernel 2.2 though.


-
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
