Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262518AbSI0P6y>; Fri, 27 Sep 2002 11:58:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262514AbSI0P6x>; Fri, 27 Sep 2002 11:58:53 -0400
Received: from sopris.net ([216.237.72.68]:61195 "EHLO mail.sopris.net")
	by vger.kernel.org with ESMTP id <S262518AbSI0P6w>;
	Fri, 27 Sep 2002 11:58:52 -0400
Message-ID: <001901c2663f$a1125060$f101010a@nathan>
From: "Nathan" <etherwolf@sopris.net>
To: "Linux Kernel List" <linux-kernel@vger.kernel.org>
Subject: PING: Failed to install socket filter after kernel update
Date: Fri, 27 Sep 2002 10:04:58 -0600
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Okay I finally made it through my kernel recompile with iptables 1.2.7a in
there, and it seems to be working (I can do a #iptables -L and it lists my
default chains) but there's about a 10-second delay with anything
network-related now. When I ssh to the box, it used to come up immediately,
now there's the delay. When I lynx to a site, delay. When I ping, I get
useful info, then a delay.

The is the output of a simple ping apple.com:

PING apple.com (17.254.3.183) from 10.1.1.8 : 56(84) bytes of data.
WARNING: failed to install socket filter
: Protocol not available
64 bytes from apple.com (17.254.3.183): icmp_seq=1 ttl=51 time=49.8 ms
64 bytes from apple.com (17.254.3.183): icmp_seq=2 ttl=51 time=50.5 ms
64 bytes from apple.com (17.254.3.183): icmp_seq=3 ttl=51 time=56.7 ms
64 bytes from apple.com (17.254.3.183): icmp_seq=4 ttl=51 time=58.8 ms

--- apple.com ping statistics ---
4 packets transmitted, 4 received, 0% loss, time 15398ms
rtt min/avg/max/mdev = 49.835/53.987/58.830/3.877 ms


Notice the time 15398ms... It comes up after a couple seconds with the
WARNING, then delays about 5 seconds, then spits out the ping info slowly,
even though the return times may be under 10ms.

So what's up with the failing to install socket filter stuff? What did I do
to my kernel? :-)

Machine info: RH 7.3 on a Dell PE 350, with a newly compiled 2.4.19 kernel
and compiled iptables 1.2.7a (tried 1.2.6a with same results). I have
completely removed ipchains.

If anyone wants to see my kernel config file, or some of the flags from it,
lemme know.

Thanks!!
# Nathan

