Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291251AbSBGUD4>; Thu, 7 Feb 2002 15:03:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291257AbSBGUDr>; Thu, 7 Feb 2002 15:03:47 -0500
Received: from zcars0m9.nortelnetworks.com ([47.129.242.157]:2260 "EHLO
	zcars0m9.ca.nortel.com") by vger.kernel.org with ESMTP
	id <S291254AbSBGUDL>; Thu, 7 Feb 2002 15:03:11 -0500
Message-ID: <3C62DF32.50FA6FC6@nortelnetworks.com>
Date: Thu, 07 Feb 2002 15:10:26 -0500
X-Sybari-Space: 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jan Harkes <jaharkes@cs.cmu.edu>
Cc: "Christopher Friesen" <cfriesen@nortelnetworks.com>,
        linux-kernel@vger.kernel.org
Subject: Re: want opinions on possible glitch in 2.4 network error reporti ng
In-Reply-To: <Pine.LNX.3.95.1020207125644.8721A-100000@chaos.analogic.com> <3C62CB25.75487AD5@nortelnetworks.com> <20020207195118.GB31329@ravel.coda.cs.cmu.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Harkes wrote:
> 
> On Thu, Feb 07, 2002 at 01:44:53PM -0500, Chris Friesen wrote:
> > The possibility of random dropping of packets in the kernel means that an
> > infinite loop on sendto() will chew up the entire machine even if you've only
> > got a 10Mbit/s link.  This seems just wrong.
> 
> What happens if you have the 100Mbit/s side of the link and the receiver
> has a 9600baud dial-in modem....
> 
> The sending side needs to do throttling based on packet loss anyways, it
> really doesn't matter that it's lost locally or on the network or at the
> receiving host.

Yes, this is true for general use.  However, suppose I want to do an IP takeover
and send out arp packets to force an update of the arp caches of everyone on the
subnet.  The network is tightly controlled and we know everything that's on it. 
How do I guarantee that my packets get out of the local system and onto the
wire?

Currently I send three packets in a row on failover, and another three packets
every 10 seconds.  It would still be nice to be assured that the packets
actually made it onto the wire.

This is linux, we like having absolute control over our system.  Does it make
sense to have no possible way of guaranteeing that a specific packet has made it
onto the wire?

Chris

-- 
Chris Friesen                    | MailStop: 043/33/F10  
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com
