Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu id <970790-3215>; Sat, 9 May 1998 22:17:57 -0400
Received: from zero.aec.at ([193.170.192.102]:9292 "HELO zero.aec.at" ident: "qmaill") by vger.rutgers.edu with SMTP id <970892-3215>; Sat, 9 May 1998 22:17:46 -0400
To: Jan Vicherek <honza@ied.com>
Cc: Marc Lehmann <pcg@goof.com>, linux-kernel@vger.rutgers.edu
Subject: Re: clarification : Re: "renice" netowork usage.
References: <Pine.LNX.3.96.980509205921.5258k-100000@ann.ied.com>
From: Andi Kleen <ak@muc.de>
Date: 10 May 1998 03:22:43 +0200
In-Reply-To: Jan Vicherek's message of Sat, 9 May 1998 22:08:10 -0400 (EDT)
Message-ID: <k21zu22a3g.fsf@zero.aec.at>
X-Mailer: Gnus v5.4.41/Emacs 19.34
Sender: owner-linux-kernel@vger.rutgers.edu

Jan Vicherek <honza@ied.com> writes:
> 
>    My understanding of TCP tells me that "if the line conditions are
> poor", the server adjusts the TCP window size to something smaller. Now
> how the heck would the server knows what kind of line conditions are
> ahead?! It doesn't. So how can it adjust the window side then ? By
> guessing the line conditions from number and latency of ACKs.

Read up on http://ftp.ee.lbl.gov/floyd/cbq.html, and maybe
http://ftp.ee.lbl.gov/floyd/ecn.html too. Linux implements the first 
already, but there is no documentation (yet) and the code is still
rather experimential and rough. Note that the best way to implement
that is not on the end host, but rather on the router before the
bottleneck link. 

If you want a basic explanation of the current TCP congestion
avoidance algorithms read RFC 2001. The current algorithm penalizes 
slow streams over fast streams a bit though.


-Andi

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
