Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262186AbTJAS4F (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 14:56:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262196AbTJAS4F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 14:56:05 -0400
Received: from fmr09.intel.com ([192.52.57.35]:741 "EHLO hermes.hd.intel.com")
	by vger.kernel.org with ESMTP id S262186AbTJASz7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 14:55:59 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: Dave Jones: Fix cache size of Centrino CPU
Date: Wed, 1 Oct 2003 11:55:45 -0700
Message-ID: <7F740D512C7C1046AB53446D3720017304AFD6@scsmsx402.sc.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Dave Jones: Fix cache size of Centrino CPU
Thread-Index: AcOIS4EbFrhcwe3mSX6+MnHiaEJxQgAARmfw
From: "Nakajima, Jun" <jun.nakajima@intel.com>
To: "Dave Jones" <davej@redhat.com>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Cc: "Marcelo Tossati" <marcelo.tosatti@cyclades.com.br>
X-OriginalArrivalTime: 01 Oct 2003 18:55:45.0763 (UTC) FILETIME=[9EFB3B30:01C3884D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just curious. Why do we want to know L1D/L1I cache size? If you do, then
you might want to know the associativity and line size as well.
	
	Jun
> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org [mailto:linux-kernel-
> owner@vger.kernel.org] On Behalf Of Dave Jones
> Sent: Wednesday, October 01, 2003 11:33 AM
> To: Linux Kernel Mailing List
> Cc: Marcelo Tossati
> Subject: Re: Dave Jones: Fix cache size of Centrino CPU
> 
> On Wed, Oct 01, 2003 at 03:45:39PM +0000, Linux Kernel wrote:
>  > ChangeSet 1.1136.2.9, 2003/10/01 12:45:39-03:00,
marcelo@dmt.cyclades
>  >
>  > 	  Dave Jones: Fix cache size of Centrino CPU
>  >
>  >
>  > # This patch includes the following deltas:
>  > #	           ChangeSet	1.1136.2.8 -> 1.1136.2.9
>  > #	arch/i386/kernel/setup.c	1.73    -> 1.74
>  > #
>  >
>  >  setup.c |    2 ++
>  >  1 files changed, 2 insertions(+)
>  >
>  >
>  > diff -Nru a/arch/i386/kernel/setup.c b/arch/i386/kernel/setup.c
>  > --- a/arch/i386/kernel/setup.c	Wed Oct  1 11:05:23 2003
>  > +++ b/arch/i386/kernel/setup.c	Wed Oct  1 11:05:23 2003
>  > @@ -2291,6 +2291,8 @@
>  >  	{ 0x83, LVL_2,      512 },
>  >  	{ 0x84, LVL_2,      1024 },
>  >  	{ 0x85, LVL_2,      2048 },
>  > +	{ 0x86, LVL_2,      512 },
>  > +	{ 0x87, LVL_2,      1024 },
>  >  	{ 0x00, 0, 0}
>  >  };
>  >
>  > -
> 
> You seem to have dropped the first hunk of the diff.
> 
> 		Dave
> 
> 
> --- 1/arch/i386/kernel/setup.c~	2003-09-22 15:48:24.000000000
+0100
> +++ 2/arch/i386/kernel/setup.c	2003-09-22 15:49:33.000000000
+0100
> @@ -2296,6 +2296,8 @@
>  	{ 0x23, LVL_3,      1024 },
>  	{ 0x25, LVL_3,      2048 },
>  	{ 0x29, LVL_3,      4096 },
> +	{ 0x2c, LVL_1_DATA, 32 },
> +	{ 0x30, LVL_1_INST, 32 },
>  	{ 0x39, LVL_2,      128 },
>  	{ 0x3b, LVL_2,      128 },
>  	{ 0x3C, LVL_2,      256 },
> 
> 
> 
> 
> --
>  Dave Jones     http://www.codemonkey.org.uk
> -
> To unsubscribe from this list: send the line "unsubscribe
linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
