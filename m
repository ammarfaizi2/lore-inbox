Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130022AbRAFKWC>; Sat, 6 Jan 2001 05:22:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130133AbRAFKVx>; Sat, 6 Jan 2001 05:21:53 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:25618 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S130022AbRAFKVh>;
	Sat, 6 Jan 2001 05:21:37 -0500
From: Russell King <rmk@arm.linux.org.uk>
Message-Id: <200101060946.f069kbv18455@flint.arm.linux.org.uk>
Subject: Re: Even slower NFS mounting with 2.4.0
To: chris@chrullrich.de (Christian Ullrich)
Date: Sat, 6 Jan 2001 09:46:37 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010106002531.A490@christian.chrullrich.de> from "Christian Ullrich" at Jan 06, 2001 12:25:31 AM
X-Location: london.england.earth.mulky-way.universe
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Ullrich writes:
> About three weeks ago, I complained loudly about very slow NFS mounts
> involving a 2.2.17 server and a 2.2.18 client.
> 
> Today, I complain loudly about *extremely* slow NFS mounts
> with the very same server and the same client now running 2.4.0.

In all cases, you need to either:

1. Provide the option "nolock" to turn of NFS file locking (which means
   that things like elm can't lock mailboxes and will get upset if the
   mailboxes are on a NFS partition).

2. before running the mount command:
   a) make sure the loopback interface is up and running
   b) ensure that the portmapper (called portmap or rpc.portmap) is
      running.
   _____
  |_____| ------------------------------------------------- ---+---+-
  |   |         Russell King        rmk@arm.linux.org.uk      --- ---
  | | | | http://www.arm.linux.org.uk/personal/aboutme.html   /  /  |
  | +-+-+                                                     --- -+-
  /   |               THE developer of ARM Linux              |+| /|\
 /  | | |                                                     ---  |
    +-+-+ -------------------------------------------------  /\\\  |
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
