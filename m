Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282131AbRKWMAO>; Fri, 23 Nov 2001 07:00:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282129AbRKWMAE>; Fri, 23 Nov 2001 07:00:04 -0500
Received: from freerunner-o.cendio.se ([193.180.23.130]:51706 "EHLO
	mail.cendio.se") by vger.kernel.org with ESMTP id <S282125AbRKWL7y>;
	Fri, 23 Nov 2001 06:59:54 -0500
Date: Fri, 23 Nov 2001 12:59:52 +0100
Message-Id: <200111231159.MAA24620@akrulino.lkpg.cendio.se>
From: Martin Persson <martin@cendio.se>
To: linux-kernel@vger.kernel.org
Subject: Kernel 2.4.15: Xircom card still bugs.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some days ago I posted a comment about minor(?) problems with Linux on
my IBM ThinkPad 570. Considering 2.4.15 now isn't a pre-release
anymore, I'd say these problems are a tad worrying (must be more
people out there using ThinkPad 570's and/or Xorcom-cards).

Network is flaky for me. When I download files from my laptop with
scp, the download sometimes hangs like this:

testfile            99% |**************************** |  3748 KB  - stalled -

After some kind of time-out (which seems not to be a fix value) the
download is resumed and the whole thing repeats for the next file and
then the next file after that, and so on. Annoying.

I'm using the "Xircom CardBus support (new driver)". When the module
loads, I get this in the log (if it can be of any help):

> Nov 23 12:30:17 cattus pumpd[620]: starting at (uptime 0 days, 0:01:08) Fri Nov 23 12:30:17 2001  
> Nov 23 12:30:17 cattus kernel: Xircom cardbus adaptor found, registering as eth0, using irq 11 
> Nov 23 12:30:17 cattus kernel: xircom_cb: enabling promiscuous mode 
> Nov 23 12:30:17 cattus kernel: xircom_cb: capabilities changed from 0x1e1 to 0xa1
> Nov 23 12:30:17 cattus kernel: xircom_cb: Link is absent 
> Nov 23 12:30:17 cattus kernel: spurious 8259A interrupt: IRQ7.
> Nov 23 12:30:19 cattus kernel: xircom_cb: Link is 100 mbit 
> Nov 23 12:30:21 cattus kernel: Xircom cardbus adaptor found, registering as eth0, using irq 11 
> Nov 23 12:30:21 cattus kernel: xircom_cb: enabling promiscuous mode 
> Nov 23 12:30:21 cattus kernel: xircom_cb: capabilities changed from 0xa1 to 0xa1
> Nov 23 12:30:21 cattus kernel: xircom_cb: Link is absent 
> Nov 23 12:30:21 cattus pumpd[620]: configured interface eth0
> Nov 23 12:30:23 cattus kernel: xircom_cb: Link is 100 mbit 

The second capability change is rather amusing, I would say. ;>

With the old driver ("Xircom Tulip-like CardBus support") I initially
get the happy tone-sad tone response, but after ejecting and inserting
the card, I have no time-outs like that above and the download flows
smoothly.

Although I know some about kernel driver coding, network has never
been my cup of tea and I'm utterly lost in those parts of the driver.
I will, however, of course try to do as mych as I can if someone wants
to help me sort out this problem.

And, as before, the laptop seem not able to shut off the power despite
I have APM compiled in and despite the power goes out just nicely when
I shut Windows down.

/Martin,
