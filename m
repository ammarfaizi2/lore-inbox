Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317366AbSHJX4q>; Sat, 10 Aug 2002 19:56:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317373AbSHJX4q>; Sat, 10 Aug 2002 19:56:46 -0400
Received: from faui02.informatik.uni-erlangen.de ([131.188.30.102]:25500 "EHLO
	faui02.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id <S317366AbSHJX4p>; Sat, 10 Aug 2002 19:56:45 -0400
Date: Sun, 11 Aug 2002 01:13:44 +0200
From: Richard Zidlicky <rz@linux-m68k.org>
To: Daniel Egger <degger@fhm.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: mmapping large files hits swap in 2.4?
Message-ID: <20020811011344.A1299@linux-m68k.org>
References: <1028913975.3832.14.camel@sonja.de.interearth.com> <20020810141201.A1868@linux-m68k.org> <1028996245.8172.19.camel@sonja.de.interearth.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1028996245.8172.19.camel@sonja.de.interearth.com>; from degger@fhm.edu on Sat, Aug 10, 2002 at 06:17:25PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 10, 2002 at 06:17:25PM +0200, Daniel Egger wrote:
> Am Sam, 2002-08-10 um 14.12 schrieb Richard Zidlicky:
> 
> > seems like you are doing something else, like hitting all
> > of the file.
>  
> > # uname -a
> > Linux sirizidl.dialin.rrze.uni-erlangen.de 2.4.18 #27 Wed Jul 24 17:25:39 CEST 2002 m68k unknown
>  
> > main()
> > {
> >   char *area;
> >   int fd=open("/msrc/linux/distr/cd.image", O_RDWR);
> >   area = mmap (0, 168088*4096, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
> >   if (area == -1) perror("mmap");
> > }
> 
> Heh. Well of course I'm also trying to use the memory I mmaped. :)
> It is just that it seems the mmaped region is not really bakked by
> the underlying file but by swap space which was exactly what I 
> was trying to avoid by using a file.

still works as expected for me, accessing a 650 MB file with only 
about 350 MB swap is no problem. It takes some time on that old
m68k box but clearly dominated by HD read time.. a compilation 
runing in the background doesn't seem to make any difference
at all.

Richard
