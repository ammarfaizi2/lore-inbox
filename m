Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264802AbRF1WbB>; Thu, 28 Jun 2001 18:31:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264800AbRF1Wa5>; Thu, 28 Jun 2001 18:30:57 -0400
Received: from petrus.schuldei.org ([195.84.105.112]:43187 "HELO
	petrus.schuldei.org") by vger.kernel.org with SMTP
	id <S264794AbRF1WaL>; Thu, 28 Jun 2001 18:30:11 -0400
Date: Fri, 29 Jun 2001 00:39:00 +0200
From: Andreas Schuldei <andreas@schuldei.org>
To: linux-kernel@vger.kernel.org
Subject: artificial latency for a network interface
Message-ID: <20010629003900.A6065@sigrid.schuldei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

to simulate a sattelite link, I need to add a latency to a
network connection. 

What is the easiest and best way to do that?

I wanted to do that using two tun devices. 
I had hoped to have a routing like this:

 <-> eth0 <-> tun0 <-> userspace, waiting queue <-> tun1 <-> eth1

I need to do it this way and not with iptables help, because it
needs to work also on 2.2.x kernels.

Now I started experimenting with the tun0 interfaces and got
problems: till now I have not succeeded to get a tun0 interface
up. the example code (br_select.c) in the package (as found for
example on sourceforge) looks fishy and does not work too well. 
is it correct that only one /dev/tun file is necessary, but
/dev/tun0 and tun1 are opend for reading and writing?

I also did not manage to point any routes at tun0 or tun1. thoes
interfaces do not show up in the /proc/net/dev either.

only the module is loaded.

I seem to miss something. who has used those devices before and
got them working and could help me debug this?
