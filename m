Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132123AbRAaBGF>; Tue, 30 Jan 2001 20:06:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132268AbRAaBFz>; Tue, 30 Jan 2001 20:05:55 -0500
Received: from shell.cyberus.ca ([209.195.95.7]:44983 "EHLO shell.cyberus.ca")
	by vger.kernel.org with ESMTP id <S132123AbRAaBFo>;
	Tue, 30 Jan 2001 20:05:44 -0500
Date: Tue, 30 Jan 2001 20:04:51 -0500 (EST)
From: jamal <hadi@cyberus.ca>
To: Ingo Molnar <mingo@elte.hu>
cc: Ion Badulescu <ionut@cs.columbia.edu>, Andrew Morton <andrewm@uow.edu.au>,
        lkml <linux-kernel@vger.kernel.org>,
        "netdev@oss.sgi.com" <netdev@oss.sgi.com>
Subject: Re: Still not sexy! (Re: sendfile+zerocopy: fairly sexy (nothing to
 do with ECN)
In-Reply-To: <Pine.LNX.4.30.0101310156380.13299-100000@elte.hu>
Message-ID: <Pine.GSO.4.30.0101302000471.3017-100000@shell.cyberus.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 31 Jan 2001, Ingo Molnar wrote:

>
> On Tue, 30 Jan 2001, jamal wrote:
>
> > Kernel     |  tput  | sender-CPU | receiver-CPU |
> > -------------------------------------------------
> > 2.4.0-pre3 | 99MB/s |   87%      |  23%         |
> > NSF        |        |            |              |
> > -------------------------------------------------
> > 2.4.0-pre3 | 68     |   8%       |  8%          |
> > +ZC  SF    | MB/s   |            |              |
> > -------------------------------------------------
>
> isnt the CPU utilization difference amazing? :-)
>

With a caveat, sadly ;-> ttcp uses times() system call (or a diff of
times() one at the beggining and another at the end). So the cpu
measurements are not reflective.

> a couple of questions:
>
> - is this UDP or TCP based? (UDP i guess)
>
TCP

> - what wsize/rsize are you using? How do these requests look like on the
>   network, ie. are they suffieciently MTU-sized?

yes. writes vary from 8K->64K but not much difference over the long period
of time.

>
> - what happens if you run multiple instances of the testcode, does it
>   saturate bandwidth (or CPU)?

This is something of great interest. I havent tried it. I should.
I suspect this would be where the value of the ZC changes will become
evident.

cheers,
jamal

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
