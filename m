Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129401AbQLCDcJ>; Sat, 2 Dec 2000 22:32:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130036AbQLCDcA>; Sat, 2 Dec 2000 22:32:00 -0500
Received: from TSX-PRIME.MIT.EDU ([18.86.0.76]:44690 "HELO tsx-prime.MIT.EDU")
	by vger.kernel.org with SMTP id <S129401AbQLCDbs>;
	Sat, 2 Dec 2000 22:31:48 -0500
Date: Sat, 2 Dec 2000 22:01:12 -0500
Message-Id: <200012030301.WAA17511@tsx-prime.MIT.EDU>
From: "Theodore Y. Ts'o" <tytso@MIT.EDU>
To: Alexander Viro <viro@math.psu.edu>
CC: "Theodore Y. Ts'o" <tytso@MIT.EDU>,
        "Albert D. Cahalan" <acahalan@cs.uml.edu>, david@linux.com,
        linux-kernel@vger.kernel.org, vpnd@sunsite.auc.dk
In-Reply-To: Alexander Viro's message of Sat, 2 Dec 2000 18:34:44 -0500 (EST),
	<Pine.GSO.4.21.0012021830090.28923-100000@weyl.math.psu.edu>
Subject: Re: /dev/random probs in 2.4test(12-pre3)
Phone: (781) 391-3464
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Date: Sat, 2 Dec 2000 18:34:44 -0500 (EST)
   From: Alexander Viro <viro@math.psu.edu>

   Erm... Not that ignoring the return values was a bright idea, but the
   lack of reliable ordered datagram protocol in IP family is not a good
   thing. It can be implemented over TCP, but it's a big overkill. IL is a
   nice thing to have...

You mean RDP (Reliable Data Protocol), RFC-908 and RFC-1151?  It
provides reliable (i.e., will handle retransmission and dropping
duplicate) datagrams with optional sequencing guarantees if requested by
the application (but if you don't need sequencing, you don't have to pay
for it).  It's built on top of IP.  It's specified, but it never become
popular.  But it *is* a member of the IP family, however neglected and
ignored it might be.

						- Ted

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
