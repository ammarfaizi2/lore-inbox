Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262805AbTLIEyk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 23:54:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262827AbTLIEyk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 23:54:40 -0500
Received: from fmr05.intel.com ([134.134.136.6]:15043 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S262805AbTLIEyi convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 23:54:38 -0500
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: [PATCH][RFC] make cpu_sibling_map a cpumask_t
Date: Mon, 8 Dec 2003 20:54:31 -0800
Message-ID: <7F740D512C7C1046AB53446D37200173341707@scsmsx402.sc.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH][RFC] make cpu_sibling_map a cpumask_t
Thread-Index: AcO9zaPNNRtUXu4FSsyqXwsuopyO3wAQrzfg
From: "Nakajima, Jun" <jun.nakajima@intel.com>
To: "Zwane Mwaikambo" <zwane@arm.linux.org.uk>,
       "Nick Piggin" <piggin@cyberone.com.au>
Cc: "Ingo Molnar" <mingo@redhat.com>, "Anton Blanchard" <anton@samba.org>,
       "Linus Torvalds" <torvalds@osdl.org>, "Andrew Morton" <akpm@osdl.org>,
       "Rusty Russell" <rusty@rustcorp.com.au>,
       "linux-kernel" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 09 Dec 2003 04:54:31.0928 (UTC) FILETIME=[88BBF780:01C3BE10]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > It turns the cpu_sibling_map array from an array of cpus to an array
> > of cpumasks. This allows handling of more than 2 siblings, not that
> > I know of any immediate need.
We need this sooner or later.

	Jun
> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org [mailto:linux-kernel-
> owner@vger.kernel.org] On Behalf Of Zwane Mwaikambo
> Sent: Monday, December 08, 2003 12:51 PM
> To: Nick Piggin
> Cc: Ingo Molnar; Anton Blanchard; Linus Torvalds; Andrew Morton; Rusty
> Russell; linux-kernel
> Subject: Re: [PATCH][RFC] make cpu_sibling_map a cpumask_t
> 
> On Mon, 8 Dec 2003, Nick Piggin wrote:
> 
> > It turns the cpu_sibling_map array from an array of cpus to an array
> > of cpumasks. This allows handling of more than 2 siblings, not that
> > I know of any immediate need.
> >
> > I think it generalises cpu_sibling_map sufficiently that it can
become
> > generic code. This would allow architecture specific code to build
the
> > sibling map, and then Ingo's or my HT implementations to build their
> > scheduling descriptions in generic code.
> >
> > I'm not aware of any reason why the kernel should not become
generally
> > SMT aware. It is sufficiently different to SMP that it is worth
> > specialising it, although I am only aware of P4 and POWER5
> implementations.
> 
> Generally i agree, it's fairly unintrusive and appears to clean up
some
> things. Perhaps Andrew will take it a bit later after release.
> 
> > P.S.
> > I have an alternative to Ingo's HT scheduler which basically does
> > the same thing. It is showing a 20% elapsed time improvement with a
> > make -j3 on a 2xP4 Xeon (4 logical CPUs).
> 
> -j3 is an odd number, what does -j4, -j8, -j16 look like?
