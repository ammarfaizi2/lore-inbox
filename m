Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132148AbRAVU77>; Mon, 22 Jan 2001 15:59:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133095AbRAVU7t>; Mon, 22 Jan 2001 15:59:49 -0500
Received: from tech1.nameservers.com ([216.46.160.19]:37906 "EHLO
	tech1.nameservers.com") by vger.kernel.org with ESMTP
	id <S132148AbRAVU7o>; Mon, 22 Jan 2001 15:59:44 -0500
Message-Id: <200101222059.MAA04984@tech1.nameservers.com>
To: linux-kernel@vger.kernel.org
Subject: Turning off ARP in linux-2.4.0
Date: Mon, 22 Jan 2001 12:59:43 -0800
From: Pete Elton <elton@iqs.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have searched the previous posts and have not found a solution to 
the problem that I am facing.

The short problem is that I need a way to turn off arping for the lo 
interface in the 2.4.0 kernel.

In the 2.2 kernel, I could do the following:
echo 1 > /proc/sys/net/ipv4/conf/all/hidden 
echo 1 > /proc/sys/net/ipv4/conf/lo/hidden 

The 2.4 kernel does not have these sysctl files any more.  Why was
this functionality taken out?  or was it simply moved to another place
in the proc filesystem?  How can I accomplish the same thing I was
doing in the 2.2 kernel in the 2.4 kernel?  

Now for the long version of the problem.  I am using the TurboLinux 
ClusterServer 6.0 product.  This product uses what they refer to as
an advanced traffic manager that has the ip address of the web site
aliased to eth0.  Thus this machine arps for the ip address and when it
gets the http requests, it passes those requests to the nodes which have
the same ip addressed aliased to their lo interface with arping turned off.

TurboLinux is not helping me with the 2.4 kernel.  I imagine it is because
they know nothing about it and were not planning ahead by following the 
development of the 2.3 kernel, so I thought I would ask the guys who really
know what is going on.

I know that you are all very busy, but any help that you can provide
is greatly appreciated.

Pete Elton

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
