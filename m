Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262662AbRFNVE3>; Thu, 14 Jun 2001 17:04:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263329AbRFNVET>; Thu, 14 Jun 2001 17:04:19 -0400
Received: from h157s242a129n47.user.nortelnetworks.com ([47.129.242.157]:18129
	"EHLO zcars0m9.ca.nortel.com") by vger.kernel.org with ESMTP
	id <S262662AbRFNVEC>; Thu, 14 Jun 2001 17:04:02 -0400
Message-ID: <3B2926A3.C3B65EBB@nortelnetworks.com>
Date: Thu, 14 Jun 2001 17:03:31 -0400
From: "Christopher Friesen" <cfriesen@nortelnetworks.com>
X-Mailer: Mozilla 4.7 [en] (X11; U; HP-UX B.10.20 9000/778)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: questions about link-level loopback, PF_PACKET and ETH_P_LOOP
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Orig: <cfriesen@americasm01.nt.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm attempting to write a piece of code that will validate the physical ethernet
link from a NIC to the nearest router/hub/switch.  What I'd like to do is to
send out an ethernet packet addressed to me, bounce it off the
hub/switch/router, and then read it back in.  This is all at the ethernet layer.

Needless to say, I've been having some issues.

1) Is it even possible to do something like this?  I notice that tcpdump shows
the packets outgoing (and properly formatted) but the packets don't seem to come
back to me.  Even if I send it out with the broadcast address, I don't seem to
get the packet back to the interface that sent it.  Is this standard behaviour? 
Is there any way to send out a packet addressed to myself and have it come back
to me?

2) Using ETH_P_LOOP as the protocol in the call to socket(), I can't seem to
receive any messages whatsoever.  If I set this to ETH_P_ALL, then I get all
messages (including ones with protocol set to ETH_P_LOOP).   It almost seems
like ETH_P_LOOP isn't properly handled by the kernel.  Is this the case?

The nitty-gritty on this is that I have a machine that has two NICs but only one
IP address.  I want to do some kind of packet loopback at the ethernet layer to
verify that my NIC transceiver is working properly.

If anyone has any bright ideas, I'd be glad to hear them.

Thanks,

Chris


-- 
Chris Friesen                    | MailStop: 043/33/F10  
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com
