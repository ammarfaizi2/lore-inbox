Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277966AbRJ1Jnq>; Sun, 28 Oct 2001 04:43:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277968AbRJ1Jnh>; Sun, 28 Oct 2001 04:43:37 -0500
Received: from wiprom2mx1.wipro.com ([203.197.164.41]:24824 "EHLO
	wiprom2mx1.wipro.com") by vger.kernel.org with ESMTP
	id <S277966AbRJ1JnT>; Sun, 28 Oct 2001 04:43:19 -0500
Message-ID: <01bc01c15f95$4b6d88c0$4cb2a8c0@wipro.com>
From: "Anand Ashok Kulkarni" <anand.karni@wipro.com>
To: <linux-kernel@vger.kernel.org>
In-Reply-To: <20011026013101.A1404@redhat.com> <Pine.GSO.3.96.1011026113847.14048A-100000@delta.ds2.pg.gda.pl> <20011026100346.C1663@redhat.com>
Subject: Module loading and Kernel crash
Date: Sun, 28 Oct 2001 15:08:35 +0530
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="------------InterScan_NT_MIME_Boundary"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a multi-part message in MIME format.

--------------InterScan_NT_MIME_Boundary
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

I have written a module which takes the packet from the kernel, stores some
number of packets and then sends all if them out. But some how the kernel
crashes after working for some time. how can i take care of that. the
enqueing and dequeing functions take action on the same piece of memory.
will using task queues for both of them work ?
I have tried doin it...but even then the kernel konks.:-(




----- Original Message -----
From: "Richard Henderson" <rth@redhat.com>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: <torvalds@transmeta.com>; <alan@redhat.com>;
<linux-kernel@vger.kernel.org>
Sent: Friday, October 26, 2001 10:33 PM
Subject: Re: alpha 2.4.13: fix taso osf emulation


> On Fri, Oct 26, 2001 at 12:01:10PM +0200, Maciej W. Rozycki wrote:
> >  The following trivial patch reportedly fixes OSF/1 programs using
31-bit
> > addressing.  It's already present in the -ac tree; I guess it just got
> > lost during a merge.  It applies fine to 2.4.13.
>
> This is the patch that Jay Estabrook forwarded me that I rejected
> in favour of writing a special arch_get_unmapped_area.
>
> > It used to do so.  It breaks things such as dynamic linking of shared
> > objects linked at high load address.
>
> Err, how?
>
> > It breaks mmap() in principle, as it shouldn't fail when invoked with
> > a non-zero, non-MAP_FIXED, invalid address if there is still address
> > space available elsewhere.
>
> No, it doesn't.  Or rather, it only does if you only bothered
> to search once.  IMO one should search thrice: once at addr,
> once at TASK_UNMAPPED_BASE, and once at PAGE_SIZE.
>
>
>
> r~
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


--------------InterScan_NT_MIME_Boundary
Content-Type: text/plain;
	name="Wipro_Disclaimer.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="Wipro_Disclaimer.txt"

-----------------------------------------------------------------------------------------------------------------------
Information transmitted by this E-MAIL is proprietary to Wipro and/or its Customers and
is intended for use only by the individual or entity to which it is
addressed, and may contain information that is privileged, confidential or
exempt from disclosure under applicable law. If you are not the intended
recipient or it appears that this mail has been forwarded to you without
proper authority, you are notified that any use or dissemination of this
information in any manner is strictly prohibited. In such cases, please
notify us immediately at mailto:mailadmin@wipro.com and delete this mail
from your records.
------------------------------------------------------------------------------------------------------------------------

--------------InterScan_NT_MIME_Boundary--
