Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129392AbQKJMAz>; Fri, 10 Nov 2000 07:00:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129419AbQKJMAp>; Fri, 10 Nov 2000 07:00:45 -0500
Received: from pizda.ninka.net ([216.101.162.242]:52609 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S129392AbQKJMAe>;
	Fri, 10 Nov 2000 07:00:34 -0500
Date: Fri, 10 Nov 2000 03:46:02 -0800
Message-Id: <200011101146.DAA15898@pizda.ninka.net>
From: "David S. Miller" <davem@redhat.com>
To: ben@zeus.com
CC: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.30.0011101116580.11412-100000@artemis.cam.zeus.com>
	(message from Ben Mansell on Fri, 10 Nov 2000 11:49:13 +0000 (GMT))
Subject: Re: Missing ACKs with Linux 2.2/2.4?
In-Reply-To: <Pine.LNX.4.30.0011101116580.11412-100000@artemis.cam.zeus.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Date: Fri, 10 Nov 2000 11:49:13 +0000 (GMT)
   From: Ben Mansell <ben@zeus.com>

   (client-side tcpdump)
 ...
   11:05:32.547518 cobalt-box.echo > artemis.39061: P 1:1449(1448) ack 1602 win 31856 <nop,nop,timestamp 0 76152422> (DF)
                ^^^^^^^^^^^

   (server-side)
 ...
    11:05:32.437733 cobalt-box.echo > artemis.39061: P 1:1449(1448) ack 1602 win 31856 <nop,nop,timestamp 0 76152422> (DF)
                 ^^^^^^^^^^^

Wheee... zero timestamp from Cobalt box.  Artemis (correctly) drops
this packet (due to PAWS test because a zero timestamp is "older" than
the most recent timestamp Artemis saw from cobalt-box).  Upgrade it's
kernel and retest :-)

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
