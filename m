Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130507AbRAYROK>; Thu, 25 Jan 2001 12:14:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132999AbRAYROA>; Thu, 25 Jan 2001 12:14:00 -0500
Received: from quechua.inka.de ([212.227.14.2]:39716 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id <S130507AbRAYRNu>;
	Thu, 25 Jan 2001 12:13:50 -0500
Date: Thu, 25 Jan 2001 18:08:58 +0100
To: Julian Anastasov <ja@ssi.bg>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Turning off ARP in linux-2.4.0
Message-ID: <20010125180858.A32328@lina.inka.de>
In-Reply-To: <Pine.LNX.4.10.10101251202520.3810-100000@l>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <Pine.LNX.4.10.10101251202520.3810-100000@l>; from ja@ssi.bg on Thu, Jan 25, 2001 at 01:02:32PM +0200
From: Bernd Eckenfels <ecki@lina.inka.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 25, 2001 at 01:02:32PM +0200, Julian Anastasov wrote:
> 	Hey, the world is not only Linux. Sometimes the people build
> clusters using different hardware and software. If your solution works
> for your setup we can't claim it is universal.

It is a Linux News Group after all. So dont confuse us with Broken Operating
Systems. And of course we don't need a Hidden flag in Linux to solve other
Operating Systems Auto-Binding.

> 	When you send the IPIP datagram again to real server in the
> LAN you have the same problem.

Yes, you are right, -arp is needed in that system, too. Or you need WAN
Distributed Services.

> 	You can't always use -arp!!! Read above. Fix the manual! BTW
> in this thread I don't see wrong docs. Which ones claim this?

The Manual is OK. It claims that -arp will work and it claims that on some
Linux Sytems it wont (i am not sure why it should not work on old kernels
but i accept it).

> 
> 	-arp can work if you maintain a fresh copy in /etc/ethers and
> when you don't use ARP. But then you don't need to set -arp flag. The
> setup will work without setting -arp to lo or eth, right? If you don't
> use ARP why to stop it in the interface? In theory we will not see any
> ARP packets, even from the uplink router.

I am not sure about this, because of the neighbour alive discovery. I dont
know if a hard wired ARP Address will stop that.

> > it is changing the packets MAC destination address (or using an IPIP tunnel).
> 
> 	Tunnel to where? To real server in the LAN or to another
> real server?

To the real server on the LAN, the server is the endpoint. As written in LVS
Docs.

> 	You are lucky to use Linux on all hosts. May be you have one
> extra uplink router (a Linux box)?

You can turn off arp discovery on every reasonable pwerfull router. And I
dont see a situation where you want to build a HA/HP Cluster using you ISPs
Router as a core component and the ISP is not cooperating with you.

> 
> 	They are not complicated more in 2.4. The current handling in 2.4
> is same. I already said that the net maintainers are planning other
> features for 2.4 and the hidden feature is not considered. Until then
> there is no difference between the kernels and the hidden feature can
> be used even in 2.4.

There is no hidden Feature in 2.4, thats why we have started the thread. And
for exactly this reason I suggested to use -arp.

Greetings
Bernd
-- 
  (OO)      -- Bernd_Eckenfels@Wendelinusstrasse39.76646Bruchsal.de --
 ( .. )  ecki@{inka.de,linux.de,debian.org} http://home.pages.de/~eckes/
  o--o     *plush*  2048/93600EFD  eckes@irc  +497257930613  BE5-RIPE
(O____O)  When cryptography is outlawed, bayl bhgynjf jvyy unir cevinpl!
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
