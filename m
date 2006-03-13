Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964821AbWCMWgR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964821AbWCMWgR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 17:36:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964818AbWCMWgR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 17:36:17 -0500
Received: from odyssey.analogic.com ([204.178.40.5]:64530 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S964807AbWCMWgP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 17:36:15 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
in-reply-to: <925A849792280C4E80C5461017A4B8A20321F9@mail733.InfraSupportEtc.com>
x-originalarrivaltime: 13 Mar 2006 22:35:51.0561 (UTC) FILETIME=[7B8C9790:01C646EE]
Content-class: urn:content-classes:message
Subject: RE: Router stops routing after changing MAC Address
Date: Mon, 13 Mar 2006 17:35:50 -0500
Message-ID: <Pine.LNX.4.61.0603131730100.5785@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Router stops routing after changing MAC Address
Thread-Index: AcZG7nuWb5nT1zpwS3C2MchiHX5BgQ==
References: <925A849792280C4E80C5461017A4B8A20321F9@mail733.InfraSupportEtc.com>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Greg Scott" <GregScott@InfraSupportEtc.com>
Cc: "Rick Jones" <rick.jones2@hp.com>,
       "Chuck Ebbert" <76306.1226@compuserve.com>,
       "linux-kernel" <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
       "Bart Samwel" <bart@samwel.tk>, "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       "Simon Mackinlay" <smackinlay@mail.com>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 13 Mar 2006, Greg Scott wrote:

> Yup.
>
> I had a situation 2 weeks ago where a customer connected a system to the
> Internet with an IP Address he should not have used.  And the little
> Cisco router on the frontend dutifully recorded it in its ARP cache -
> forever, with no TTL!  This took down their webmail for most of a day
> until we finally had to cycle the power on that nasty little Cisco 678.
>
> Bigger routers do it too.  I've had several situations over the years
> where I replaced an older firewall with a newer one with the same IP
> Addresses.  All the internal servers find it soon enough.  But I've
> waited literally hours for the routers to finally purge their ARP caches
> so they would see my replacement systems - often with the customer
> looking over my shoulders getting more and more nervous by the minute.
>
> And sometimes the routers are not accessible - you can't cycle them even
> if you had permission.  Consider the cases of bridged DSL service -

Bzzzzst... Not! There are not any MAC addresses associated with any
of the intercity links, usually not even in WANs!  MAC is for
Ethernet! Once you go to fiber, ATM, T-N, etc., there are no
MAC addresses. That's why there are bridges and routers, you
got to "connect" your tiny time-slot to your LAN and that
first device contains the MAC address that all your other stuff
talks to.

> where the real router could be on the other side of the country.  Try
> calling an ISP and asking the tech on the other end to purge an ARP
> cache on a router.  So the same IP Addresses but different MAC
> addresses, all you can do is wait for the passage of (lots of) time.
> That happened to me in my own network once.  I accidently took down my
> email server for something like 4 hours one time when I got careless.
>
>> Indeed, there is a large onus on the software doing the MAC
>> override to make sure it does not break the required uniqueness.
>> Just as if one were using locally administered MAC addresses.
>
> Yes.  My 12:34:56 OUI scheme will work for this project but it is
> definitely not good for the long term.  I really really hope I have to
> spend some money with the IEEE soon to support lots and lots of
> rollouts.  :)
>
> - Greg Scott
>
>
>
> -----Original Message-----
> From: Rick Jones [mailto:rick.jones2@hp.com]
> Sent: Monday, March 13, 2006 3:50 PM
> To: linux-os (Dick Johnson)
> Cc: Greg Scott; Chuck Ebbert; linux-kernel; netdev@vger.kernel.org; Bart
> Samwel; Alan Cox; Simon Mackinlay
> Subject: Re: Router stops routing after changing MAC Address
>
> > Anyway, if the device fails, you have
>> routers and hosts ARPing the interface, trying to establish a route
>> anyway.
>
> But only after what may be a much longer time than the customer is
> willing to accept or able to configure.  I know of a number of HA
> situations where the "new" device is given the "old" MAC just to avoid
> that speicific situation of ARP caches not being updated except after
> quite some time.  Not necessarily on the end-systems, the issue can be
> with intermediate devices (routers).
>
> And if one has to work with static ARP entries to deal (however
> imperfectly) with ARP poisioning or whatnot...
>
> Indeed, there is a large onus on the software doing the MAC override to
> make sure it does not break the required uniqueness.  Just as if one
> were using locally administered MAC addresses.
>
> rick jones
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
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
