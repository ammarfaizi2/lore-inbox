Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261646AbSKHGGF>; Fri, 8 Nov 2002 01:06:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261650AbSKHGGF>; Fri, 8 Nov 2002 01:06:05 -0500
Received: from cburnett.student.iastate.edu ([64.113.73.249]:33555 "HELO
	candysporks.org") by vger.kernel.org with SMTP id <S261646AbSKHGGE>;
	Fri, 8 Nov 2002 01:06:04 -0500
Message-ID: <1036735964.3dcb55dc6f784@www.candysporks.org>
Date: Fri,  8 Nov 2002 00:12:44 -0600
From: Colin Burnett <cburnett@candysporks.org>
To: LKML <linux-kernel@vger.kernel.org>
Subject: pure raw eth sockets
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm at a complete road block here and I appreciate any help!

I'm trying to write a packet generator that generates a packet down to the
destination/src mac address of an eth frame.  However, nothing I find seems to
explain how to do this let alone if it is possible.  As example (for
familiarity), implementing a RARP client (and server).  I first create a socket:

socket(PF_INET, SOCK_PACKET, ETH_P_RARP)

After generating an entire packet (eth frame + RARP request) and sending it via
sendto, tcpdump shows that my packet was encapsulated as the data for an IP
packet.  Definitely not what I want and I suspect it is because I'm passing the
PF_INET domain (it assuming IP?).

So how would I go about implement sending a RARP request (obviously I'm doing
something wrong or assuming something wrong)?  Or more generally, how do I get
pure raw socket access?
-- 


Colin Burnett
