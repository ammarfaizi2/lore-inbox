Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu id <154325-19799>; Sat, 8 Aug 1998 12:45:42 -0400
Received: from zero.aec.at ([195.3.98.22]:27178 "HELO zero.aec.at" ident: "qmailr") by vger.rutgers.edu with SMTP id <154407-19799>; Sat, 8 Aug 1998 11:26:58 -0400
To: alan@lxorguk.ukuu.org.uk (Alan Cox)
Cc: taral@mail.utexas.edu (Taral), rubini@pop.systemy.it, linux-kernel@vger.rutgers.edu
Subject: Re: rshaper-1.01, for linux-2.0
References: <m0z56qq-000aNFC@the-village.bc.nu>
From: Andi Kleen <ak@muc.de>
Date: 08 Aug 1998 16:56:13 +0200
In-Reply-To: alan@lxorguk.ukuu.org.uk's message of Sat, 8 Aug 1998 12:07:55 +0100 (BST)
Message-ID: <k27m0j5xpu.fsf@zero.aec.at>
X-Mailer: Gnus v5.4.41/Emacs 20.2
Sender: owner-linux-kernel@vger.rutgers.edu

alan@lxorguk.ukuu.org.uk (Alan Cox) writes:

> > Actually, if you're clever with the window, you can limit incoming traffic.
> 
> Try playing with the window on a UDP session, on a header with IP-AH or
> IP-ESP present etc. There are fudged ways of emulating receive flow control
> for tcp - both fiddling with the packets to fake window sizes (dangerous)
> or dropping some acks (running a model on the receive side to see which frames
> didnt logically make it through) but nothing will keep the flow right on
> the receive side the moment someone uses something like NFS or realaudio
> over it

If Real Audio uses some congestion avoidance algorithm it should be 
possible to model the conditions that get the sender to slow down.
SunRPC/NFS uses congestion avoidance so it is possible. One possible
way would be too simply do the shaping for incoming traffic and wait
until congestion avoidance on the sender kicks in.

Some links for TCP rate control are at http://www.packeteer.com/tcprate/

-Andi

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.altern.org/andrebalsa/doc/lkml-faq.html
