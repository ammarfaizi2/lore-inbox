Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129034AbQKFFdP>; Mon, 6 Nov 2000 00:33:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129036AbQKFFdF>; Mon, 6 Nov 2000 00:33:05 -0500
Received: from mailout06.sul.t-online.com ([194.25.134.19]:39946 "EHLO
	mailout06.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S129034AbQKFFcz>; Mon, 6 Nov 2000 00:32:55 -0500
Message-ID: <3A064279.30960692@egu.schule.ulm.de>
Date: Mon, 06 Nov 2000 06:32:41 +0100
From: Steffen Moser <moser@egu.schule.ulm.de>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test10 i586)
X-Accept-Language: de, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: "ip_dynaddr" broken in 2.4.0-test10
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have configured, compiled and installed "linux-2.4.0-test10" on my
SuSE Linux 6.3 machine. After doing some necessary updates the system
works quite fine now. But there is one thing which makes still some
problems: "ip_dynaddr" seems not to work anymore. 

I use an ISDN connection (dial on demand) to my ISP (that assigns me a
dynamic IP address when dialling up), so I should make use of
"ip_dynaddr" to prevent the first packet from being lost. Running
"linux-2.2.17" (or any other "2.2.X") this worked without any problems:
as soon as the connection is established the source address of the first
packet is shifted to the officially assigned address. 

But this seems not to work with "linux-2.4.0-test10": I don't get
response to a packet which was sent before the connection was
established, i.e. if I try -for example- to establish an
"ssh"-connection to a machine when I am "off-line", my machine starts to
dial up, but the "ssh"-connection times out, so I have to interrupt
"ssh" and start it again after the ISDN connection is established,
because the first packet always gets lost.

The "ip_dynaddr" is activated:

  steffen@pc01:~ > cat /proc/sys/net/ipv4/ip_dynaddr 
  1
  steffen@pc01:~ > 


Does anybody have the same problem? Is it a bug of "2.4.0-test10" or is
it the result of missing updates of userspace programmes?

Regards,
Steffen
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
