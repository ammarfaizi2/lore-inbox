Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291372AbSCRS2C>; Mon, 18 Mar 2002 13:28:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291547AbSCRS1x>; Mon, 18 Mar 2002 13:27:53 -0500
Received: from gull.mail.pas.earthlink.net ([207.217.120.84]:22520 "EHLO
	gull.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S291372AbSCRS1g>; Mon, 18 Mar 2002 13:27:36 -0500
Reply-To: <robertp@ustri.com>
From: "Robert Pfister" <robertp@ustri.com>
To: <prade@cs.sunysb.edu>, <linux-kernel@vger.kernel.org>
Subject: RE: Trapping all Incoming Network Packets 
Date: Mon, 18 Mar 2002 11:27:31 -0700
Message-ID: <003501c1ceaa$91678f90$1e00a8c0@nomaam>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <Pine.GSO.4.33.0203171840250.5841-100000@compserv3>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There are ways to accomplish similar things in user space. Is there some
reason that you need to do this in the kernel? What is your end-goal with
this?

Robb

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of
prade@cs.sunysb.edu
Sent: Sunday, March 17, 2002 4:57 PM
To: linux-kernel@vger.kernel.org
Cc: prade@cs.sunysb.edu
Subject: Trapping all Incoming Network Packets


Hi,

I am trying to write a module that will redirect all the packets to my
recv routine, instead of going to the recv routines of the specific
protocols. For example, a packet with the protocol field ETH_P_IP should
come to "my_recv" before going to ip_rcv.

My restriction is I cannot add my own header. In other words, I cannot
register my own protocol handler and attach a header to each packet to
redirect it to "my_recv".

The option I figured out seems to be changing the function pointers, eg.
net_rx_action by my own net_rx_action at init_module time and restoring it
at cleanup. But since 2.4 kernel does not export any function to deal with
the data structures holding the function pointers, I am in a fix.

I look forward to some interesting suggestions about how to get around the
problem for 2.4 kernels.

Thanks,
-- pradipta.

NB. Plz say "yes" to the cc-option. Thx. :-)

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

