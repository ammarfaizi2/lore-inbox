Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314294AbSEBJVC>; Thu, 2 May 2002 05:21:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314295AbSEBJVB>; Thu, 2 May 2002 05:21:01 -0400
Received: from theirongiant.weebeastie.net ([203.62.148.50]:49319 "EHLO
	theirongiant.weebeastie.net") by vger.kernel.org with ESMTP
	id <S314294AbSEBJVB>; Thu, 2 May 2002 05:21:01 -0400
Date: Thu, 2 May 2002 19:19:01 +1000
From: CaT <cat@zip.com.au>
To: Russell King <rmk@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, cpufreq@www.linux.org.uk
Subject: Re: AMD PowerNow booboo in 2.4.19-pre7-ac3
Message-ID: <20020502091901.GR14678@zip.com.au>
In-Reply-To: <20020502085137.GP14678@zip.com.au> <20020502101723.B23709@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: Furball Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 02, 2002 at 10:17:23AM +0100, Russell King wrote:
> On Thu, May 02, 2002 at 06:51:37PM +1000, CaT wrote:
> > --- arch/i386/kernel/amdk6plus.c.old    Thu May  2 18:51:13 2002
> > +++ arch/i386/kernel/amdk6plus.c        Thu May  2 18:51:17 2002
> > @@ -117,4 +117,4 @@
> >  MODULE_LICENSE ("GPL");
> >  module_init(PowerNow_k6plus_init);
> >  module_exit(PowerNow_k6plus_exit);
> > -__initcall (PowerNOW_k6plus_init);
> > +__initcall (PowerNow_k6plus_init);
> 
> Hmm, that looks really odd - module_init() should be identical to __initcall
> when built into the kernel.  Copied to the cpufreq list.

I did a test make bzlilo to continue compiling and that -seemed- to work
but I probably did something wrong as it bombed out with a 'duplicate
definition' (from memory) so I removed the __initcall and it compiled
fine this time.

-- 
CORUSCANT-Presiding over a memorial service commemorating the victims
of the attack on the Death Star, the Emperor declared that while recent
victories over the Rebel Alliance were "encouraging, the War on Terror
is not over yet."
	- http://www.zip.com.au/~cat/misc/txt/waronterror.txt
