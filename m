Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131165AbRAIPan>; Tue, 9 Jan 2001 10:30:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131574AbRAIPad>; Tue, 9 Jan 2001 10:30:33 -0500
Received: from smtpgw.bnl.gov ([130.199.3.16]:60946 "EHLO smtpgw.sec.bnl.local")
	by vger.kernel.org with ESMTP id <S131464AbRAIPa0>;
	Tue, 9 Jan 2001 10:30:26 -0500
Date: Tue, 9 Jan 2001 10:29:38 -0500
From: Tim Sailer <sailer@bnl.gov>
To: "Craig I. Hagan" <hagan@cih.com>
Cc: Andrew Morton <andrewm@uow.edu.au>, linux-kernel@vger.kernel.org,
        jfung@bnl.gov
Subject: Re: Network Performance?
Message-ID: <20010109102938.B28548@bnl.gov>
In-Reply-To: <20010108090644.A12440@bnl.gov> <Pine.LNX.4.20.0101081324430.30022-100000@www.cih.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <Pine.LNX.4.20.0101081324430.30022-100000@www.cih.com>; from hagan@cih.com on Mon, Jan 08, 2001 at 01:40:57PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 08, 2001 at 01:40:57PM -0500, Craig I. Hagan wrote:
> > 101 packets transmitted, 101 packets received, 0% packet loss
> > round-trip min/avg/max = 109.6/110.3/112.2 ms
> > 
> > > Does the problem occur in both directions?
> > 
> > Good question. I'll find out.
> > 
> > > Are you _sure_ the window size is being set correctly? How
> > > is it being set?
> > 
> > I'm fairly sure. We echo the value to the file. catting it back
> > shows the correct value. If we go lower than default, it slows
> > down even more.
> 
> what are you setting it to on the solaris machine? what window
> sizes have you tried?
> 
> Your pipe looks like it will have quite a few bits in flight due to its

Yup. That's why the tuning. WAN performance here is very important.

> latency. From my quick guess math, which sucks, it appears that you can fit 1.2
> to 1.5 megabytes on the wire (100mbit machine<-> machine) times 100-120ms wire

Hmm. 100/8 is about 12, no? 

> time. This is a rather large number, so you may want to see what hosts really
> support, perhaps starting with 64k or 128k and work up. Make sure that you have
> window scaling turned on if you go with very large windows.

Yes, we have that enabled too.

> Also, have you upped your socket buffers to match your window sizes?

We are using straight ftp for the testing.

> Last, solaris tends to have poorly tuned tcp values out of the box, look at
> this link and tune the solaris stack to better reflect reality.
> http://www.google.com/search?q=cache:www.rvs.uni-hannover.de/people/voeckler/tune/EN/tune.html+%2Bwan+%2Bwindow+%2Bscale+%2Bsize+%2Bnetwork&hl=en
> 
> linux tuning has a decent amount of data in the docs section of the kernel
> sources.

I'll take a look. THanks.

Tim

-- 
Tim Sailer <sailer@bnl.gov> Cyber Security Operations
Brookhaven National Laboratory  (631) 344-3001
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
