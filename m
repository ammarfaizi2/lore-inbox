Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282625AbRK0TFp>; Tue, 27 Nov 2001 14:05:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282598AbRK0TFf>; Tue, 27 Nov 2001 14:05:35 -0500
Received: from bagel.indexdata.dk ([212.242.69.115]:40113 "EHLO
	bagel.indexdata.dk") by vger.kernel.org with ESMTP
	id <S282625AbRK0TFY>; Tue, 27 Nov 2001 14:05:24 -0500
Date: Tue, 27 Nov 2001 20:05:22 +0100
From: Heikki Levanto <heikki@indexdata.dk>
To: linux-kernel@vger.kernel.org
Subject: 2.4.16: "Address family not supported" on RH IBM T23
Message-ID: <20011127200522.B27480@indexdata.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tried to compile 2.4.16 on my brand new IBM T23. 

Small problem: Kernel panic at start, null pointer reference when
initializing agp code. Disabled agp, and boots OK. Probably too new
motherboard? Should I report what details?


Large problem: Network won't come up. Says:
> Cannot open netlink socket: Address family not supported by protocol

This happens both to lo and eth0, with a stock kernel, only option I changed
was the agp (see above).  Can boot past this, but no networking configured.

Invoking ifup by hand causes same behaviour. 

Manually running ifconfig lo 127.0.0.1 and ifconfig lo up work. Same for
eth0.

More digging pointed me to redhat's ifup script (7.2 with latest updates),
in the function is_available, there is a line that tests 'ip -o link'. This
is what gives the error messages in ifup (as well as when run by hand).
Could not find much documentation for that /sbin/ip, redhat special?

Problem does not occur on redhat 7.2 default kernel 2.4.7-10, nor on the one
their thing upgraded my box to, 2.4.9-13 

Does this indicate a kernel problem, redhat problem, or my problem?


Thank you in advance

	Heikki Levanto


P.S. I try to follow the list, but would still appreciate a direct cc if you
have any comments, suggestions, or workarounds.


-- 
Heikki Levanto            heikki@indexdata.dk            "In Murphy We Turst"
