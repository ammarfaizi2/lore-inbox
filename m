Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268925AbRG0TD6>; Fri, 27 Jul 2001 15:03:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268926AbRG0TDi>; Fri, 27 Jul 2001 15:03:38 -0400
Received: from e23.nc.us.ibm.com ([32.97.136.229]:47576 "EHLO
	e23.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S268925AbRG0TDf>; Fri, 27 Jul 2001 15:03:35 -0400
Importance: Normal
Subject: Re: Subtleties of the 0.0.0.0 netmask (inet_ifa_match)
To: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
Cc: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.3  March 21, 2000
Message-ID: <OFA1B2627C.7E519218-ON85256A96.00641020@raleigh.ibm.com>
From: "Allen Lau" <pflau@us.ibm.com>
Date: Fri, 27 Jul 2001 15:03:29 -0400
X-MIMETrack: Serialize by Router on D04NMS38/04/M/IBM(Release 5.0.6 |December 14, 2000) at
 07/27/2001 03:03:39 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Alexey,

>> The inet_ifa_match function seems to be wrong with 0.0.0.0 netmask.
>...
>> The 0.0.0.0 netmask matches everything!
>
>Of course. Zero mask matches everything.

I agree that 0.0.0.0 netmask in a route entry (dest 0.0.0.0 mask 0.0.0.0)
matches everything.
However, it is intuitively different with an interface address.
Can an IP address be on every subnet (i.e. is 10.1.1.1 prefix 0 on every
subnet)?

I believe it is not right for inet_ifa_match to answer "yes" in the context of :
     is 9.9.9.9 on the same subnet as interface address 10.1.1.1 prefix 0?

>> Will there be any routing problems if we use the 0.0.0.0 netmask?
>
>No problems provided you wanted this.
>F.e. default route is route with netmask zero, it matches all,
>so that all the addresses are routed there.
>It is exactly which happens in your setup, but all the addresses
>fall to loopback.

>Looking at your original purpose, you wanted mask 255.255.255.255.

>Alexey

Allen Lau

