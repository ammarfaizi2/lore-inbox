Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751188AbWEVVHS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751188AbWEVVHS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 17:07:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751189AbWEVVHR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 17:07:17 -0400
Received: from ns.dynamicweb.hu ([195.228.155.139]:53913 "EHLO dynamicweb.hu")
	by vger.kernel.org with ESMTP id S1751188AbWEVVHP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 17:07:15 -0400
Message-ID: <047401c67de3$a05a52c0$1800a8c0@dcccs>
From: =?iso-8859-1?Q?Haar_J=E1nos?= <djani22@netcenter.hu>
To: "Con Kolivas" <kernel@kolivas.org>
Cc: <nickpiggin@yahoo.com.au>, <cw@f00f.org>, <linux-kernel@vger.kernel.org>
References: <00e901c67cad$fe9a9d90$1800a8c0@dcccs> <200605222117.27433.kernel@kolivas.org> <031001c67db1$a8c4a1e0$1800a8c0@dcccs> <200605230112.45564.kernel@kolivas.org>
Subject: Re: swapper: page allocation failure. - random reboot problem
Date: Mon, 22 May 2006 23:06:35 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1437
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


----- Original Message ----- 
From: "Con Kolivas" <kernel@kolivas.org>
To: "Haar János" <djani22@netcenter.hu>
Cc: <nickpiggin@yahoo.com.au>; <cw@f00f.org>; <linux-kernel@vger.kernel.org>
Sent: Monday, May 22, 2006 5:12 PM
Subject: Re: swapper: page allocation failure.


> On Tuesday 23 May 2006 01:08, Haar János wrote:
> > ----- Original Message -----
> > From: "Con Kolivas" <kernel@kolivas.org>
> > > Try with one of the alternative vmsplit options that gives you more
> >
> > lowmem?
> >
> > > That might break certain applications though.
> >
> >              total       used       free     shared    buffers
cached
> > Mem:       4049724    4021196      28528          0      16384
3217288
> > Low:       4049724    4021196      28528
> > High:            0          0          0
> > -/+ buffers/cache:     787524    3262200
> > Swap:            0          0          0
> >
> > This is an 64 bit machine, the "concentrator".
> >
> > It looks like use all, the 4G ram as "lowmem".
> > If i replace the cpu on my nodes to 64bit capable ones, i can use all
the
> > memory as buffer-cache? :-)
>
> Heh yes indeed. It's only if you're stuck on 32bit for whatever reason
that
> you'd need a different vmsplit. There is no need for highmem when 64bit
> allows bazillions of bytes of lowmem :)

OK, it is enough, to switch to 64bit, thanks!

But i have a little problem.
My node #3 reboots again.

At this point i have run out of ideas. :-(

This is checked already:

- the complete hardware, except the 12 hdd. (smart reports, no errors at
all, 4x ide + 8xSATA all 300GB.)
- the SMP race. (checked with non-smp kernel)
- APIC/ACPI (tested with non...  kernel)
- the e1000 driver (tested with realtek gige adapter)
- the complete filesystem, OS (NFS-ROOT, and copy between nodes.)
- the memory allocation proble, (checked with debug-kernel, and rised
min_free_kbytes)

The systems only service is nbd. (nbd-server serving md0, raid4 array)

Anybody have an idea?

Please let me know!

Thanks,
Janos



>
> -- 
> -ck
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

