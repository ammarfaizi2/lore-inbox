Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932181AbVLPIgt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932181AbVLPIgt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 03:36:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932183AbVLPIgt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 03:36:49 -0500
Received: from ns.dynamicweb.hu ([195.228.155.139]:53914 "EHLO dynamicweb.hu")
	by vger.kernel.org with ESMTP id S932181AbVLPIgt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 03:36:49 -0500
Message-ID: <003d01c5eb51$3abb29f0$a700a8c0@dcccs>
From: "JaniD++" <djani22@dynamicweb.hu>
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Cc: <linux-kernel@vger.kernel.org>
References: <88056F38E9E48644A0F562A38C64FB6006A225B1@scsmsx403.amr.corp.intel.com>
Subject: Re: irq balancing question
Date: Thu, 17 Nov 2005 09:28:56 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1437
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


----- Original Message ----- 
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: "JaniD++" <djani22@dynamicweb.hu>
Cc: <linux-kernel@vger.kernel.org>
Sent: Thursday, December 15, 2005 3:00 PM
Subject: RE: irq balancing question


> >> >----- Original Message ----- 
> >> >From: "Arjan van de Ven" <arjan@infradead.org>
> >> >To: "JaniD++" <djani22@dynamicweb.hu>
> >> >> On Wed, 2005-12-14 at 22:05 +0100, JaniD++ wrote:
> >> >> > Hello, list,
> >> >> >
> >> >> > I try to tune my system with manually irq assigning, but
> >> >this simple not
> >> >> > works, and i don't know why. :(
> >> >> > I have already read all the documentation in the kernel
> >> >tree, and search
> >> >in
> >> >> > google, but i can not find any valuable reason.
> >> >>
> >> >>
> >> >> which chipset? there is a chipset that is broken wrt irq
> >balancing so
> >> >> the kernel refuses to do it there...
> >> >
> >> >This happens all of my systems, with different hardware.
> >> >
> >> >In the example is Intel SE7520AF2,  IntelR E7520 Chipset, +2x
> >> >Xeon with HT.
> >> >
> >> >And the other systems is Abit IS7, intel 865, and only one P4
> >> >CPU with HT,
> >> >but the issue is the same.
> >> >
> >>
> >> Which kernel and which architecture (i386 or x86-64?)
> >
> >i386, and kernel 2.6.14 - 2.6.15-rc3
>
> Things should work with 2.6.15-rc5.
> There was a bug with this that was fixed recently. The patch here
> http://kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commi
> t;h=fe655d3a06488c8a188461bca493e9f23fc8c448

Ahh, thanks! :-)
This fix the problem!

>
> >
> >(the intel xeon CPU can work x86-64 kernels?)
> >
>
> Yes. If your CPUs have EM64T capability, then they can run x86-64
> kernels.

OK, i will try it! ;-)

Thanks,
Janos

>
> Thanks,
> Venki
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

