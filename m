Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262114AbTKQXJe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Nov 2003 18:09:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262115AbTKQXJe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Nov 2003 18:09:34 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.103]:43393 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262114AbTKQXJc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Nov 2003 18:09:32 -0500
Subject: Re: Terrible interactivity with 2.6.0-t9-mm3
From: john stultz <johnstul@us.ibm.com>
To: "Prakash K. Cheemplavam" <prakashpublic@gmx.de>
Cc: Thomas Schlichter <schlicht@uni-mannheim.de>,
       "Ronny V. Vindenes" <s864@ii.uib.no>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>, cat@zip.com.au,
       gawain@freda.homelinux.org, gene.heskett@verizon.net,
       papadako@csd.uoc.gr
In-Reply-To: <1069109719.11424.1994.camel@cog.beaverton.ibm.com>
References: <1069071092.3238.5.camel@localhost.localdomain>
	 <3FB8C92E.7030201@gmx.de>  <200311172046.17736.schlicht@uni-mannheim.de>
	 <1069104441.11424.1979.camel@cog.beaverton.ibm.com> <3FB950EE.10806@gmx.de>
	 <1069109719.11424.1994.camel@cog.beaverton.ibm.com>
Content-Type: text/plain
Organization: 
Message-Id: <1069110272.11438.2000.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 17 Nov 2003 15:04:32 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-11-17 at 14:55, john stultz wrote:
> On Mon, 2003-11-17 at 14:51, Prakash K. Cheemplavam wrote:
> > john stultz wrote:
> > > You're correct, I forgot to initialize cpu_khz in the ACPI PM timesource
> > > init code. This patch fixes that. 
> > 
> > Well I applied your patch without the ones from Thomas Schlichter. Was 
> > is intended like that or should it be on top of Thomas patches?
> 
> It was to go along side of Thomas' patch. Thomas caught the real issue
> (sched_clock() needs to be switched on use_tsc), but cpu_khz is also
> used in the scheduler, so I just wanted to make sure it was properly set
> as well. 

After sending out multiple patches I should have been more clear. Just
to avoid confusion:

* the init_cpu_khz patch goes along side Thomas' patch. 

* the more experimental sched_clock() -> monotonic_clock() patch I just
sent out for testing replaces Thomas' patch.

thanks
-john


