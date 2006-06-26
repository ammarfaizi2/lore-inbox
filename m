Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751258AbWFZUrq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751258AbWFZUrq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 16:47:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751256AbWFZUrq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 16:47:46 -0400
Received: from mga03.intel.com ([143.182.124.21]:25727 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S1751254AbWFZUrp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 16:47:45 -0400
X-IronPort-AV: i="4.06,177,1149490800"; 
   d="scan'208"; a="57649243:sNHT7544409873"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [patch] ACPI: reduce code size, clean up, fix validator message
Date: Mon, 26 Jun 2006 13:42:11 -0700
Message-ID: <B28E9812BAF6E2498B7EC5C427F293A48379C2@orsmsx415.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [patch] ACPI: reduce code size, clean up, fix validator message
Thread-Index: AcaZP46V/Fjuwc1OQFiQiAjs1R6fqAAAlYtgAAeOpBA=
From: "Moore, Robert" <robert.moore@intel.com>
To: "Brown, Len" <len.brown@intel.com>, "Pavel Machek" <pavel@ucw.cz>
Cc: "Ingo Molnar" <mingo@elte.hu>, "Andrew Morton" <akpm@osdl.org>,
       <michal.k.k.piotrowski@gmail.com>, <arjan@linux.intel.com>,
       <linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
       "Arjan van de Ven" <arjan@infradead.org>
X-OriginalArrivalTime: 26 Jun 2006 20:42:12.0065 (UTC) FILETIME=[002FD510:01C69961]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Everyone should keep in mind that eventually, the ACPICA code can be
fully integrated into each host operating system and then maintained by
the individual OS projects.

During the time that Intel is actively developing and supporting the
ACPICA code, we need the OS-independent interfaces to provide
portability across the dozen or so host operating systems that are
currently supported.

Yes, of course there is some inefficiency in not using the native OS
interfaces. However, this is really the only sane way to support so many
different hosts, and all OS projects get the benefit of debugging help
and feedback from the many different operating systems.

Bob


> -----Original Message-----
> From: Brown, Len
> Sent: Monday, June 26, 2006 10:40 AM
> To: Pavel Machek
> Cc: Ingo Molnar; Andrew Morton; michal.k.k.piotrowski@gmail.com;
> arjan@linux.intel.com; linux-kernel@vger.kernel.org; linux-
> acpi@vger.kernel.org; Moore, Robert; Arjan van de Ven
> Subject: RE: [patch] ACPI: reduce code size, clean up, fix validator
> message
> 
> 
> >Well, gain here is that code actually becomes readable/linux
> >like/something.
> >
> >Feel free to put GPL/BSD license in ACPICA code, saying that by
> >default contributed code is under both licenses.... or something, but
> >having linux-like code under drivers/acpi would be great.
> 
> There is drivers/acpi/*.c
> This is pure GPL and can be as "Linux like" as any purist wants it to
be.
> Indeed, we have several patches in the queue to do just that in
2.6.18.
> 
> and there is drivers/acpi/*/*.c, which is from ACPICA.
> Linux, along with a bunch of other OS's, is downstream.
> 
> The license on ACPICA is not the issue.
> The issue is when we make a syntax change to ACPICA in Linux,
> then it adds to (my) workload to keep Linux up to date with the
upstream
> ACPICA.
> 
> (note that the previous Linux/ACPI maintainer dealt with this issue
>  by simply over-writing the ACPICA files in Linux upon every update.
>  I allow divergence, but I have to track it, it causes merge
conflicts,
>  and Bob and I actively work to change ACPICA upstream to minimize
it.)
> 
> If you have specific feedback on what can be improved,
> I'm certainly willing to listen.  As you may be aware,
> I translate every ACPICA change into Linux format, and
> it is possible that this process can be enhanced.
> 
> Keep in perspective, however, that we have over 200
> functional issues unresolved in bugzilla.kernel.org,
> and spending time on syntax changes is generally
> a lower priority.
> 
> -Len
