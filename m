Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <157037-25208>; Fri, 5 Mar 1999 01:51:25 -0500
Received: by vger.rutgers.edu id <156510-25208>; Fri, 5 Mar 1999 01:51:06 -0500
Received: from rrzs2.rz.uni-regensburg.de ([132.199.1.2]:59448 "EHLO rrzs2.rz.uni-regensburg.de" ident: "NO-IDENT-SERVICE[2]") by vger.rutgers.edu with ESMTP id <156814-25206>; Fri, 5 Mar 1999 01:50:11 -0500
From: "Ulrich Windl" <ulrich.windl@rz.uni-regensburg.de>
Organization: Universitaet Regensburg, Klinikum
To: linux-kernel@vger.rutgers.edu
Date: Fri, 5 Mar 1999 09:06:02 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: 2.2.1 (possibly others as well): loosing 2 ticks even under light load
X-mailer: Pegasus Mail for Windows (v3.01b)
Message-ID: <CAA9E4E3E90@rkdvmks1.ngate.uni-regensburg.de>
Sender: owner-linux-kernel@vger.rutgers.edu

Hello, a notifier:

For debugging purposes I added a print statement to show lost ticks 
in the i386 kernel. On my Pentium 100 even for very light load the 
kernel declares having lost 2 ticks.

I don't know why this happend, but I see a problem: If the kernel 
looses 2 ticks on a light load, it might loose more ticks on heavy 
load. Unfortunately the non-TSC version of the timeoffset routine 
(using the timer chip's register) can only span one tick, possibly 
guessing that there's more than one, but not more.

Therefore losing over 1 tick might cause a bad time.

I have no idea how to find the parts that disable interrupts for that 
long...

Regards,
Ulrich


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
