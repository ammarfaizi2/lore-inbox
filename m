Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129289AbQK3FYZ>; Thu, 30 Nov 2000 00:24:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129385AbQK3FYQ>; Thu, 30 Nov 2000 00:24:16 -0500
Received: from h24-67-152-12.cc.shawcable.net ([24.67.152.12]:25866 "EHLO
        ajax.capelazo.com") by vger.kernel.org with ESMTP
        id <S129289AbQK3FYE>; Thu, 30 Nov 2000 00:24:04 -0500
Date: Wed, 29 Nov 2000 20:53:32 -0800 (PST)
From: Mark Sutton <mes@capelazo.com>
To: linux-kernel@vger.kernel.org
Subject: TCP header bits set in reserved space
Message-ID: <Pine.GSO.4.10.10011292033380.27791-100000@lazo.capelazo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi
	I can't seem to find this mentioned anywhere. My 2.4 machine
sets 2 bits in the TCP header between the 4 data offset bits and control 
flags. Like so:

11/29-20:25:42.695096 24.67.152.12:62373 -> 192.18.97.241:80
TCP TTL:63 TOS:0x0 ID:0  DF
21S***** Seq: 0x74E55D1A   Ack: 0x0   Win: 0x16D0
TCP Options => MSS: 1460 SackOK TS: 1767921 0 NOP WS: 0

or hex a0c2 / binary 10100000 11000010
			      ^^
This packet is never ACK'd by www.sun.com and the only difference I
can see from one that is are these two bits. RFC793 says they must be zero.
Is 793 still current? Has anyone else seen this?

Mark

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
