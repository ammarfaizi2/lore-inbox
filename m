Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261796AbTKPE14 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Nov 2003 23:27:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261873AbTKPE14
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Nov 2003 23:27:56 -0500
Received: from mx2.arach.net.au ([203.30.44.68]:4760 "HELO mx2.arach.net.au")
	by vger.kernel.org with SMTP id S261796AbTKPE1y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Nov 2003 23:27:54 -0500
Message-Id: <6.0.0.22.0.20031116121700.01cc0da0@mail.arach.net.au>
X-Mailer: QUALCOMM Windows Eudora Version 6.0.0.22
Date: Sun, 16 Nov 2003 12:27:32 +0800
To: linux-kernel@vger.kernel.org
From: Radix <Radix@juga.org>
Subject: Hisax/Orinoco_cs networking conflicts in 2.4.21+
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

I have an odd problem, and not one I can pinpoint by myself.

I have a gateway machine that I use for both wireless freenet and isdn DOV 
internet connectivity.
The wireless card is a cabletron roamabout, running orinoco_cs 0.13e, 
connected through an ISA-PCMCIA connector and the isdn card is a NetJet-S 
pci card using the hisax driver.
It was running the 2.4.20 kernel previously, and worked a 
treat.  Everything worked fine and that was the first kernel release with 
isdn DOV support.

When I tried compiling the 2.4.21 and 2.4.22 kernels though, I noticed 
something odd.  Whenever my wireless traffic went up, the speed of my isdn 
dropped significantly.
More than say 100kB/s worth of wireless traffic, and my isdn downloads - 
which were sitting on 8kB/s solid for a while were suddenly dropped down to 
0.1kB/s.  The same doesn't hold true for the reverse (or doesn't seem 
to).  Also note that while wireless downloads stomp isdn downloads - upload 
traffic remains unaffected.

Now at the time, I passed this off a bit.. figured I must have done 
something odd in creating my kernel - perhaps ticked some load balancing 
box somewhere.  I'd also checked the I/O and IRQ's to make sure there were 
no conflicts and couldn't find any reason for it (was using the same kernel 
config as 2.4.20 too).  Then I'd given up and gone back to the working 
2.4.20 kernel.

The other day I decided to update the box and I installed the latest 
Knoppix 3.3 (Nov03) on it (using their nifty install to hdd feature to get 
a nice debian setup) - and what should surface again with the default 
2.4.22-xfs kernel is this issue with wireless stomping isdn traffic.

I've tried switching hardware (except the pcmcia/isdn card) - and occurs 
from a 466 celeron to a 1ghz athlon and also tried moving pci slots, etc.

Short of building a 2.4.20 kernel to use I have no solution at present - so 
anything you can suggest is welcome.  Can provide dmesg/more detailed info 
on request.

Regards,

Radix


