Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291767AbSBTLZ4>; Wed, 20 Feb 2002 06:25:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291771AbSBTLZp>; Wed, 20 Feb 2002 06:25:45 -0500
Received: from mailout6-0.nyroc.rr.com ([24.92.226.125]:49216 "EHLO
	mailout6.nyroc.rr.com") by vger.kernel.org with ESMTP
	id <S291767AbSBTLZ1>; Wed, 20 Feb 2002 06:25:27 -0500
Message-ID: <00ee01c1ba01$6a1c0780$1a01a8c0@allyourbase>
From: "Dan Maas" <dmaas@dcine.com>
To: "A Guy Called Tyketto" <tyketto@wizard.com>
Cc: "lee johnson" <lee@imyourhandiman.com>, <linux-kernel@vger.kernel.org>
In-Reply-To: <fa.gr3ai1v.1p7i906@ifi.uio.no> <fa.fklcr8v.121289b@ifi.uio.no>
Subject: Re: opengl-nvidia not compiling
Date: Wed, 20 Feb 2002 06:26:17 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >  > nv.c:1438: incompatible type for argument 4 of
> > `remap_page_range_Reb32c755'
> >  > nv.c:1438: too few arguments to function `remap_page_range_Reb32c755'

>         Just to add something related, but unrelated to the
> NVIDIA problem above, this is the same exact error I received when
> I compiled any kernel > 2.5.2 with ALSA 0.5.* and ALSA 0.9.*.

What happened was remap_page_range sprouted a new first argument - the vma
you are mapping into. If you know even a tiny bit of C you can fix it
yourself; just look for the nearest variable of type 'struct
vm_area_struct*', and prepend it to the other args.

Not that everything is guaranteed to work even if it compiles... NVIDIA
cards do some very unusual fiddling with memory mappings and page tables, so
VM changes are just as likely to break their driver...

Regards,
Dan

