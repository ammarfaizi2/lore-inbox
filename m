Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317066AbSHJQWI>; Sat, 10 Aug 2002 12:22:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317068AbSHJQWI>; Sat, 10 Aug 2002 12:22:08 -0400
Received: from B5462.pppool.de ([213.7.84.98]:44187 "EHLO
	nicole.de.interearth.com") by vger.kernel.org with ESMTP
	id <S317066AbSHJQWH>; Sat, 10 Aug 2002 12:22:07 -0400
Subject: Re: mmapping large files hits swap in 2.4?
From: Daniel Egger <degger@fhm.edu>
To: Richard Zidlicky <rz@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020810141201.A1868@linux-m68k.org>
References: <1028913975.3832.14.camel@sonja.de.interearth.com> 
	<20020810141201.A1868@linux-m68k.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.7 
Date: 10 Aug 2002 18:17:25 +0200
Message-Id: <1028996245.8172.19.camel@sonja.de.interearth.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sam, 2002-08-10 um 14.12 schrieb Richard Zidlicky:

> seems like you are doing something else, like hitting all
> of the file.
 
> # uname -a
> Linux sirizidl.dialin.rrze.uni-erlangen.de 2.4.18 #27 Wed Jul 24 17:25:39 CEST 2002 m68k unknown
 
> main()
> {
>   char *area;
>   int fd=open("/msrc/linux/distr/cd.image", O_RDWR);
>   area = mmap (0, 168088*4096, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
>   if (area == -1) perror("mmap");
> }

Heh. Well of course I'm also trying to use the memory I mmaped. :)
It is just that it seems the mmaped region is not really bakked by
the underlying file but by swap space which was exactly what I 
was trying to avoid by using a file.
 
-- 
Servus,
       Daniel

