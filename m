Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289552AbSAKTHc>; Fri, 11 Jan 2002 14:07:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289597AbSAKTHW>; Fri, 11 Jan 2002 14:07:22 -0500
Received: from svr3.applink.net ([206.50.88.3]:44814 "EHLO svr3.applink.net")
	by vger.kernel.org with ESMTP id <S289552AbSAKTHP>;
	Fri, 11 Jan 2002 14:07:15 -0500
Message-Id: <200201111906.g0BJ6kSr003243@svr3.applink.net>
Content-Type: text/plain; charset=US-ASCII
From: Timothy Covell <timothy.covell@ashavan.org>
Reply-To: timothy.covell@ashavan.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, timothy.covell@ashavan.org,
        "David S. Miller" <davem@redhat.com>
Subject: Re: strange kernel message when hacking the NIC driver
Date: Fri, 11 Jan 2002 13:02:56 -0600
X-Mailer: KMail [version 1.3.2]
Cc: zhengpei@msu.edu (Pei Zheng), linux-kernel@vger.kernel.org
In-Reply-To: <E16P1Sb-0007b9-00@the-village.bc.nu>
In-Reply-To: <E16P1Sb-0007b9-00@the-village.bc.nu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 11 January 2002 07:11, Alan Cox wrote:
> > Let me clarify what I said earlier.  You cannot have
> > identical MAC addresses on two different NICs.   Indeed,
> > it is impossible w/o trying to fool the kernel into
> > redefining the NICs hardware based MAC address.
>
> Wrong
>
> A mac address is per system. Now in fact almost all systems do it per
> ethernet card but that is not what the specifications guarantee. There are
> machines out there and cards out there which use the same MAC on all
> interfaces. -

IMHO, they _should_ be unique except for multicast addressing and uses
such as in HSRP/VRRP and such.   Network admins usually like to have
a firm grip concerning how traffic is routed.  They don't want traffic on
one segment/subnet getting routed to another.  IHMO, this is a vector
for viruses proliferation because the host vulnerable thinks that all
segments/subnets are the same.


I don't have the money to shell out for a copy of the IEEE 802.x standards, 
but I can quote some other folks on this:


RFC 826:

However, 48.bit Ethernet addresses are supposed to be unique and fixed for 
all time, so they shouldn't
change.


>From the Ethernet FAQ:

02.10Q: What is a MAC address?
A: It is  the unique hexadecimal serial number assigned to each Ether-
net  network device to identify it  on  the network.  With Ethernet
devices  (as  with  most other  network  types),  this  address  is
permanently set at  the time of manufacturer, though it can usually
be changed  through  software (though this is  generally a Very
Bad Thing to do).

02.11Q: Why must the MAC address to be unique?

A: Each card  has  a  unique MAC address,  so  that
it will be able to exclusively  grab  packets  off the wire
meant  for  it.   If  MAC addresses are not unique,  there is
no  way  to distinguish between two  stations.  Devices on the
network  watch  network traffic and look for their own MAC address
in each packet to determine whether they should decode  it or  not.
Special circumstances exist  for broadcasting to every device.

04.01Q: What is a "segment"?
A: A  piece of network wire bounded by bridges,  routers, repeaters or
terminators.

04.02Q: What is a "subnet"?
A: Another overloaded  term. It can  mean, depending on  the usage,  a
segment, a set of machines  grouped together by a specific protocol
feature  (note  that  these machines do not have to be on  the same
segment, but they could be) or a big  nylon  thing used  to capture
enemy subs.







-- 
timothy.covell@ashavan.org.
