Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311684AbSCNRJH>; Thu, 14 Mar 2002 12:09:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311687AbSCNRI6>; Thu, 14 Mar 2002 12:08:58 -0500
Received: from naxos.pdb.sbs.de ([192.109.3.5]:46559 "EHLO naxos.pdb.sbs.de")
	by vger.kernel.org with ESMTP id <S311684AbSCNRIq>;
	Thu, 14 Mar 2002 12:08:46 -0500
Date: Thu, 14 Mar 2002 18:11:42 +0100 (CET)
From: Martin Wilck <Martin.Wilck@fujitsu-siemens.com>
To: Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: IO delay, port 0x80, and BIOS POST codes
Message-ID: <Pine.LNX.4.33.0203141802330.1477-100000@biker.pdb.fsc.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

the BIOS on our machines (Phoenix) uses IO-port 0x80 for storing
POST codes, not only during sytem startup, but also for messages
generated during SMM (system management mode) operation.
I have been told other BIOSs do the same.

Unfortunately we can't read this information because Linux uses
port 80 as "dummy" port for delay operations. (outb_p and friends,
actually there seem to be a more hard-coded references to port
0x80 in the code).

It seems this problem was always there, just nobody took notice of it yet
(at least in our company). Sometimes people wondered about the weird POST
codes displayed in the LCD panel, but who cares once the machine is up...

Would it be too outrageous to ask that this port number be changed, or
made configurable?

Martin

-- 
Martin Wilck                Phone: +49 5251 8 15113
Fujitsu Siemens Computers   Fax:   +49 5251 8 20409
Heinz-Nixdorf-Ring 1	    mailto:Martin.Wilck@Fujitsu-Siemens.com
D-33106 Paderborn           http://www.fujitsu-siemens.com/primergy





