Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129398AbRAZSCD>; Fri, 26 Jan 2001 13:02:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130701AbRAZSBx>; Fri, 26 Jan 2001 13:01:53 -0500
Received: from pop.gmx.net ([194.221.183.20]:15719 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S129735AbRAZSBm>;
	Fri, 26 Jan 2001 13:01:42 -0500
Message-ID: <3A71BB68.21B998AB@gmx.de>
Date: Fri, 26 Jan 2001 19:01:12 +0100
From: Martin Rauh <martin.rauh@gmx.de>
X-Mailer: Mozilla 4.6 [de] (WinNT; U)
X-Accept-Language: de
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Packet loss in IP/UDP Stack?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

It seems that we are loosing packets in the UDP stack.
Somebody might think that this is not astonishing, but
the packets are not lost at the network layer. They seem to get
lost in the IP/UDP Layer of the receiving box.

We have got the following configuration:
Two linux boxes (P4, 733 MHz, 256 MB RAM, kernel 2.4.0)
are directly connected with two syskonnect sk98xx
gigabit ethernet cards. We are sending a file from one host to the other

with UDP. About half of the file is lost in the receiving application.
But according to the statistics in /proc/net/dev no errors (fifo, frame,
dropped...)
occured in the network layer. Even the transmitted and received
data at the network layer (tx-bytes, -packets) are identical
to the amount of the transfered file (plus network overhead).

Doas anybody know where the loss occurs? Is there a loss at the
network layer or in the higher protocol layers?

Many Thanks,

Martin Rauh

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
