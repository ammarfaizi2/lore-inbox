Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133063AbRDRJLR>; Wed, 18 Apr 2001 05:11:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133062AbRDRJK6>; Wed, 18 Apr 2001 05:10:58 -0400
Received: from smtp1.libero.it ([193.70.192.51]:25507 "EHLO smtp1.libero.it")
	by vger.kernel.org with ESMTP id <S133061AbRDRJKp>;
	Wed, 18 Apr 2001 05:10:45 -0400
Message-ID: <3ADD5A0B.97A6AF9B@alsa-project.org>
Date: Wed, 18 Apr 2001 11:10:35 +0200
From: Abramo Bagnara <abramo@alsa-project.org>
Organization: Opera Unica
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.19 i586)
X-Accept-Language: it, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@mandrakesoft.com>
CC: Pavel Machek <pavel@suse.cz>, torvalds@transmeta.com,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: i386 cleanups
In-Reply-To: <20010417232614.A4377@bug.ucw.cz> <3ADCCA57.2A354359@mandrakesoft.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> 
> Pavel Machek wrote:
> >
> > Hi!
> >
> > These are tiny cleanups you might like. sizes are "logically"
> > long. No, it does not matter on i386.
> >
> > processor.h makes INIT_TSS look much more readable. [Please tell me
> > applied or rejected]
> >
> >                                                         Pavel
> >
> > Index: include/asm-i386/posix_types.h
> > ===================================================================
> > RCS file: /home/cvs/Repository/linux/include/asm-i386/posix_types.h,v
> > retrieving revision 1.1.1.1
> > diff -u -u -r1.1.1.1 posix_types.h
> > --- include/asm-i386/posix_types.h      2000/09/04 16:50:33     1.1.1.1
> > +++ include/asm-i386/posix_types.h      2001/02/13 13:49:18
> > @@ -16,9 +16,9 @@
> >  typedef unsigned short __kernel_ipc_pid_t;
> >  typedef unsigned short __kernel_uid_t;
> >  typedef unsigned short __kernel_gid_t;
> > -typedef unsigned int   __kernel_size_t;
> > -typedef int            __kernel_ssize_t;
> > -typedef int            __kernel_ptrdiff_t;
> > +typedef unsigned long  __kernel_size_t;
> > +typedef long           __kernel_ssize_t;
> > +typedef long           __kernel_ptrdiff_t;
> 
> If it doesn't matter on i386 why bother?

It helps with printf %-formats to avoid some arch specific warnings.


-- 
Abramo Bagnara                       mailto:abramo@alsa-project.org

Opera Unica                          Phone: +39.546.656023
Via Emilia Interna, 140
48014 Castel Bolognese (RA) - Italy

ALSA project               http://www.alsa-project.org
It sounds good!
