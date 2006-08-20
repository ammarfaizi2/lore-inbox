Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751385AbWHTUrn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751385AbWHTUrn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 16:47:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751400AbWHTUrm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 16:47:42 -0400
Received: from mail.gmx.net ([213.165.64.20]:11164 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751385AbWHTUrm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 16:47:42 -0400
X-Authenticated: #14349625
Subject: Re: [Bugme-new] [Bug 7027] New: CD Ripping speeds slow with 2.6.17
From: Mike Galbraith <efault@gmx.de>
To: Ryan Newberry <brnewber@gmail.com>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>, Ingo Molnar <mingo@elte.hu>,
       Martin Bligh <mbligh@mbligh.org>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <44E89BBA.9090809@gmail.com>
References: <200608191800.k7JI0ML0015395@fire-2.osdl.org>
	 <20060819111437.a88f71cd.akpm@osdl.org>
	 <1156062478.6690.65.camel@Homer.simpson.net>
	 <1156068220.6034.1.camel@Homer.simpson.net>
	 <1156072300.5052.7.camel@Homer.simpson.net>
	 <Pine.LNX.4.61.0608201548180.9027@yvahk01.tjqt.qr>
	 <44E89BBA.9090809@gmail.com>
Content-Type: text/plain
Date: Sun, 20 Aug 2006 22:56:06 +0000
Message-Id: <1156114566.5808.44.camel@Homer.simpson.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-08-20 at 13:28 -0400, Ryan Newberry wrote:
> Jan Engelhardt wrote:
> >>>> I'm skeptical.  Is the source for this application available?  I'd like
> >>>> to see this problem.
> >>>>         
> >>> (never mind.  saw your other post, found source)
> >>>       
> >> Hm.  I can't get better than 1.4x rip speed out of it with a stock SuSE
> >> 10.1 kernel (2.6.16).  It's also using truckloads of cpu, whereas the CD
> >> rippers that came with this distro use a percent or two.
> >>     
> >
> > What command did you use to rip?
> >
> >
> >
> > Jan Engelhardt
> >   
> The ripper he's using is ripoff I assume (source code here: 
> http://prdownloads.sourceforge.net/ripoffc/ripoff-0.8.tar.gz?download  
> extraction functionality contained in src/RipOffExtractor.c) . It uses 
> libparanoia to do its job, like the cdparanoia command. On my system, 
> ripoff has high CPU usage with a 2.6.16 kernel as well, but it reports a 
> 9.0x rate on average.

Watching the .16 kernel, it boosts to interactive status frequently, but
even with this mega-boost, it uses so much cpu that it repeatedly falls
into the expire (unbounded latency) category.

At this point, I think this app has problems.

> Could the fact that it has such high CPU usage be a possible reason I am 
> experiencing a slower ripping speed (1.2x) when the patch that was git 
> bisected is applied?

Short answer, with a lot of interpolation, yes.

	-Mike

