Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131858AbRAaBAe>; Tue, 30 Jan 2001 20:00:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132123AbRAaBAZ>; Tue, 30 Jan 2001 20:00:25 -0500
Received: from chiara.elte.hu ([157.181.150.200]:49157 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S131858AbRAaBAN>;
	Tue, 30 Jan 2001 20:00:13 -0500
Date: Wed, 31 Jan 2001 01:59:38 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: jamal <hadi@cyberus.ca>
Cc: Ion Badulescu <ionut@cs.columbia.edu>, Andrew Morton <andrewm@uow.edu.au>,
        lkml <linux-kernel@vger.kernel.org>,
        "netdev@oss.sgi.com" <netdev@oss.sgi.com>
Subject: Re: Still not sexy! (Re: sendfile+zerocopy: fairly sexy (nothing to
 do with ECN)
In-Reply-To: <Pine.GSO.4.30.0101301944181.3017-100000@shell.cyberus.ca>
Message-ID: <Pine.LNX.4.30.0101310156380.13299-100000@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 30 Jan 2001, jamal wrote:

> Kernel     |  tput  | sender-CPU | receiver-CPU |
> -------------------------------------------------
> 2.4.0-pre3 | 99MB/s |   87%      |  23%         |
> NSF        |        |            |              |
> -------------------------------------------------
> 2.4.0-pre3 | 68     |   8%       |  8%          |
> +ZC  SF    | MB/s   |            |              |
> -------------------------------------------------

isnt the CPU utilization difference amazing? :-)

a couple of questions:

- is this UDP or TCP based? (UDP i guess)

- what wsize/rsize are you using? How do these requests look like on the
  network, ie. are they suffieciently MTU-sized?

- what happens if you run multiple instances of the testcode, does it
  saturate bandwidth (or CPU)?

	Ingo


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
