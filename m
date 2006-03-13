Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932466AbWCMVj3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932466AbWCMVj3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 16:39:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932467AbWCMVj3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 16:39:29 -0500
Received: from spirit.analogic.com ([204.178.40.4]:529 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP id S932466AbWCMVj1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 16:39:27 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
in-reply-to: <925A849792280C4E80C5461017A4B8A20321F5@mail733.InfraSupportEtc.com>
x-originalarrivaltime: 13 Mar 2006 21:39:26.0568 (UTC) FILETIME=[99EFA680:01C646E6]
Content-class: urn:content-classes:message
Subject: RE: Router stops routing after changing MAC Address
Date: Mon, 13 Mar 2006 16:39:16 -0500
Message-ID: <Pine.LNX.4.61.0603131636470.5608@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Router stops routing after changing MAC Address
Thread-Index: AcZG5pn5dKmbJtTMQi+H7zFmNosB3w==
References: <925A849792280C4E80C5461017A4B8A20321F5@mail733.InfraSupportEtc.com>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Greg Scott" <GregScott@InfraSupportEtc.com>
Cc: "Stephen Hemminger" <shemminger@osdl.org>,
       "Chuck Ebbert" <76306.1226@compuserve.com>,
       "linux-kernel" <linux-kernel@vger.kernel.org>,
       "David S. Miller" <davem@davemloft.net>, <netdev@vger.kernel.org>,
       "Bart Samwel" <bart@samwel.tk>, "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       "Simon Mackinlay" <smackinlay@mail.com>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 13 Mar 2006, Greg Scott wrote:

> But in a failover scenario you want two devices to have the same IEEE
> (station) Address (or MAC Address or hardware address).  So many names
> for the same thing!
>
> When the primary unit fails, you want the backup unit to completely
> assume the failed unit's identity - right down to the MAC Address.  The
> other way to do it using gratuitous ARPs is not good enough because some
> cheap router someplace with an ARP cache of several hours will not
> listen and will never update its own ARP cache.
>
> I like to think of this as bending the rules a little bit, not really
> breaking them.  :)
>
> - Greg
>

Top posting, NotGood(tm). Anyway, if the device fails, you have
routers and hosts ARPing the interface, trying to establish a
route anyway.

>
>
>> Actually, it doesn't make any difference. Changing the IEEE station
>> (physical) address is not an allowed procedure even though hooks are
>> available in many drivers to do this. According to the IEEE 802
>> physical media specification, this 48-bit address must be unique
>> and must be one of a group assigned by IEEE. Failure to follow this
>> simple protocol can (will) cause an entire network to fail. If you
>> don't care, then you certainly don't care about multicast bits either,
>> basically let them set it to all ones as well.
>
>> Cheers,
>> Dick Johnson
>> Penguin : Linux version 2.6.15.4 on an i686 machine (5589.54 BogoMips).
>> Warning : 98.36% of all statistics are fiction, book release in April.
>

Cheers,
Dick Johnson
Penguin : Linux version 2.6.15.4 on an i686 machine (5589.54 BogoMips).
Warning : 98.36% of all statistics are fiction, book release in April.
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
