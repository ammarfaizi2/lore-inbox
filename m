Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272280AbRJTKrX>; Sat, 20 Oct 2001 06:47:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272549AbRJTKrO>; Sat, 20 Oct 2001 06:47:14 -0400
Received: from castle.nmd.msu.ru ([193.232.112.53]:36625 "HELO
	castle.nmd.msu.ru") by vger.kernel.org with SMTP id <S272280AbRJTKq6>;
	Sat, 20 Oct 2001 06:46:58 -0400
Message-ID: <20011020145515.A17623@castle.nmd.msu.ru>
Date: Sat, 20 Oct 2001 14:55:15 +0400
From: Andrey Savochkin <saw@saw.sw.com.sg>
To: kuznet@ms2.inr.ac.ru
Cc: linux-kernel@vger.kernel.org, cfriesen@nortelnetworks.com
Subject: Re: how to see manually specified proxy arp entries using "ip neigh"
In-Reply-To: <20011019173233.A12919@castle.nmd.msu.ru> <200110191713.VAA03502@ms2.inr.ac.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2i
In-Reply-To: <200110191713.VAA03502@ms2.inr.ac.ru>; from "A.N.Kuznetsov" on Fri, Oct 19, 2001 at 09:13:12PM
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Oct 19, 2001 at 09:13:12PM +0400, A.N.Kuznetsov wrote:
> 
> > I don't want to turn on proxy arp on an interface basis, because subtle
> > mistakes in network configuration with proxy arp turned on may have serious
> > consequences, including arp storm (sic!),
> 
> Andrey, do not fuck me brains. :-) (translate this to English :-))
> No "serious" consequences exist. And not serious ones are surely covered

An offtopic note about consequences:
let's suppose proxy_arp is turned on on eth0 with the primary goal to proxy
addresses available via eth1.  There is another interface eth2 were
1.2.3.0/24 routed to.  Forwarding is turned on everywhere.
Someone decided to save on equipment (or simply made a mistake) and short-cut
eth0 and eth2 segments, unconscious forming "shared media".
What do you think will happen when a broadcast ARP request for 1.2.3.4
arrives to both eth0 and eth2?
Right, "is-at" reply with eth0 MAC address of this poor "proxy" on that
shared media.

> by the same mistakes which you can make forced to add useless element
> to configuration.

Well, what I want is to make the host an arp "proxy" on all interfaces for
all addresses reachable through devX.  I do not want to mess with how
customer configures all other interfaces.
Right now all routes to devX are /32, for all of them proxy arp entries are
created by the same script, and all are happy.

How can it be done better?
New mechanism of fine-grained control over proxy arp? :-)

	Andrey
