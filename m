Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <157671-8093>; Sun, 17 Jan 1999 22:30:07 -0500
Received: by vger.rutgers.edu id <157661-8100>; Sun, 17 Jan 1999 22:29:56 -0500
Received: from [204.193.135.230] ([204.193.135.230]:12395 "EHLO linux42.dn.net" ident: "NO-IDENT-SERVICE[2]") by vger.rutgers.edu with ESMTP id <157651-8100>; Sun, 17 Jan 1999 22:29:44 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <13986.43678.718410.351098@wander.auton.org>
Date: Sun, 17 Jan 1999 22:29:34 -0500 (EST)
To: linux-kernel@vger.rutgers.edu
From: lk@winux.com
Subject: TCP Splice alleviates proxy bottleneck
X-Mailer: VM 6.62 under 21.2 "Aglaia" XEmacs Lucid (beta3)
Sender: owner-linux-kernel@vger.rutgers.edu

Anyone who's interested in high performance network development on
Linux should take a look at what these folks are doing.  It seems to
be a very clever way to eliminate the drudge work that an application
level proxy performs without significant impact on the application
code.  Looks like a great performance booster.  Very nice.  The paper
says that this is all running on BSDI.  Wish they'd picked Linux.. :-)

     Application Layer Proxy Performance Using TCP Splice. 
     David Maltz, Pravin Bhagwat. IBM Technical Report RC-21139, March
     1998. (submitted for publication).

           TCP Splicing for Application Layer Proxy Performance

                         David Maltz, Pravin Bhagwat

     Application layer proxies already play an important role in today's
     networks, serving as firewalls and HTTP caches --- and their role is
     being expanded to include encryption, compression, and mobility
     support services.  Current application layer proxies suffer major
     performance penalties as they spend most of their time moving data
     back and forth between connections; context switching and crossing
     protection boundaries for each chunk of data they handle.  We present
     a technique called TCP Splice that provides kernel support for data
     relaying operations which runs at near router speeds.  In our lab
     testing, we find SOCKS firewalls using TCP Splice can sustain a data
     throughput twice that of normal firewalls, with an average packet
     forwarding latency 30 times less.
     
     http://www.cs.umd.edu/users/pravin/TR-21139.ps.gz

Here are some other publications by one of the authors:

     http://www.cs.umd.edu/users/pravin/publist.htm

The MSOCKS paper also discusses TCP Splice.

-lda

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
