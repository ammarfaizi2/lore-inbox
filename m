Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264666AbTIJFvw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 01:51:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264670AbTIJFvw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 01:51:52 -0400
Received: from hermes.py.intel.com ([146.152.216.3]:30424 "EHLO
	hermes.py.intel.com") by vger.kernel.org with ESMTP id S264666AbTIJFvs convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 01:51:48 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: RE: [Patch] asm workarounds in generic header files
Date: Tue, 9 Sep 2003 22:51:39 -0700
Message-ID: <7F740D512C7C1046AB53446D3720017304AF2B@scsmsx402.sc.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [Patch] asm workarounds in generic header files
Thread-Index: AcN3WVcGwlp8seNhQLGtCBZ6AulCbwAAGPpQ
From: "Nakajima, Jun" <jun.nakajima@intel.com>
To: "Andrew Morton" <akpm@osdl.org>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>
Cc: <davidm@HPL.HP.COM>, <torvalds@osdl.org>, <jes@wildopensource.com>,
       <hch@infradead.org>, <linux-kernel@vger.kernel.org>,
       "Mallick, Asit K" <asit.k.mallick@intel.com>
X-OriginalArrivalTime: 10 Sep 2003 05:51:40.0314 (UTC) FILETIME=[9B08A7A0:01C3775F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, ECC is only for IA-64. ICC is for x86. ICC does not require
intrinsics because it supports asm inline, and it can build the kernel.
Please look at
http://lists.insecure.org/lists/linux-kernel/2002/Oct/8790.html for
example.

Note that asm inline support is just one of many GCC extensions required
to build the kernel, and for optimization purposes Intel compiler for
IA-64 chose not to support inline asm, but it uses intrinsic to do the
equivalent things.

Thanks,
Jun

> -----Original Message-----
> From: Andrew Morton [mailto:akpm@osdl.org]
> Sent: Tuesday, September 09, 2003 10:08 PM
> To: Siddha, Suresh B
> Cc: davidm@HPL.HP.COM; torvalds@osdl.org; jes@wildopensource.com;
> hch@infradead.org; linux-kernel@vger.kernel.org; Nakajima, Jun;
Mallick,
> Asit K
> Subject: Re: [Patch] asm workarounds in generic header files
> 
> "Siddha, Suresh B" <suresh.b.siddha@intel.com> wrote:
> >
> > --- linux/include/linux/compiler-intel.h	Wed Dec 31 16:00:00 1969
> >  +++ linux-/include/linux/compiler-intel.h	Tue Sep  9 21:34:19 2003
> >  @@ -0,0 +1,21 @@
> >  +/* Never include this file directly.  Include <linux/compiler.h>
> instead.  */
> >  +
> >  +#ifdef __ECC
> >  +
> >  +/* Some compiler specific definitions are overwritten here
> >  + * for Intel ECC compiler
> >  + */
> >  +
> >  +#include <asm/intrinsics.h>
> 
> This is ia64-only, yes?
> 
> Where do we stand with ECC/ia32 support?

