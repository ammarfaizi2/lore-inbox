Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269995AbUJSWFX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269995AbUJSWFX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 18:05:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269907AbUJSVss
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 17:48:48 -0400
Received: from fire.osdl.org ([65.172.181.4]:17319 "EHLO fire-1.osdl.org")
	by vger.kernel.org with ESMTP id S269891AbUJSVjr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 17:39:47 -0400
Subject: Re: Linux v2.6.9... (compile stats)
From: John Cherry <cherry@osdl.org>
To: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20041019161834.GA23821@one-eyed-alien.net>
References: <Pine.LNX.4.58.0410181540080.2287@ppc970.osdl.org>
	 <1098196575.4320.0.camel@cherrybomb.pdx.osdl.net>
	 <20041019161834.GA23821@one-eyed-alien.net>
Content-Type: text/plain
Message-Id: <1098221837.2646.34.camel@cherrybomb.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Tue, 19 Oct 2004 14:37:17 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-10-19 at 09:18, Matthew Dharm wrote:
> These are x86-based stats, yes?  I'm sure other arches will likely tease
> out more...

Yes, they are x86-based.  Other archs are on my list of things to do. 
If you would like to pick up the ball with these other archs, the
compile tools are at http://developer.osdl.org/cherry/compile/tools/

> 
> A lot of these seem to be related to readl/writel (readb/writeb, etc).
> Those should be straightforward one-line changes, I think... perhaps a job
> for more automated scripting?

A lot of these readl/writel warnings HAVE been addressed.  In 2.6.9-rc2,
there were about 3000 of these warnings.  In 2.6.9, there are less than
1900.

> 
> At the very least, it would be nice to post-process the data to show which
> modules are the offenders (and by how much).

