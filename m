Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264469AbTEJTFo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 May 2003 15:05:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264471AbTEJTFo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 May 2003 15:05:44 -0400
Received: from mailhost.cs.tamu.edu ([128.194.130.106]:54154 "EHLO cs.tamu.edu")
	by vger.kernel.org with ESMTP id S264469AbTEJTFn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 May 2003 15:05:43 -0400
Date: Sat, 10 May 2003 14:18:23 -0500 (CDT)
From: Xinwen Fu <xinwenfu@cs.tamu.edu>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: don't use cheap switches under some scenarios
Message-ID: <Pine.GSO.4.44.0305101411001.11628-100000@unix.cs.tamu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, all,
	I asked before why my linksys workgroup 5-port switch worked like
a hub
under heavy traffic (10mb/s) into one socket of the switch. The conclusion
is that the switch has some problem.

	In fact, for the first 5 minutes, it
works like a switch and then it works like a hub. The switching table is
messed up by the intense traffic, we believe. Other cheaper switches
(netgear fast esthernet switch FS108 ) have the same problem. We use a
CentreCom FS708, and then the problem is solved. Of course other expensive
and professional switches should be ok too, we think.

	Just some information.


Xinwen Fu


---------- Forwarded message ----------
Date: Thu, 8 May 2003 22:49:01 -0500 (CDT)
From: Xinwen Fu <xinwenfu@cs.tamu.edu>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linksys workgroup switch works like a hub

It is really weird!

Host_10.1--->10.254_router_1.254--->Linksys 5-port workgroup switch-->Host1.1
                                       |               |
                                       |               |
                                       v               v
                                    Host_1.10        Host_1.5

Host_10.1 sends 1000 packets/s (pps) to Host_1.10. Host_1.10 receives the
packets. But Host_1.5 receives the packets too, while Host_1.1 does not
(by tcpdump -i any).

	What is the possible reason?

	Thanks!
Xinwen Fu



