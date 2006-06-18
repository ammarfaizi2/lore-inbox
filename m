Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750853AbWFRKIm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750853AbWFRKIm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 06:08:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750894AbWFRKIm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 06:08:42 -0400
Received: from mail31.syd.optusnet.com.au ([211.29.132.102]:43203 "EHLO
	mail31.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1750853AbWFRKIl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 06:08:41 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Willy Tarreau <w@1wt.eu>
Subject: Re: [ckpatch][15/29] hz-no_default_250.patch
Date: Sun, 18 Jun 2006 20:08:31 +1000
User-Agent: KMail/1.9.3
Cc: linux list <linux-kernel@vger.kernel.org>, ck list <ck@vds.kolivas.org>
References: <200606181732.48952.kernel@kolivas.org> <20060618074247.GF13255@w.ods.org>
In-Reply-To: <20060618074247.GF13255@w.ods.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606182008.31788.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 18 June 2006 17:42, Willy Tarreau wrote:
> Hi Con,
>
> On Sun, Jun 18, 2006 at 05:32:48PM +1000, Con Kolivas wrote:
> > Make 250 HZ a value that is not selected by default and give some better
> > recommendations in help.
> >
> > Signed-off-by: Con Kolivas <kernel@kolivas.org>
> >
> >  kernel/Kconfig.hz |   15 +++++++++------
> >  1 files changed, 9 insertions(+), 6 deletions(-)
> >
> > Index: linux-ck-dev/kernel/Kconfig.hz
> > ===================================================================
> > --- linux-ck-dev.orig/kernel/Kconfig.hz	2006-06-18 15:23:58.000000000
> > +1000 +++ linux-ck-dev/kernel/Kconfig.hz	2006-06-18 15:24:28.000000000
> > +1000 @@ -21,14 +21,17 @@ choice
> >  	help
> >  	  100 HZ is a typical choice for servers, SMP and NUMA systems
> >  	  with lots of processors that may show reduced performance if
> > -	  too many timer interrupts are occurring.
> > +	  too many timer interrupts are occurring. Laptops may also show
> > +	  improved battery life.
> >
> > -	config HZ_250
> > +	config HZ_250_NODEFAULT
> >  		bool "250 HZ"
> >  	help
> > -	 250 HZ is a good compromise choice allowing server performance
> > -	 while also showing good interactive responsiveness even
> > -	 on SMP and NUMA systems.
> > +	 250 HZ is a lousy compromise choice allowing server interactivity
> > +	 while also showing desktop throughput and no extra power saving on
> > +	 laptops. Good for when you can't make up your mind.
> > +
> > +	 Recommend 100 or 1000 instead.
>
> In fact, I use this value (250 Hz) on servers because it provides slightly
> finer scheduling precision than 100 Hz without the performance impact of
> 1000 Hz. It also has the advantage that conversions between ms<->jiffies
> are performed by bit shifts only and no divide nor multiply. I really do
> not notice any performance hit between 100 and 250 Hz, while I do between
> 250 and 1000.

Thanks for your perspective. I found performance hits on computational tasks 
with 250 vs 100 but your finer precision makes perfect sense.

-- 
-ck
