Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261262AbREOTAj>; Tue, 15 May 2001 15:00:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261272AbREOTA3>; Tue, 15 May 2001 15:00:29 -0400
Received: from fep04-svc.mail.telepac.pt ([194.65.5.203]:23267 "EHLO
	fep04-svc.mail.telepac.pt") by vger.kernel.org with ESMTP
	id <S261262AbREOTAV>; Tue, 15 May 2001 15:00:21 -0400
From: skinbits@substancia.com
Date: Tue, 15 May 2001 19:53:33 +0100
To: linux-kernel@vger.kernel.org
Subject: TCP/IP receive packet problem
Message-ID: <20010515195333.B1095@substancia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
User-Agent: Mutt/1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We are doing the project to implement IP communication over a SCSI bus.
 
So far we have a working communication between the to computers, we can
ping from both computers. Traceroute only works from one computer to
the other and we can't understand why. We are thinking a lot on the 
issue but we haven't found the solution and worst, we haven't found the 
problem.
  
The problem, readingthe ipgrab logs, is that a UDP packet is sent to the
other host with TTL of 1. It passes all our system (is received by the
sym53c8xx driver, send to snh driver, then scsinet and then we
use netif_rx to send the packet to the TCP/IP stack). Now the TCP/IP
should response with a ICMP packet of host unreachebla. But, this packet
is never sent.

Another strange thing is that we change the SCSI ID's, in the computer
were traceroute works, it stop working, and starts working in the
other...

We have checked all parts of the system to see if the packet is correct
(it is), if the TCP/IP dosen't drop because of congestion (It dosen't).

If we use only ICMP (ping) there is no problem. If we use anything else
(UDP,TCP) it dosen't work...

We are using kernel 2.4.4 with a modified sym53c8xx target mode
driver from kernel 2.4.0 and some drivers made by us.
     
If you need more info check http://www.ccjfaro.org/~skinbits/ipoverscsi.
The code is in there and you can download it. There is also some ipgrab
(http://ipgrab.sourceforge.net) traces that shows what I tryed to
explain. You can also send me mail...

Pedro Semeano
