Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269010AbUHXEJA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269010AbUHXEJA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 00:09:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269019AbUHXEJA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 00:09:00 -0400
Received: from [202.125.86.130] ([202.125.86.130]:50935 "EHLO
	ns2.astrainfonets.net") by vger.kernel.org with ESMTP
	id S269010AbUHXEIx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 00:08:53 -0400
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Support for HIGHMEM ...can any one explain my Q&A ..
X-MimeOLE: Produced By Microsoft Exchange V6.5.6944.0
Date: Tue, 24 Aug 2004 09:40:03 +0530
Message-ID: <4EE0CBA31942E547B99B3D4BFAB348110B13B6@mail.esn.co.in>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Support for HIGHMEM ...can any one explain my Q&A ..
Thread-Index: AcSJHfYfph5m/MuwSRCTVv1fl+JftQAb3mbA
From: "Mukund JB." <mukundjb@esntechnologies.co.in>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks a lot for the response.
Will u be able to provide me a link that will be able to help in making
this PAGE-OFFSET and related issues more clear.

Also, it seems to be whats going on here is high-end expertise level
stuff.

I am new to Driver Writing even though I was working on linux before
this. So, will u be able to suggest me a list where in I can post my
basic issues about Memory management issues, Time Control issues and
Driver Control, so on.

Or else is it ok if I post them here.


Thanks for that again.

Regards,
Mukund jampala


-----Original Message-----
From: eric@ebiederm.dsl.xmission.com
[mailto:eric@ebiederm.dsl.xmission.com] On Behalf Of Eric W. Biederman
Sent: Monday, August 23, 2004 7:59 PM
To: Mukund JB.
Cc: linux-kernel@vger.kernel.org
Subject: Re: Support for HIGHMEM ...can any one explain my Q&A ..

"Mukund JB." <mukundjb@esntechnologies.co.in> writes:

> Hi all,
> Sorry if I asked any thing that basic level stuff?
> This is the paasge I found in the net while surfing for details about
> HIGHMEM stuff.
> 
> During 2.3 kernel development (I think), "HIGHMEM" support was added.
> Normally, the kernel can only address (4GB-PAGE_OFFSET)/PAGE_SIZE
pages
> of RAM, since all physical pages must be mapped to kernel addresses
> between PAGE_OFFSET and 4GB. (So if PAGE_OFFSET is 3GB, only 1GB of
> physical RAM can be used - not even that, in practice, due to fixed
> kernel mappings and so forth.) The HIGHMEM patches allow the kernel to
> use more than 1G of memory by mapping the additional pages into the
high
> part of the kernel address space just below 4GB as necessary. They
also
> allow high-memory pages to be mapped into user process address space.
> 
> 
> ***) Does the above passage mean that PAGE_OFFSET is the starting
> address of my RAM ?

No.  PAGE_OFFSET is the virtual address at which physical address
0 is mapped into an arch/i386 kernel.  

> I understood so from the below line
> "since all physical pages must be mapped to kernel addresses between
> PAGE_OFFSET and 4GB".
> 
> ***) Does it mean that the lowest portion of the 4GB os nothing but
RAM
> ?

No.  0-PAGE_OFFSET is the virtual address space provided to user space.
So it has an arbitrary mapping to virtual memory.



Eric
