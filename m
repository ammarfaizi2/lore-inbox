Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261944AbRE0MXn>; Sun, 27 May 2001 08:23:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261932AbRE0MXd>; Sun, 27 May 2001 08:23:33 -0400
Received: from p98.nas4.is5.u-net.net ([195.102.201.226]:6384 "EHLO
	keston.u-net.com") by vger.kernel.org with ESMTP id <S261925AbRE0MXW>;
	Sun, 27 May 2001 08:23:22 -0400
Message-ID: <003c01c0e6a7$bec8c710$1901a8c0@node0.idium.eu.org>
From: "David Flynn" <Dave@keston.u-net.com>
To: <mailto:linux-kernel@vger.kernel.org>
Subject: KERNEL: assertion (tp->copied_seq == tp->rcv_nxt || (flags&MSG_PEEK|MSG_TRUNC))) failed at tcp.c(1279):tcp_recvmsg ...
Date: Sun, 27 May 2001 13:22:49 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
X-MDRemoteIP: 192.168.1.25
X-Return-Path: Dave@keston.u-net.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

To all the kernel people,
   To say i have a minor problem is a slight understatement, i have two
problems.  The first happens about 10 minutes into a fairly heavy load test,
where i have several loadtesting clients running on an NT5 box, sending alot
of queries a second to the GNU-linux box (over TCP/IP) ... i am running
kernel 2.4.3.  The problem seems that after about 10 minutes every thing
stops, all my remote sessions to the linux box freeze, and i cant even
connect on the serial port ... (requiring me to find a monitor to use).
(However the GNU-Linux box will still respond to ping's ) Upon connecting
the monitor i see the following scrolling so fast down the screen that the
only way to find out what it says is to take a photo of the monitor
(www.keston.u-net.com/errors/Mvc-237f.jpg)!!!

KERNEL: assertion (tp->copied_seq == tp->rcv_nxt ||
(flags&MSG_PEEK|MSG_TRUNC))) failed at tcp.c(1279):tcp_recvmsg
recvmsg bug: copied ADA875AF seq ADA876A3
KERNEL: assertion (tp->copied_seq == tp->rcv_nxt ||
(flags&MSG_PEEK|MSG_TRUNC))) failed at tcp.c(1279):tcp_recvmsg
recvmsg bug: copied ADA875AF seq ADA876A3
etc ...

Now we are running three pieces of software which is being load tested ...

All this is done with TCP/IP, with the possible exception of the SQL queries
(which are probabally over AF_UNIX sockets)

Load Test -> Piece'o'software1 ---> Piece'o'Software2
                  |--------> MySQL Server

Now to see whats in the Box:

its a PII 450 (running at 500), with 128MB of SDRAM, 1*87Mb AT HDD for swap
(almost never used), 1*5Gig HDD (root), has 1*(4port Cogent PCI Quartet 10Mb
NIC, using Dec chips, and the tulip driver), and 1*(1port Intel EtherExpress
Pro 100 (10/100Mbs running at 100mbs)).

Only 2 of the 5 possible interfaces are in use, however all are connected to
the same hub ... (the EEPro100 used to be connected to a switch and acted as
a firewall / router etc ... however some one nicked my switch!)

All the requests _should_ be going through the eepro100, (the 2 interfaces
are on different nets ... 192.168.0.100 and 192.168.1.5)

Now shortly before the system kills itself, the hub starts showing that
10Mbs data is being transmitted (before, it was only 100mbits)

Finally, none of the error messages are recored in any of the syslog files

Any help with the problem would be greatly apreciated ... and it is easily
reproducable

However, i am completely locked out from the box, if anyone can think of a
way to gain access rather than have to power cycle it, i would be extreemly
appreciative

Thanks,

Dave
---------------------------------------
The information in this e-mail and any files sent with it is confidential to
the ordinary user of the e-mail address to which it was addressed and may
also be legally privileged. It is not to be relied upon by any person other
than the addressee except with the sender's prior written approval. If no
such approval is given, the sender will not accept liability (in negligence
or otherwise) arising from any third party acting, or refraining from
acting, on such information. If you are not the intended recipient of this
e-mail you may not copy, forward, disclose or otherwise use it or any part
of it in any form whatsoever. If you have received this e-mail in error
please notify the sender immediately, destroy any copies and delete it from
your computer system. Have a nice Day !
---------------------------------------------


