Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312143AbSCRABZ>; Sun, 17 Mar 2002 19:01:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312147AbSCRABS>; Sun, 17 Mar 2002 19:01:18 -0500
Received: from sbcs.cs.sunysb.edu ([130.245.1.15]:6296 "EHLO
	sbcs.cs.sunysb.edu") by vger.kernel.org with ESMTP
	id <S312144AbSCRAAr>; Sun, 17 Mar 2002 19:00:47 -0500
Date: Sun, 17 Mar 2002 18:57:24 -0500 (EST)
From: <prade@cs.sunysb.edu>
X-X-Sender: <prade@compserv3>
To: <linux-kernel@vger.kernel.org>
cc: <prade@cs.sunysb.edu>
Subject: Trapping all Incoming Network Packets 
Message-ID: <Pine.GSO.4.33.0203171840250.5841-100000@compserv3>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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

