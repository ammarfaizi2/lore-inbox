Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129595AbQKHTTR>; Wed, 8 Nov 2000 14:19:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129580AbQKHTTH>; Wed, 8 Nov 2000 14:19:07 -0500
Received: from ns.caldera.de ([212.34.180.1]:4365 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S129569AbQKHTSr>;
	Wed, 8 Nov 2000 14:18:47 -0500
Date: Wed, 8 Nov 2000 20:18:40 +0100
From: Marcus Meissner <Marcus.Meissner@caldera.de>
To: linux-kernel@vger.kernel.org
Subject: tcp/ip connections and downed/removed netdevs
Message-ID: <20001108201840.A23731@ns.caldera.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a rather strange problem in regard to routing and tcp/ip connections.

My setup:
	- default route to eth0, metric 2
	- ppp dialin to static ip (ppp0), is another default route, metric 0

I open a telnet connection over the ppp0 interface.

I then down and remove the ppp0 interface (ifconfig -a ppp0 shows 'no such
device'), the default route over ppp0 is gone.

Symptom:
	The telnet connection hangs.

	No packets are transmitted over the still alive eth0 defaultroute.
	tcpdump -i eth0 shows 0 packets, "netstata -a" shows an increasing
	SendQ on the connection.

	If I dialin again, the still hanging packets get transmitted to
	the target.

I am not sure, but should this be?

Shouldn't packets get routed over eth0 in the case an interface vanishes?

Ciao, Marcus
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
