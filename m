Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262288AbTH1KtH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 06:49:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263896AbTH1KtH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 06:49:07 -0400
Received: from mail.cpt.sahara.co.za ([196.41.29.142]:41713 "EHLO
	workshop.saharact.lan") by vger.kernel.org with ESMTP
	id S262288AbTH1KtA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 06:49:00 -0400
Subject: Re: [PATCH 2.6.0-test4][sk98lin] sk98lin driver with hardware bug
	make eth unusable
From: Martin Schlemmer <azarah@gentoo.org>
To: Mirko Lindner <mlindner@syskonnect.de>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1062066254.5426.391.camel@mlindner-lin.skd.de>
References: <200308121301.43873.gallir@uib.es>
	 <1060689676.13254.172.camel@workshop.saharacpt.lan>
	 <200308121440.50395.gallir@uib.es> <1061663721.13460.5.camel@nosferatu.lan>
	 <1061728032.13460.28.camel@nosferatu.lan>
	 <1062066254.5426.391.camel@mlindner-lin.skd.de>
Content-Type: text/plain
Message-Id: <1062067183.19599.70.camel@workshop.saharacpt.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 28 Aug 2003 12:39:44 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-08-28 at 12:24, Mirko Lindner wrote:
> The newest version of the sk98lin driver with some fixes for HW Csum was
> sent to the driver Maintainers today (Kernel 2.4.22 and Kernel
> 2.6.0-test4). Here is a list with fixes and new functions:
> 

Thanks, I'll test tonight and let you know if there are any
issues.


Regards,

> VERSION 6.17 (Thu Aug 26 2003 - mlindner)
> New Features:
> - Add: Dynamic Interrupt Moderation (DIM) port up message
> Problems fixed:
> - Fix: Compiler warnings (void *)
> - Fix: README.txt: Editorial changes (spelling)
> - Fix: install.sh: "silent mode" driver check
> - Fix: Disable Half Duplex with Gigabit-Speed (Yukon). Enable Full
> Duplex.
> - Fix: Corrected CPU detection and compile errors on single CPU machines
> Known limitations:
> - None
> 
> VERSION 6.16 (Thu Aug 21 2003 - mlindner)
> New Features:
> - Add: Removed SkNumber and SkDoDiv
> - Add: Counter output as (unsigned long long)
> Problems fixed:
> - Fix: Ignore ConType parameter if empty value
> - Fix: Removed useless defines
> - Fix: UDP and TCP HW-CSum calculation (Kernel 2.5/2.6)
> - Fix: UDP and TCP Proto checks
> - Fix: UDP header offset
> - Fix: Build without ProcFS
> - Fix: Kernel 2.6 editorial changes
> - Fix: Removed useless defines
> Known limitations:
> - None
> 
> VERSION 6.15 (Mon Aug 11 2003 - mlindner)
> New Features:
> - None
> Problems fixed: 
> - Fix: Yukon Lite parameter input and check 
> - Fix: Yukon Lite speed query
> - Fix: ConType parameter check and error detection
> - Fix: Text for some Config- and Release-Files
> - Fix: Readme changes (Support for SK-95xx compliant cards)
> - Fix: modprobe description (Bug #10891)
> - Fix: Insert various fixes applied to the kernel tree
> - Fix: Removed History from the driver readme
> Known limitations:
> - None
> 
> 
> The newest version of the driver is available on the SysKonnect page at:
> http://www.syskonnect.de/syskonnect/support/driver/htm/sk98lin.htm
> 
> Cheers,
> 
> Mirko
> 
> 
> 
> On Sun, 2003-08-24 at 14:27, Martin Schlemmer wrote:
> > On Sat, 2003-08-23 at 20:35, Martin Schlemmer wrote:
> > > On Tue, 2003-08-12 at 14:40, Ricardo Galli wrote:
> > > > On Tuesday 12 August 2003 14:01, Martin Schlemmer shaped the electrons to 
> > > > shout:
> > > > > On Tue, 2003-08-12 at 13:01, Ricardo Galli wrote:
> > > > > > I've already reported this problem to syskonnect few weeks ago (without
> > > > > > success as I see).
> > > > > >
> > > > > > There is a ASIC bug in several popular motherboards (including ASUS ones)
> > > > > > related to TX hardware checksum.
> > > > > >
> > > > > > For packets smaller that 56 bytes (payload), as UDP dns queries, the asic
> > > > > > generates a bad checksum making the drivers unusable for "normal"
> > > > > > Internet usage:
> > > > >
> > > > > <snip>
> > > > >
> > > > > > The only solution is to comment out
> > > > > >  #define USE_SK_TX_CHECKSUM
> > > > > > in skge.c
> > > > >
> > > > > Known issue.
> > > > >
> > > > > Mirko will have a look as soon as he have time.
> > > > 
> > > > Thanks, I just sent a Kconfig patch as a workaround:
> > > > 
> > > > http://lkml.org/lkml/2003/8/12/83
> > > > 
> > > 
> > > Should work fine with version 6.16 of the driver (does so
> > > here at least with a P4C800):
> > > 
> > > http://www.syskonnect.com/syskonnect/support/driver/zip/linux/sk98lin_2.6.0-test3_patch.gz
> > > 
> > 
> > Hi Jeff
> > 
> > Any chance that we could get the sk98lin drivers updated ?  Mirko did
> > not respond as of yet, but the 6.16 version fixes the HW checksum issues
> > with most (if not all) Asus boards and maybe some others ...
> > 
> > 
> > Thanks,
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
Martin Schlemmer


