Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271985AbRIENXN>; Wed, 5 Sep 2001 09:23:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272172AbRIENXD>; Wed, 5 Sep 2001 09:23:03 -0400
Received: from dns.lineo.fr ([194.250.46.228]:13809 "EHLO mailhost.lineo.fr")
	by vger.kernel.org with ESMTP id <S271985AbRIENWx>;
	Wed, 5 Sep 2001 09:22:53 -0400
Date: Wed, 5 Sep 2001 15:23:12 +0200
From: christophe =?iso-8859-1?Q?barb=E9?= <christophe.barbe@lineo.fr>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.9-ac6
Message-ID: <20010905152312.A11004@pc8.lineo.fr>
In-Reply-To: <20010905145039.A10655@pc8.lineo.fr> <1269703968.999699248@[169.254.198.40]>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
In-Reply-To: <1269703968.999699248@[169.254.198.40]>; from linux-kernel@alex.org.uk on mer, sep 05, 2001 at 15:14:09 +0200
X-Mailer: Balsa 1.2.pre3
X-Operating-System: Debian SID GNU/Linux 2.4.9 on i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Le mer, 05 sep 2001 15:14:09, Alex Bligh - linux-kernel a écrit :
> > Would it not be possible with your scheme to package a closed source
> > driver in an open source wrapper driver and then defeat your tainting
> > technique.
> 
> It would also be theoretically possible for an evil driver merchant
> to twiddle the flag back via /dev/kmem (for instance). Or load the
> module by manipulation of /dev/kmem. Or for the bug-reporting user
> to patch their kernel so that the flag never got set and hence
> disguise the presence of an nvidia driver (etc.) in a misguided
> attempt to wangle support out of Alan et al.
> 
> However, I understood the point of the exercize to be a first pass
> hueristic to flag bug reports from systems running modules for
> which Alan and others haven't got, and can't get the source. It's
> not going to be perfect (see above), but equally doesn't need to be.
> I'm sure users do all sorts of other 'well don't do that, then'
> stuff which wastes the time of those reading bug reports.

Yes I agree that's not easy and certainly not the goal to avoid this kind
of thing.

Btw I was thinking about a real case: I use in my laptop the lucent driver
for their winmodem chipset. This driver is closed source but we use it
relinked with proper opensource code. This avoid the use of 'insmod -f' and
most of the bug (caused by missing symbols) but you can not trust the
resulting module.

Christophe

> --
> Alex Bligh
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 
-- 
Christophe Barbé
Software Engineer - christophe.barbe@lineo.fr
Lineo France - Lineo High Availability Group
42-46, rue Médéric - 92110 Clichy - France
phone (33).1.41.40.02.12 - fax (33).1.41.40.02.01
http://www.lineo.com
