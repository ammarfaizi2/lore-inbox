Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752003AbWCMMOa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752003AbWCMMOa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 07:14:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752000AbWCMMOa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 07:14:30 -0500
Received: from mail.infrasupportetc.com ([66.173.97.5]:37166 "EHLO
	mail733.InfraSupportEtc.com") by vger.kernel.org with ESMTP
	id S1751985AbWCMMO3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 07:14:29 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Router stops routing after changing MAC Address
Content-class: urn:content-classes:message
X-MimeOLE: Produced By Microsoft Exchange V6.5
Date: Mon, 13 Mar 2006 06:15:35 -0600
Message-ID: <925A849792280C4E80C5461017A4B8A20321F1@mail733.InfraSupportEtc.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Router stops routing after changing MAC Address
Thread-Index: AcZGZbuIgE5RK3NCRkqsrozI2U8N0QAL8JHw
From: "Greg Scott" <GregScott@InfraSupportEtc.com>
To: "Chuck Ebbert" <76306.1226@compuserve.com>
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>,
       "David S. Miller" <davem@davemloft.net>, <netdev@vger.kernel.org>,
       "Bart Samwel" <bart@samwel.tk>, "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       "Simon Mackinlay" <smackinlay@mail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On eth0 - no. My "fudged" MAC Address is based on the IP Address.  So
1.2.3.50 becomes 001.002.003.050, which turns into 00:10:02:00:30:50.
But 1.2.3 is fake - it isn't the one I really use.  The other one,
172.16.16.3 - that is a real IP Address that turns into
17:20:16:01:60:03.  And here I thought I was pretty clever - it never
dawned on me in my wildest dreams that those bits had any special
meaning!  I will do some homework about what all the bits mean and then
put together another scheme for my fudged IP Addresses and post the
results here.

- Greg



-----Original Message-----
From: Chuck Ebbert [mailto:76306.1226@compuserve.com] 
Sent: Monday, March 13, 2006 12:11 AM
To: Greg Scott
Cc: linux-kernel; David S. Miller
Subject: Re: Router stops routing after changing MAC Address

In-Reply-To:
<925A849792280C4E80C5461017A4B8A20321CC@mail733.InfraSupportEtc.com>

On Fri, 10 Mar 2006 18:33:15 -0600, Greg Scott wrote:

> How to change MAC addresses is documented well enough - and it works -

> but when I change MAC addresses, my router stops routing.  From the 
> router, I can see the systems on both sides - but the router just 
> refuses to forward packets.  Here are my little test scripts to change

> MAC Addresses.
> 
> First - ip-fudge-mac.sh
> [root@test-fw2 gregs]# more ip-fudge-mac.sh ip link set eth0 down ip 
> link set eth0 address 01:02:03:04:05:06
                            ^
 Bit zero is set, so this is a multicast address.  Is that intentional?

> ip link set eth0 up
> 
> ip link set eth1 down
> ip link set eth1 address 17:20:16:01:60:03
                            ^
 Ditto.

> ip link set eth1 up
> 
> echo "1" > /proc/sys/net/ipv4/ip_forward


--
Chuck
"Penguins don't come from next door, they come from the Antarctic!"

