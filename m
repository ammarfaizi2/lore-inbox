Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261869AbTJAByP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 21:54:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261879AbTJAByP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 21:54:15 -0400
Received: from fmr09.intel.com ([192.52.57.35]:36591 "EHLO hermes.hd.intel.com")
	by vger.kernel.org with ESMTP id S261869AbTJAByK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 21:54:10 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: [PATCH] Mutilated form of Andi Kleen's AMD prefetch errata patch
Date: Tue, 30 Sep 2003 18:54:06 -0700
Message-ID: <7F740D512C7C1046AB53446D3720017304AFCD@scsmsx402.sc.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] Mutilated form of Andi Kleen's AMD prefetch errata patch
Thread-Index: AcOHszBdyDriPBdlS56OuaZb2Piy6gACE9jA
From: "Nakajima, Jun" <jun.nakajima@intel.com>
To: "Andrew Morton" <akpm@osdl.org>, "Jamie Lokier" <jamie@shareable.org>
Cc: <davej@redhat.com>, <torvalds@osdl.org>, <linux-kernel@vger.kernel.org>,
       <richard.brunner@amd.com>
X-OriginalArrivalTime: 01 Oct 2003 01:54:06.0725 (UTC) FILETIME=[E5E85350:01C387BE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I think we should fix up userspace.
What do you mean by this? Patch user code at runtime (it's much more
complex than it sounds) or remove prefetch instructions from userspace?

	Jun

> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org [mailto:linux-kernel-
> owner@vger.kernel.org] On Behalf Of Andrew Morton
> Sent: Tuesday, September 30, 2003 5:27 PM
> To: Jamie Lokier
> Cc: davej@redhat.com; torvalds@osdl.org; linux-kernel@vger.kernel.org;
> richard.brunner@amd.com
> Subject: Re: [PATCH] Mutilated form of Andi Kleen's AMD prefetch
errata
> patch
> 
> Jamie Lokier <jamie@shareable.org> wrote:
> >
> > What I'd really like your opinion on is the appropriate userspace
> > behaviour.  If we don't care about fixing up userspace, then
> > __ex_table is a much tidier workaround for the prefetch bug.
> 
> I think we should fix up userspace.
> 
> >  If we do
> > care about fixing up userspace, then do we need a policy decision
that
> > says it's not acceptable to run on AMD without userspace fixups from
> > 2.6.0 onwards - it must fixup userspace or refuse to run?
> 
> If you're saying that the kernel should refuse to boot if it discovers
> that
> a) the CPU needs the workaround and b) the kernel does not implement
the
> workaround then yup.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe
linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
