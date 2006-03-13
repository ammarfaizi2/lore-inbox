Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932455AbWCMUz5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932455AbWCMUz5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 15:55:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932457AbWCMUz4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 15:55:56 -0500
Received: from mail.infrasupportetc.com ([66.173.97.5]:64576 "EHLO
	mail733.InfraSupportEtc.com") by vger.kernel.org with ESMTP
	id S932455AbWCMUzz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 15:55:55 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Router stops routing after changing MAC Address
Content-class: urn:content-classes:message
X-MimeOLE: Produced By Microsoft Exchange V6.5
Date: Mon, 13 Mar 2006 14:57:04 -0600
Message-ID: <925A849792280C4E80C5461017A4B8A20321F5@mail733.InfraSupportEtc.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Router stops routing after changing MAC Address
Thread-Index: AcZG3JFcaxxA2oPXRWKojNxFlJZu7wAAmu6g
From: "Greg Scott" <GregScott@InfraSupportEtc.com>
To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>,
       "Stephen Hemminger" <shemminger@osdl.org>
Cc: "Chuck Ebbert" <76306.1226@compuserve.com>,
       "linux-kernel" <linux-kernel@vger.kernel.org>,
       "David S. Miller" <davem@davemloft.net>, <netdev@vger.kernel.org>,
       "Bart Samwel" <bart@samwel.tk>, "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       "Simon Mackinlay" <smackinlay@mail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

But in a failover scenario you want two devices to have the same IEEE
(station) Address (or MAC Address or hardware address).  So many names
for the same thing!  

When the primary unit fails, you want the backup unit to completely
assume the failed unit's identity - right down to the MAC Address.  The
other way to do it using gratuitous ARPs is not good enough because some
cheap router someplace with an ARP cache of several hours will not
listen and will never update its own ARP cache.  

I like to think of this as bending the rules a little bit, not really
breaking them.  :)

- Greg



>Actually, it doesn't make any difference. Changing the IEEE station
>(physical) address is not an allowed procedure even though hooks are 
>available in many drivers to do this. According to the IEEE 802 
>physical media specification, this 48-bit address must be unique 
>and must be one of a group assigned by IEEE. Failure to follow this 
>simple protocol can (will) cause an entire network to fail. If you 
>don't care, then you certainly don't care about multicast bits either, 
>basically let them set it to all ones as well.

>Cheers,
>Dick Johnson
>Penguin : Linux version 2.6.15.4 on an i686 machine (5589.54 BogoMips).
>Warning : 98.36% of all statistics are fiction, book release in April.
