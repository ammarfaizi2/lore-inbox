Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262856AbREaQDE>; Thu, 31 May 2001 12:03:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263006AbREaQCz>; Thu, 31 May 2001 12:02:55 -0400
Received: from coruscant.franken.de ([193.174.159.226]:57356 "EHLO
	coruscant.gnumonks.org") by vger.kernel.org with ESMTP
	id <S262856AbREaQCq>; Thu, 31 May 2001 12:02:46 -0400
Date: Thu, 31 May 2001 12:52:25 -0300
From: Harald Welte <laforge@gnumonks.org>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: How to know HZ from userspace?
Message-ID: <20010531125225.O27719@corellia.laforge.distro.conectiva>
In-Reply-To: <20010530203725.H27719@corellia.laforge.distro.conectiva> <200105310340.f4V3eVF244481@saturn.cs.uml.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <200105310340.f4V3eVF244481@saturn.cs.uml.edu>; from acahalan@cs.uml.edu on Wed, May 30, 2001 at 11:40:30PM -0400
X-Operating-System: Linux corellia.laforge.distro.conectiva 2.4.3
X-Date: Today is Setting Orange, the 4th day of Confusion in the YOLD 3167
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 30, 2001 at 11:40:30PM -0400, Albert D. Cahalan wrote:
> Harald Welte writes:
> 
> > Is there any way to read out the compile-time HZ value of the kernel?
> > 
> > I had a brief look at /proc/* and didn't find anything.
> 
> Look again, this time with a sick mind. Got your barf bag?
> Kubys made me do it.

;) 

First of all thanks for your recommended solution.

>   /* actual values used by 2.4 kernels: 32 64 100 128 1000 1024 1200 */
>   switch(h){
>   case   30 ...   34 :  Hertz =   32; break; /* ia64 emulator */
>   case   48 ...   52 :  Hertz =   50; break;
>   case   58 ...   62 :  Hertz =   60; break;
>   case   63 ...   65 :  Hertz =   64; break; /* StrongARM /Shark */
>   case   95 ...  105 :  Hertz =  100; break; /* normal Linux */
>   case  124 ...  132 :  Hertz =  128; break; /* MIPS, ARM */
>   case  195 ...  204 :  Hertz =  200; break; /* normal << 1 */
>   case  253 ...  260 :  Hertz =  256; break;
>   case  393 ...  408 :  Hertz =  400; break; /* normal << 2 */
>   case  790 ...  808 :  Hertz =  800; break; /* normal << 3 */
>   case  990 ... 1010 :  Hertz = 1000; break; /* ARM */
>   case 1015 ... 1035 :  Hertz = 1024; break; /* Alpha, ia64 */
>   case 1180 ... 1220 :  Hertz = 1200; break; /* Alpha */

As this is some kind of solution, it is not really generic enough. 
Nobody is prevented from setting his Hz value to 500 or any number coming
to his mind (i.e. when he wants to do something nasty with TBF of tc).

And if you actually look at x86-user-mode-linux, it is 20...


-- 
Live long and prosper
- Harald Welte / laforge@gnumonks.org               http://www.gnumonks.org/
============================================================================
GCS/E/IT d- s-: a-- C+++ UL++++$ P+++ L++++$ E--- W- N++ o? K- w--- O- M- 
V-- PS+ PE-- Y+ PGP++ t++ 5-- !X !R tv-- b+++ DI? !D G+ e* h+ r% y+(*)
