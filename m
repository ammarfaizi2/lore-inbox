Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131283AbRA3AaK>; Mon, 29 Jan 2001 19:30:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131500AbRA3AaB>; Mon, 29 Jan 2001 19:30:01 -0500
Received: from thorgal.et.tudelft.nl ([130.161.40.91]:7977 "EHLO
	thorgal.et.tudelft.nl") by vger.kernel.org with ESMTP
	id <S131423AbRA3A3z>; Mon, 29 Jan 2001 19:29:55 -0500
Mime-Version: 1.0
Message-Id: <a05010403b69bb854d7de@[130.161.115.44]>
In-Reply-To: <3A75F4D7.D7957633@metabyte.com>
In-Reply-To: <3A75F4D7.D7957633@metabyte.com>
Date: Tue, 30 Jan 2001 01:28:25 +0100
To: Pete Zaitcev <zaitcev@metabyte.com>
From: "J.D. Bakker" <bakker@thorgal.et.tudelft.nl>
Subject: Re: Maxwell strikes the heart (ECN: Clearing the air)
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 14:55 -0800 29-01-2001, Pete Zaitcev wrote:
>So far I fail to see how a repainted NAK, kludged into a NAKless protocol,
>would improve stability of the Internet. If anything, it is going to
>exaggerate traffic oscillations.

If anything RED will *reduce* oscillations by alleviating retransmit 
synchronization.

>  I would appreciate couple of links
>to reputable studies or discussions on the subject.

See

http://www.aciri.org/floyd/ecn.html
http://www.aciri.org/floyd/red.html

(I particularly like ftp://ftp.ee.lbl.gov/talks/vj-nanog-red.pdf)

RED and ECN can be considered independently (although they do work 
together quite well). You can see ECN as a way of the network telling 
the endpoints "Normally I would have dropped this datagram, but I'll 
let you get away with it this time". TCP behavior on reception of an 
ECN should be the same as when a datagram is dropped, but without the 
latency (and jitter) that is the result of a lost datagram.

JDB.
[using RED/ECN-like protocols for latency sensitive video 
communications over a wireless link]
-- 
LART. 250 MIPS under one Watt. Free hardware design files.
http://www.lart.tudelft.nl/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
