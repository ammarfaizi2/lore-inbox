Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318780AbSHBLZ3>; Fri, 2 Aug 2002 07:25:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318778AbSHBLZ3>; Fri, 2 Aug 2002 07:25:29 -0400
Received: from p5085EA05.dip.t-dialin.net ([80.133.234.5]:53889 "EHLO
	majestix.gallier.de") by vger.kernel.org with ESMTP
	id <S318774AbSHBLZ1>; Fri, 2 Aug 2002 07:25:27 -0400
Date: Fri, 2 Aug 2002 13:28:54 +0200 (CEST)
From: Oliver Joa <ojoa@gatrixx.com>
X-X-Sender: <olli@majestix.gallier.de>
To: <linux-net@vger.kernel.org>
cc: <linux-kernel@vger.kernel.org>
Subject: strange behaviour in TCP-Connect-Handshake
Message-ID: <Pine.LNX.4.33.0208021323120.7906-100000@majestix.gallier.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

we have found something strange in TCP-Connect-Handshake. Here is the
tcpdump of a connect:

12:41:27.997216 eth0 < 217.111.11.28.53656 > 10.10.2.10.www: S
1550641618:1550641618(0) win 5840 <mss 1460,sackOK,timestamp 646924298
0,nop,wscale 0> (DF)

12:41:27.997243 eth0 > 10.10.2.10.www > 217.111.11.28.53656: .
281850:281850(0) ack 124 win 32120 <nop,nop,timestamp 88850 648121803>
(DF)

12:41:27.998085 eth0 < 217.111.11.28.53656 > 10.10.2.10.www: R
1438731713:1438731713(0) win 0 (DF)

217.111.11.28 sends the syn-packet to 10.10.2.10, and 10.10.2.10 answers
with a ack-packet, but without the syn-flag set. I thought this might be
violating the TCP-protcol. It happens 3 to 4 times per second on a
Squid-Server with lots of Requests (100-200 per second). We use the
2.4.18-kernel. We have tried a 2.2.20-kernel and it worked normal.

What could be the problem?

many thanks

Oliver


-- 
Dipl. Inf. (FH) Oliver Joa
senior IT-architect

Gatrixx NetSolutions GmbH
Karl-Goetz-Strasse 5
97424 Schweinfurt
Fon +49 9721 797 420
Fax +49 9383 999-58
Mobil +49 160 47874 62
E-Mail ojoa@gatrixx.com, ojoa@gmx.net, oliver@j-o-a.de

Weitere Informationen erhalten Sie unter:
http://www.gedif.de/


