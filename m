Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261783AbTICKiF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 06:38:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261835AbTICKiE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 06:38:04 -0400
Received: from brains.student.utwente.nl ([130.89.161.140]:33667 "EHLO
	brains.student.utwente.nl") by vger.kernel.org with ESMTP
	id S261783AbTICKiC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 06:38:02 -0400
Subject: 2.6 - Kernel panic with GRE tunneling
From: Justin Ossevoort <iq-0@brains.student.utwente.nl>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1062585476.9134.39.camel@pulse>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Wed, 03 Sep 2003 12:37:57 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I encountered some kernel bug in the ip_gre module. This problem has
been tested on: 2.6.0-test3, 2.6.0-test4-mm2, 2.6.0-test4-mm4 (In VMWare
to get stacktrace).

All kernels were build with gcc 3.3 (the latest with 3.3.2 20030831
Debian prerelease). Tested on 2 systems (one was a VMWare), both running
Debian Sid.

this is what I did:

modprobe ip_gre
ip tunnel add test mode gre remote 10.2.0.1 local 10.2.248.255
ip link set test up
ip addr add 192.168.0.1 dev test
ip route add 192.168.0.2/32 dev test
ping 192.168.0.2
***crash***

In order to limit the e-mail's size:
http://brains.student.utwente.nl/~iq-0/ipgre-2.6-panic/
there are the paniclog, an attempt to run it through ksymoops and a
tcpdump.

*note: In this test case I didn't set up the other end-point of the
tunnel (because the other system is also 2.6 ;), but on a real life
tunnel the same thing happened. But one doesn't liketo crash his/her
system more than 10 times a week...

Regards,

justin....


