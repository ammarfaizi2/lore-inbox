Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267094AbSLRBXF>; Tue, 17 Dec 2002 20:23:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267096AbSLRBXF>; Tue, 17 Dec 2002 20:23:05 -0500
Received: from fmr02.intel.com ([192.55.52.25]:2302 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id <S267094AbSLRBXD> convert rfc822-to-8bit; Tue, 17 Dec 2002 20:23:03 -0500
content-class: urn:content-classes:message
Subject: RE: Intel P6 vs P7 system call performance
Date: Tue, 17 Dec 2002 17:30:59 -0800
Message-ID: <3014AAAC8E0930438FD38EBF6DCEB564419C95@fmsmsx407.fm.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Intel P6 vs P7 system call performance
Thread-Index: AcKmAj2Tda3UoRH1EdeNCQBQi+Bs2AAMYIPg
X-MimeOLE: Produced By Microsoft Exchange V6.0.6334.0
From: "Nakajima, Jun" <jun.nakajima@intel.com>
To: "Ulrich Drepper" <drepper@redhat.com>,
       "Linus Torvalds" <torvalds@transmeta.com>
Cc: "Matti Aarnio" <matti.aarnio@zmailer.org>,
       "Hugh Dickins" <hugh@veritas.com>,
       "Dave Jones" <davej@codemonkey.org.uk>, "Ingo Molnar" <mingo@elte.hu>,
       <linux-kernel@vger.kernel.org>, <hpa@transmeta.com>
X-OriginalArrivalTime: 18 Dec 2002 01:30:59.0947 (UTC) FILETIME=[1EC48BB0:01C2A635]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

AMD (at least Athlon, as far as I know) supports sysenter/sysexit. We tested it on an Athlon box as well, and it worked fine. And sysenter/sysexit was better than int/iret too (about 40% faster) there. 

Jun

> -----Original Message-----
> From: Ulrich Drepper [mailto:drepper@redhat.com]
> Sent: Tuesday, December 17, 2002 11:19 AM
> To: Linus Torvalds
> Cc: Matti Aarnio; Hugh Dickins; Dave Jones; Ingo Molnar; linux-
> kernel@vger.kernel.org; hpa@transmeta.com
> Subject: Re: Intel P6 vs P7 system call performance
> 
> Linus Torvalds wrote:
> 
> > In the meantime, I do agree with you that the TLS approach should work
> > too, and might be better. It will allow all six arguments to be used if
> we
> > just find a good calling conventions
> 
> If you push out the AT_* patch I'll hack the glibc bits (probably the
> TLS variant).  Won't take too  long, you'll get results this afternoon.
> 
> What about AMD's instruction?  Is it as flawed as sysenter?  If not and
> %ebp is available I really should use the TLS method.
> 
> --
> --------------.                        ,-.            444 Castro Street
> Ulrich Drepper \    ,-----------------'   \ Mountain View, CA 94041 USA
> Red Hat         `--' drepper at redhat.com `---------------------------
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
