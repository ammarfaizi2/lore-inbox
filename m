Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281809AbRLUOhq>; Fri, 21 Dec 2001 09:37:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283759AbRLUOhh>; Fri, 21 Dec 2001 09:37:37 -0500
Received: from [198.17.35.35] ([198.17.35.35]:43739 "HELO mx1.peregrine.com")
	by vger.kernel.org with SMTP id <S281809AbRLUOh2>;
	Fri, 21 Dec 2001 09:37:28 -0500
Message-ID: <B51F07F0080AD511AC4A0002A52CAB445B2A2F@ottonexc1.ottawa.loran.com>
From: Dana Lacoste <dana.lacoste@peregrine.com>
To: "'Alex'" <mail_ker@xarch.tu-graz.ac.at>
Cc: linux-kernel@vger.kernel.org,
        "Linux-Net (E-mail)" <linux-net@vger.kernel.org>
Subject: RE: conclusion: arp.c *must* be (still) defective
Date: Fri, 21 Dec 2001 06:37:29 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Moving to linux-net because it's more appropriate there, don't you think?

it works fine for me.  Maybe you can give some more info on just
exactly what you're doing and what's failing?

# uname -r
2.4.16
# netstat -rn|grep 0.0.0.0
(edited :)
0.0.0.0         172.22.1.1      0.0.0.0         UG       40 0          0
eth0
# arp 172.22.1.1
Address      HWtype  HWaddress           Flags Mask  Iface
172.22.1.1   ether   00:60:97:05:91:3A   C           eth0
# ping 172.22.1.1
PING 172.22.1.1 (172.22.1.1): 56 octets data
64 octets from 172.22.1.1: icmp_seq=0 ttl=255 time=0.4 ms
--- 172.22.1.1 ping statistics ---
1 packets transmitted, 1 packets received, 0% packet loss
round-trip min/avg/max = 0.4/0.4/0.4 ms


> -----Original Message-----
> From: Alex [mailto:mail_ker@xarch.tu-graz.ac.at]
> Sent: December 21, 2001 08:43
> To: linux-kernel@vger.kernel.org
> Subject: conclusion: arp.c *must* be (still) defective
> 
> 
> 
> Dear Mailing List,
> 
> I'm having great problems with ARP. Frankly, kernel 2.4.16 
> never gets the
> proper arp address of the next-hop-router, no matter what I try.
> 
> My equipment: 
> 
> Suse 7.3 , kernel upgraded to 2.4.16
> 3com 3c509-b tx isapnp ethcard eth0
> msi-something geforce2mx 200
> sb16 isapnp
> thunderbird 1.2 ghz
> gigabyte 7ixe4 motherboard
> 512 mb ram @ 100 mhz fsb
> 
> I can only ping the IP of the network card itself.
> 
> Whenever I ping my nexthop router (ip: x.x.x.1) i get a pause of a few
> seconds, then a whole sequence of "Destination unreachable".
> Looking at the arp cache using "arp -a", I see that the arp cache is
> always incomplete (always KEEPS being incomplete). 
> 
> Any clue is greatly appreciated, but I do suspect that the 
> kernel 2.4.16's
> ARP code is buggy since Win98 , win2k etc works flawlessly.
> 
> Yours
> 
> Alex
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
