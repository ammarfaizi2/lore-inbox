Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132207AbRAaAze>; Tue, 30 Jan 2001 19:55:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132093AbRAaAzY>; Tue, 30 Jan 2001 19:55:24 -0500
Received: from shell.cyberus.ca ([209.195.95.7]:43191 "EHLO shell.cyberus.ca")
	by vger.kernel.org with ESMTP id <S132295AbRAaAzO>;
	Tue, 30 Jan 2001 19:55:14 -0500
Date: Tue, 30 Jan 2001 19:53:59 -0500 (EST)
From: jamal <hadi@cyberus.ca>
To: Ion Badulescu <ionut@cs.columbia.edu>
cc: Andrew Morton <andrewm@uow.edu.au>, lkml <linux-kernel@vger.kernel.org>,
        "netdev@oss.sgi.com" <netdev@oss.sgi.com>
Subject: Still not sexy! (Re: sendfile+zerocopy: fairly sexy (nothing to do
 with ECN)
In-Reply-To: <Pine.LNX.4.30.0101291924140.31713-100000@age.cs.columbia.edu>
Message-ID: <Pine.GSO.4.30.0101301944181.3017-100000@shell.cyberus.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 29 Jan 2001, Ion Badulescu wrote:

> On Mon, 29 Jan 2001, jamal wrote:
>
> > > 11.5kBps, quite consistently.
> >
> > This gige card is really sick. Are you sure? Please double check.
>
> Umm.. the starfire chipset is 100Mbit only. So 11.5MBps (sorry, that was a
> typo, it's mega not kilo) is really all I'd expect out of it.
>

not good.

So far all the tests have been around CPU. The general trend seems
to be:
- sendfile + ZC good for CPU
- write() + ZC not good for CPU
(i might have forgotten something from Andrew's results).
This happens (even with my bogus cpu measure) to be similar.
That seems to be explainable.

** I reported that there was also an oddity in throughput values,
unfortunately since no one (other than me) seems to have access
to a gige cards in the ZC list, nobody can confirm or disprove
what i posted. Here again as a reminder:

Kernel     |  tput  | sender-CPU | receiver-CPU |
-------------------------------------------------
2.4.0-pre3 | 99MB/s |   87%      |  23%         |
NSF        |        |            |              |
-------------------------------------------------
2.4.0-pre3 | 86MB/s |   100%     |  17%         |
SF         |        |            |              |
-------------------------------------------------
2.4.0-pre3 | 66.2   |   60%      |  11%         |
+ZC        | MB/s   |            |              |
-------------------------------------------------
2.4.0-pre3 | 68     |   8%       |  8%          |
+ZC  SF    | MB/s   |            |              |
-------------------------------------------------


Just ignore the CPU readings, focus on throughput. And could someone plese
post results?

cheers,
jamal



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
