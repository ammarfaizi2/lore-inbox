Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136156AbRAHAjB>; Sun, 7 Jan 2001 19:39:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136254AbRAHAiu>; Sun, 7 Jan 2001 19:38:50 -0500
Received: from dorf.wh.uni-dortmund.de ([129.217.255.136]:51730 "HELO
	mail.dorf.wh.uni-dortmund.de") by vger.kernel.org with SMTP
	id <S136079AbRAHAii>; Sun, 7 Jan 2001 19:38:38 -0500
Date: Mon, 8 Jan 2001 01:38:12 +0100
From: Patrick Mau <mau@oscar.prima.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Paket counters for aliased interfaces ?
Message-ID: <20010108013812.A17385@oscar.dorf.wh.uni-dortmund.de>
Reply-To: Patrick Mau <mau@oscar.prima.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I would like to use IP-Aliasing to create a private network
between a few machines without buying more hardware. That's
easy, but ifconfig tells me:

eth0      Link encap:Ethernet  HWaddr xx:xx:xx:xx:xx:xx
          inet addr:x.x.x.x  Bcast:x.x.x.x  Mask:x.x.x.x
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:126810 errors:0 dropped:0 overruns:0 frame:1426
          TX packets:49286 errors:0 dropped:0 overruns:0 carrier:0
          collisions:15942 txqueuelen:100
          Interrupt:17

eth0:0    Link encap:Ethernet  HWaddr xx:xx:xx:xx:xx:xx
          inet addr:10.1.1.1  Bcast:10.1.1.255  Mask:255.255.255.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          Interrupt:17

And here's the question:
I would like to collect statistics for eth0:0 but obviously the
pakets are only counted for the real interface. If I had enough time
and knowledge, how should I implement paket counters for aliased
interfaces ?

PS: Am I right that it isn't possible ? tcpdump doesn't 'work right'
    either.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
