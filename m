Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280954AbRKGWGQ>; Wed, 7 Nov 2001 17:06:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280997AbRKGWGI>; Wed, 7 Nov 2001 17:06:08 -0500
Received: from cogent.ecohler.net ([216.135.202.106]:63369 "EHLO
	cogent.ecohler.net") by vger.kernel.org with ESMTP
	id <S280954AbRKGWFz>; Wed, 7 Nov 2001 17:05:55 -0500
Date: Wed, 7 Nov 2001 17:05:53 -0500
From: lists@sapience.com
To: linux-kernel@vger.kernel.org
Cc: Sebastian Heidl <heidl@zib.de>
Subject: Re: Intel compiler [Re: Using %cr2 to reference "current"]
Message-ID: <20011107170553.A21740@sapience.com>
In-Reply-To: <3BE94C55.AE42D67E@evision-ventures.com> <E161TWH-0004G9-00@the-village.bc.nu> <20011107153946.T552@csr-pc1.zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011107153946.T552@csr-pc1.zib.de>
User-Agent: Mutt/1.3.23-current-20011027i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 Just as another data point - a simple test, I ran intel 
 compiler on flops v2.

 Run 3 ways - gcc3, icc (v 5) and the beta 6 icc. All run
 on dual p4 with 1 Gb mem on Rh 7.2

 At least on this test the differences are quite dramatic.

  Regards,

  gene/

---------------------------------------------------------------------
Summary
------

   gcc -DUNIX -O3 -march=i686 flops2.c
   icc -xMKW -o flops2 -DUNIX -O3 flops2.c

   FLOPS C Program (Double Precision), V2.0 18 Dec 1992

   Module        MFLOPS
               gcc       icc 5        icc 6        
	       --------  ---------  ----------
     1         444.9410   439.4850    674.3180
     2         265.4815   362.3862    362.3862
     3         298.1843   604.0250   1270.6569
     4         337.7309  1224.8804   1373.8819
     5         392.7003  1138.6503   1131.7073
     6         391.7678  1334.0521   1422.2222
     7         163.5783   193.3900    193.5118
     8         395.7743  1317.3242   1372.6542

   Iterations      =  512000000  512000000  512000000
   NullTime (usec) =     0.0029     0.0000     0.0000
   MFLOPS(1)       =   275.3542   416.9120   472.8952
   MFLOPS(2)       =   264.7165   413.4297   448.2175
   MFLOPS(3)       =   339.5966   714.7146   834.5651
   MFLOPS(4)       =   362.1891  1071.8196  1367.5374

---------------------------------------------------------------------

On Wed, Nov 07, 2001 at 03:39:46PM +0100, Sebastian Heidl wrote:
> On Wed, Nov 07, 2001 at 02:17:33PM +0000, Alan Cox wrote:
> > > somehow encouraged by the compiler comparisions between gcc and intel's
> > > free compiler, which use the register passing for anything local
> > > to the actual code, where the speed gains are up to 20% im currently
> > 
> > I was under the impression intels compiler was profoundly non-free ?
> 
> have a look:
> http://developer.intel.com/software/products/eval/
