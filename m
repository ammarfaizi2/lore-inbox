Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271818AbRHXOcP>; Fri, 24 Aug 2001 10:32:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272019AbRHXOcF>; Fri, 24 Aug 2001 10:32:05 -0400
Received: from tux.rsn.bth.se ([194.47.143.135]:57736 "EHLO tux.rsn.bth.se")
	by vger.kernel.org with ESMTP id <S271818AbRHXObt> convert rfc822-to-8bit;
	Fri, 24 Aug 2001 10:31:49 -0400
Date: Fri, 24 Aug 2001 16:33:43 +0200 (CEST)
From: Martin Josefsson <gandalf@wlug.westbo.se>
To: Bernhard Busch <bbusch@biochem.mpg.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: Poor Performance for ethernet bonding 
In-Reply-To: <3B865882.24D57941@biochem.mpg.de>
Message-ID: <Pine.LNX.4.21.0108241630060.17009-100000@tux.rsn.bth.se>
X-message-flag: Get yourself a real mail client! http://www.washington.edu/pine/
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Aug 2001, Bernhard Busch wrote:

> Hi
> 
> 
> I have tried to use ethernet  network interfaces bonding to increase
> peformance.
> 
> Bonding is working fine, but the performance is rather poor.
> FTP between 2 machines ( kernel 2.4.4 and 4 port DLink 100Mbit ethernet
> card)
> results in a transfer rate of 3MB/s).
> 
> Any Hints?

I've seen this too, it doesn't have anything to do with bonding, it's the
fact that you are sending packets out several interfaces at once that's
the cause. Same thing happend to me when transmitting at high speeds on
two interfaces at once without bonding. And you are using 4 interfaces so
I can imagine that it will be even worse than I saw.

And bonding on my two eepro100 in another machine works perfectly,
no problem maxing out at aproximatly 200Mbit.

/Martin

> here is my setup for the channel bonding
> 
> insmod bonding
> insmod tulip
> ifconfig bond0 192.168.100.2 netmask 255.255.255.0 broadcast
> 192.168.100.255
> ifconfig bond0 down
> ./ifenslave  -v bond0 eth2 eth3 eth4 eth5
> ifconfig bond0 up
> route add -host 192.168.100.1 dev bond0
> 
> 
> Many thanks for every help
> 
> Bernhard
> 
> --
> Dr. Bernhard Busch
> Max-Planck-Institut für Biochemie
> Am Klopferspitz 18a
> D-82152 Martinsried
> Tel: +48(89)8578-2582
> Fax: +49(89)8578-2479
> Email bbusch@biochem.mpg.de
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

Linux hackers are funny people: They count the time in patchlevels.

