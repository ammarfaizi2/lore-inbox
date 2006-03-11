Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752333AbWCKDHU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752333AbWCKDHU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 22:07:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752335AbWCKDHU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 22:07:20 -0500
Received: from mail.infrasupportetc.com ([66.173.97.5]:53933 "EHLO
	mail733.InfraSupportEtc.com") by vger.kernel.org with ESMTP
	id S1752333AbWCKDHT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 22:07:19 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Router stops routing after changing MAC Address
Content-class: urn:content-classes:message
X-MimeOLE: Produced By Microsoft Exchange V6.5
Date: Fri, 10 Mar 2006 21:08:25 -0600
Message-ID: <925A849792280C4E80C5461017A4B8A20321CE@mail733.InfraSupportEtc.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Router stops routing after changing MAC Address
Thread-Index: AcZEpegrpnJZ+OnzSzW0oMzj9J0s+AAEMo2g
From: "Greg Scott" <GregScott@InfraSupportEtc.com>
To: <linux-kernel@vger.kernel.org>
Cc: "Bart Samwel" <bart@samwel.tk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> I think you're not testing hotswapping machines with equal 
> MAC addresses here, you're testing hot-changing the MAC 
> address for a gateway IP. The machine on the "right side" 
> that the machine on the left side is pinging probably still 
> has the old MAC address for its gateway in it's ARP cache, 
> so the echo reply will be sent to the wrong MAC address. (
> Or am I talking nonsense here?)
>
> --Bart

I sometimes wonder if I'm going crazy myself.  :)

My ultimate goal is to hotswap machines with equal MAC Addresses.  I
built up two machines, hotswapped, and pinged to each one - and it all
worked.  Who would have believed they would refuse to forward packets
when I tried to put them into production?  After my installation went
haywire, my little testbed right now has one gateway in the middle and
one system on the right and one on the left.  So, yes, right now I am
hot-changing MAC addresses on this gateway, trying to get closer to the
problem where routers don't route when the MAC Address is different than
the hardware MAC Address.

Anyway, just to be completely anal about this I put the original MAC
Addresses on the middle gateway and set up the system on the right to
ping the middle gateway.  This worked.  With the pings still going, I
fudged the MAC Addresses in the middle gateway.  The echo replies to the
right stopped for about 30 seconds while its ARP cache cleared.  After
about 30 seconds, the echo replies started coming again as expected.
But the left could never ping the right after fudging MAC Addresses on
the middle gateway.  

So far, no matter what, left and right do not see eachother when the
middle has fudged MAC Addresses.  But when middle has hardware MAC
Addresses, left and right see each other just fine.  

I don't see any way the problem could be related to ARP caches.

- Greg
