Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314889AbSECRvH>; Fri, 3 May 2002 13:51:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314900AbSECRvF>; Fri, 3 May 2002 13:51:05 -0400
Received: from beasley.gator.com ([63.197.87.202]:15880 "EHLO
	beasley.gator.com") by vger.kernel.org with ESMTP
	id <S314889AbSECRvD>; Fri, 3 May 2002 13:51:03 -0400
From: "George Bonser" <george@gator.com>
To: "Russell Leighton" <russ@elegant-software.com>,
        <linux-kernel@vger.kernel.org>
Subject: RE: Linux 2.4 as a router, when is it appropriate?
Date: Fri, 3 May 2002 10:51:01 -0700
Message-ID: <CHEKKPICCNOGICGMDODJIEBJHIAA.george@gator.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
In-Reply-To: <3CD28FB8.40204@elegant-software.com>
X-MIMEOLE: Produced By Microsoft MimeOLE V5.50.4910.0300
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have used Linux/Zebra in production as a route reflector. That
machine was simply a BGP peer of the others and not directly in the
traffic path. That configuration had several commercial border routers
(actually L2/3 switches) collecting full Internet routes from their
upstream peers. These border routers fed their routing table via BGP
to the Linux route reflector. The Linux/Zebra box aggregated the
table, applied various policy to the routes received, and sent the
resulting table on to the core routers.

The reason for using Linux in this case was the large amount of memory
required for handling all the peers. Zebra handled it just fine and
you can just keep adding RAM to a PC. To get the same capability in a
commercial unit you have to get some very expensive iron.  This
allowed the border units to be relatively inexpensive with only enough
RAM to handle 1 Internet peer with full routes and kept the core
router CPU free to handle traffic rather than process routes so it
could also be a lower cost unit than would otherwise be required.

The unit was in production for over a year without a single reboot.




> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org
> [mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of
> Russell Leighton
> Sent: Friday, May 03, 2002 6:25 AM
> To: linux-kernel@vger.kernel.org
> Subject: Linux 2.4 as a router, when is it appropriate?
>
>
>
> Could someone please tell me (or refer me to docs) on when
> using the Linux on PC hardware as a router is an appropriate
> solution and when one should consider a "real" router (e.g., Cisco)?
>
> I have heard that performance wise, if you have a fast CPU,
> much memory and good NICs that Linux can be as good
> all but the high end routers. Are there important missing
> features or realiability issues that make using Linux not
> suitable for "enterprise" use?
>
> Thanks.
>
> Russ
>
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

