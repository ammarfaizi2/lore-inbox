Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262464AbUJ0QHD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262464AbUJ0QHD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 12:07:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262505AbUJ0QHC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 12:07:02 -0400
Received: from wrzx35.rz.uni-wuerzburg.de ([132.187.3.35]:50572 "EHLO
	wrzx35.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S262464AbUJ0QFt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 12:05:49 -0400
Date: Wed, 27 Oct 2004 18:05:40 +0200 (CEST)
From: Andreas Klein <Andreas.C.Klein@physik.uni-wuerzburg.de>
X-X-Sender: asklein@pluto.physik.uni-wuerzburg.de
To: Sergei Haller <Sergei.Haller@math.uni-giessen.de>
Cc: Andi Kleen <ak@muc.de>, Andrew Walrond <andrew@walrond.org>,
       "Rafael J. Wysocki" <rjw@sisk.pl>, linux-kernel@vger.kernel.org
Subject: Re: solution Re: lost memory on a 4GB amd64
In-Reply-To: <Pine.LNX.4.58.0410271718050.10573@fb07-2go.math.uni-giessen.de>
Message-ID: <Pine.LNX.4.58.0410271751330.3903@pluto.physik.uni-wuerzburg.de>
References: <Pine.LNX.4.58.0409161445110.1290@magvis2.maths.usyd.edu.au>
 <200409241315.42740.andrew@walrond.org> <Pine.LNX.4.58.0410221053390.17491@fb07-2go.math.uni-giessen.de>
 <200410221026.22531.andrew@walrond.org> <20041022182446.GA77384@muc.de>
 <Pine.LNX.4.58.0410231220400.17491@fb07-2go.math.uni-giessen.de>
 <20041023164902.GB52982@muc.de> <Pine.LNX.4.58.0410241133400.17491@fb07-2go.math.uni-giessen.de>
 <Pine.LNX.4.58.0410271704050.3903@pluto.physik.uni-wuerzburg.de>
 <Pine.LNX.4.58.0410271718050.10573@fb07-2go.math.uni-giessen.de>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on domino1/uni-wuerzburg(Release 6.51HF561 | September
 17, 2004) at 10/27/2004 18:05:40,
	Serialize by Router on domino1/uni-wuerzburg(Release 6.51HF561 | September
 17, 2004) at 10/27/2004 18:05:43,
	Serialize complete at 10/27/2004 18:05:43
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

On Wed, 27 Oct 2004, Sergei Haller wrote:

> On Wed, 27 Oct 2004, Andreas Klein (AK) wrote:
> 
> Are you sure this is the same problem, that I have? You discovered
> Problems with memtest86:
> 
> > Memtest sees 0-2GB mem usable and 4-6GB unusable (complains 
> > about each memory address).
> 
> I didn't:
> 
> > memtest86 is happy with the memory.

Memtest is happy with my memory too, if all 4 modules are installed in the 
slots belonging to CPU1. If I install 2 modules for each CPU, memtest86 is 
not happy anymore.

> 
> The next difference: 
> You have the S2885 (thunder K8W) and S2875S (tiger K8W single processor) 
> boards and I have a S2875 (tiger K8W double processor)

The boards are nearly identical (on-board lan is different, and your 
memory-slots are connected to one CPU).
If all memory modules are installed for one CPU, I have your problems. 
Additionaly there are some other problems that only occur, when the 
modules are installed one pair for each CPU.

Since I have a pre-producion board and bios which is running solid as a 
rock, regardless if a SMP/no-SMP kernel is installed, I hope that they
will fix all problems.

> I summarize (again) my problems:
> 
> Independantly of the memory settings in the BIOS:
>  - non-SMP Kernel is stable
>  - memtest86 does not report any errors
> 
> If the memory (4GB) is set up in one block (0-4GB) in the BIOS, then
>  - SMP Kernel is stable 
> 
> If the memory (4GB) is set up in two blocks (eg. 0-3GB, 4-5GB) in the
> BIOS, then
>  - SMP Kernel is stable _if_and_only_if_ NUMA is _disabled_.
> 
> 
> BTW.: I won't be able to flash a new BIOS to our machine, since it is in 
> production use and runs _rock_stable_ with _full_memory_ after we
> _disabled_ NUMA support in the kernel. (see the two small programs posted 
> by me and by Andi Kleen)
> 
> What I COULD do is running some tests if needed. (e.g. to check if the 
> Board/BIOS is lying about its capabilities)
> 
> 
>         Sergei
> -- 
> --------------------------------------------------------------------  -?)
>          eMail:       Sergei.Haller@math.uni-giessen.de               /\\
> -------------------------------------------------------------------- _\_V
> Be careful of reading health books, you might die of a misprint.
>                 -- Mark Twain
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


-- Andreas Klein
   asklein@cip.physik.uni-wuerzburg.de
   root / webmaster @cip.physik.uni-wuerzburg.de
   root / webmaster @www.physik.uni-wuerzburg.de
_____________________________________
|                                   | 
|   Long live our gracious AMIGA!   |
|___________________________________|