Check out the complete details page
(http://developer.osdl.org/cherry/compile/).  Under "Warning/Error
Module Build Summaries", you can see how the warnings break down by
module.  For 2.6.9, they are...

   drivers/atm: 6 warnings, 0 errors
   drivers/block: 1 warnings, 0 errors
   drivers/cpufreq: 2 warnings, 0 errors
   drivers/isdn: 90 warnings, 0 errors
   drivers/media: 86 warnings, 0 errors
   drivers/misc: 2 warnings, 0 errors
   drivers/mtd: 464 warnings, 0 errors
   drivers/net: 756 warnings, 0 errors
   drivers/pcmcia: 3 warnings, 0 errors
   drivers/scsi/megaraid: 10 warnings, 0 errors
   drivers/scsi/pcmcia: 3 warnings, 0 errors
   drivers/scsi: 148 warnings, 0 errors
   drivers/telephony: 2 warnings, 0 errors
   drivers/video/aty: 4 warnings, 0 errors
   drivers/video/kyro: 112 warnings, 0 errors
   drivers/video/matrox: 1 warnings, 0 errors
   drivers/video: 11 warnings, 0 errors
   drivers/w1: 4 warnings, 0 errors
   net: 2 warnings, 0 errors
   sound/drivers: 2 warnings, 0 errors
   sound/oss: 51 warnings, 0 errors
   sound/pci: 193 warnings, 0 errors

The module output of these compiles can be found under "Other files".  
For 2.6.9, check out...

http://developer.osdl.org/cherry/compile/2.6/linux-2.6.9.results/

John

> 
> Matt
> 
> On Tue, Oct 19, 2004 at 07:36:15AM -0700, John Cherry wrote:
> > No changes...
> > 
> > Linux 2.6 Compile Statistics (gcc 3.2.2)
> > 
> > Web page with links to complete details:
> >    http://developer.osdl.org/cherry/compile/
> > 
> > Kernel         bzImage    bzImage  bzImage  modules  bzImage   modules
> >              (defconfig)  (allno)  (allyes) (allyes) (allmod) (allmod)
> > -----------  -----------  -------- -------- -------- -------- ---------
> > 2.6.9          0w/0e       0w/0e  1930w/0e   41w/0e  11w/0e   1950w/0e
> > 2.6.9-final    0w/0e       0w/0e  1930w/0e   41w/0e  11w/0e   1950w/0e
> > 2.6.9-rc4      0w/0e       0w/0e  1930w/0e   41w/0e  11w/0e   1950w/0e
> > 2.6.9-rc3      0w/0e       0w/0e  2752w/17e  41w/0e  11w/0e   2782w/5e
> > 2.6.9-rc2      0w/0e       0w/0e  3036w/0e   41w/0e  11w/0e   3655w/0e
> > 2.6.9-rc1      0w/0e       0w/0e    77w/10e   4w/0e   3w/0e     68w/0e
> > 2.6.8.1        0w/0e       0w/0e    78w/ 0e   4w/0e   1w/0e     72w/0e
> > 2.6.8          0w/0e       0w/0e    78w/ 0e   4w/0e   1w/0e     72w/0e
> > 2.6.8-rc4      0w/0e       0w/0e    78w/ 0e   4w/0e   1w/0e     72w/0e
> > 2.6.8-rc3      0w/0e       0w/0e    78w/ 0e   4w/0e   1w/0e     72w/0e
> > 2.6.8-rc2      0w/0e       0w/0e    85w/ 0e   5w/0e   1w/0e     79w/0e
> > 2.6.8-rc1      0w/0e       0w/0e    87w/ 0e   5w/0e   1w/0e     82w/0e
> > 2.6.7          0w/0e       0w/0e   108w/ 0e   5w/0e   2w/0e    102w/0e
> > 2.6.7-rc3      0w/0e       0w/0e   108w/ 0e   5w/0e   2w/0e    104w/0e
> > 2.6.7-rc2      0w/0e       0w/0e   110w/ 0e   5w/0e   2w/0e    106w/0e
> > 2.6.7-rc1      0w/0e       0w/0e   111w/ 0e   6w/0e   2w/0e    107w/0e
> > 2.6.6          0w/0e       0w/0e   123w/ 0e   7w/0e   4w/0e    121w/0e
> > 2.6.6-rc3      0w/0e       0w/0e   124w/ 0e   7w/0e   5w/0e    121w/0e
> > 2.6.6-rc2      0w/0e       0w/0e   122w/ 0e   7w/0e   4w/0e    121w/0e
> > 2.6.6-rc1      0w/0e       0w/0e   125w/ 0e   7w/0e   4w/0e    123w/0e
> > 2.6.5          0w/0e       0w/0e   134w/ 0e   8w/0e   4w/0e    132w/0e
> > 2.6.5-rc3      0w/0e       0w/0e   135w/ 0e   8w/0e   4w/0e    132w/0e
> > 2.6.5-rc2      0w/0e       0w/0e   135w/ 0e   8w/0e   3w/0e    132w/0e
> > 2.6.5-rc1      0w/0e       0w/0e   138w/ 0e   8w/0e   3w/0e    135w/0e
> > 2.6.4          1w/0e       0w/0e   145w/ 0e   7w/0e   3w/0e    142w/0e
> > 2.6.4-rc2      1w/0e       0w/0e   148w/ 0e   7w/0e   3w/0e    145w/0e
> > 2.6.4-rc1      1w/0e       0w/0e   148w/ 0e   7w/0e   3w/0e    145w/0e
> > 2.6.3          1w/0e       0w/0e   142w/ 0e   9w/0e   3w/0e    142w/0e
> > 2.6.3-rc4      1w/0e       0w/0e   142w/ 0e   9w/0e   3w/0e    142w/0e
> > 2.6.3-rc3      1w/0e       0w/0e   145w/ 7e   9w/0e   3w/0e    148w/0e
> > 2.6.3-rc2      1w/0e       0w/0e   141w/ 0e   9w/0e   3w/0e    144w/0e
> > 2.6.3-rc1      1w/0e       0w/0e   145w/ 0e   9w/0e   3w/0e    177w/0e
> > 2.6.2          1w/0e       0w/0e   152w/ 0e  12w/0e   3w/0e    187w/0e
> > 2.6.2-rc3      0w/0e       0w/0e   152w/ 0e  12w/0e   3w/0e    187w/0e
> > 2.6.2-rc2      0w/0e       0w/0e   153w/ 8e  12w/0e   3w/0e    188w/0e
> > 2.6.2-rc1      0w/0e       0w/0e   152w/ 0e  12w/0e   3w/0e    187w/0e
> > 2.6.1          0w/0e       0w/0e   158w/ 0e  12w/0e   3w/0e    197w/0e
> > 2.6.1-rc3      0w/0e       0w/0e   158w/ 0e  12w/0e   3w/0e    197w/0e
> > 2.6.1-rc2      0w/0e       0w/0e   166w/ 0e  12w/0e   3w/0e    205w/0e
> > 2.6.1-rc1      0w/0e       0w/0e   167w/ 0e  12w/0e   3w/0e    206w/0e
> > 2.6.0          0w/0e       0w/0e   170w/ 0e  12w/0e   3w/0e    209w/0e
> > 
> > Daily compiles (ia32): 
> >    http://developer.osdl.org/cherry/compile/2.6/linus-tree/running.txt
> > Latest changes in Linus' bitkeeper tree:
> >    http://linux.bkbits.net:8080/linux-2.5
> > 
> > John
> > 
> > 
> > -- 
> > John Cherry
> > cherry@osdl.org
> > 503-626-2455x29
> > Open Source Development Labs
> > 
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/

