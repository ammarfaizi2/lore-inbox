Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261695AbVF0UVr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261695AbVF0UVr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 16:21:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261703AbVF0UVn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 16:21:43 -0400
Received: from ccssun1.nrl.navy.mil ([132.250.113.66]:36519 "EHLO
	ccssun1.nrl.navy.mil") by vger.kernel.org with ESMTP
	id S261665AbVF0UTy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 16:19:54 -0400
Date: Mon, 27 Jun 2005 16:19:49 -0400
From: "Tim Strobell \(Contractor\)" <timothy.strobell@nrl.navy.mil>
To: linux-kernel@vger.kernel.org
Subject: no output on serial console between probe and init
Message-ID: <20050627201949.GC955@ccs.nrl.navy.mil>
Reply-To: Tim Strobell <timothy.strobell@nrl.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Prior to 2.6.12, I was experiencing garbage on the serial console as others
have mentioned in this thread:
http://www.uwsg.iu.edu/hypermail/linux/kernel/0503.3/0491.html 
Applying Phil Oester's quick patch 
http://www.uwsg.iu.edu/hypermail/linux/kernel/0503.3/1061.html
indeed removes the garbage but now produces no output until init is started.

The patch that was integrated into 2.6.12 also exhibits the same problem.

Output to the console:

....
PNP: PS/2 controller doesn't have AUX irq; using default 0xc
PNP: PS/2 Controller [PNP0303:KBD] at 0x60,0x64 irq 112
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a NS16550A

< nothing for about a minute; should at least see SCSI init here >

INIT: version 2.86 booting
Activating swap.Adding 2104504k swap on /dev/sda2.  Priority:-1 extents:1
Checking root file system...
.....


This is on a relatively new Dell PowerEdge 1850; all serial output is at 9600
8N1.

Please CC any replies directly to me since I'm not on the list. Thanks!

-Tim

--
Tim Strobell, Sr. Systems Administrator	                       V 202 767 8449
Center for Computational Science, Naval Research Lab           F 202 404 7402
Code 5595 (A49-32), 4555 Overlook Ave SW, Washington DC 20375
