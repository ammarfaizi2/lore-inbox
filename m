Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129886AbRALV4o>; Fri, 12 Jan 2001 16:56:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130673AbRALV4X>; Fri, 12 Jan 2001 16:56:23 -0500
Received: from ns1.megapath.net ([216.200.176.4]:1284 "EHLO megapathdsl.net")
	by vger.kernel.org with ESMTP id <S129792AbRALV4O>;
	Fri, 12 Jan 2001 16:56:14 -0500
Message-ID: <3A5F7D2E.87BFC9B@megapathdsl.net>
Date: Fri, 12 Jan 2001 13:54:54 -0800
From: Miles Lane <miles@megapathdsl.net>
Reply-To: miles@megapathdsl.net
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.1-pre3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Shawn Starr <Shawn.Starr@Home.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PROBLEM]: Strange network problems with 2.4.0 and 3c59x.o
In-Reply-To: <Pine.LNX.4.10.10101020019010.8957-100000@vaio.greennet> <3A51D40F.48B9ADB9@home.net> <3A5F791F.BCC236C1@Home.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Make sure your kernel build .config file contains the line:

	# CONFIG_INET_ECN is not set

not

	CONFIG_INET_ECN=y

Here's what the kernel configuration help has to say:

  Explicit Congestion Notification (ECN) allows routers to notify
  clients about network congestion, resulting in fewer dropped packets
  and increased network performance. This option adds ECN support to the
  Linux kernel, as well as a sysctl (/proc/sys/net/ipv4/tcp_ecn) which
  allows ECN support to be disabled at runtime.

  Note that, on the Internet, there are many broken firewalls which
  refuse connections from ECN-enabled machines, and it may be a while
  before these firewalls are fixed. Until then, to access a site behind
  such a firewall (some of which are major sites, at the time of this
  writing) you will have to disable this option, either by saying N now
  or by using the sysctl.


Shawn Starr wrote:
> 
> Here's something strange that i've been noticing with 2.4.0. Some websites I am
> unable to access now. For example:
> 
> http://www.scotiabank.ca/simplify/index.html

<snip>
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
