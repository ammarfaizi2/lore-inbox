Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129853AbQKEUWQ>; Sun, 5 Nov 2000 15:22:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129988AbQKEUWG>; Sun, 5 Nov 2000 15:22:06 -0500
Received: from twinlark.arctic.org ([204.107.140.52]:21516 "HELO
	twinlark.arctic.org") by vger.kernel.org with SMTP
	id <S129853AbQKEUVz>; Sun, 5 Nov 2000 15:21:55 -0500
Date: Sun, 5 Nov 2000 12:21:54 -0800 (PST)
From: dean gaudet <dean-list-linux-kernel@arctic.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: Negative scalability by removal of
In-Reply-To: <E13s0y9-0004TB-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.21.0011051219030.22526-100000@twinlark.arctic.org>
X-comment: visit http://arctic.org/~dean/legal for information regarding copyright and disclaimer.
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

the numbers didn't look that bad for the small numbers of concurrent
clients on 2.2... a few % slower without the serialisation.  compared to
orders of magnitude slower with large numbers of concurrent client.

oh, someone reminded me of the other reason sysvsems suck:  a cgi can grab
the semaphore and hold it, causing a DoS.  of course folks could, and
should use suexec/cgiwrap to avoid this.

-dean

On Sat, 4 Nov 2000, Alan Cox wrote:

> > Even 2.2.x can be fixed to do the wake-one for accept(), if required. 
> 
> Do we really want to retrofit wake_one to 2.2. I know Im not terribly keen to
> try and backport all the mechanism. I think for 2.2 using the semaphore is a 
> good approach. Its a hack to fix an old OS kernel. For 2.4 its not needed
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
> 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
