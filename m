Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261326AbTHSWw7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 18:52:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261330AbTHSWw7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 18:52:59 -0400
Received: from foo209.internut.com ([209.181.68.209]:53670 "EHLO bartman")
	by vger.kernel.org with ESMTP id S261326AbTHSWw5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 18:52:57 -0400
From: "Chuck Luciano" <chuck@mrluciano.com>
To: "Linux-Kernel" <linux-kernel@vger.kernel.org>,
       "Dave Hansen" <haveblue@us.ibm.com>
Subject: RE: redhat 2.4.20 kernel 3.5G patch, bug report on my previous2.4.18 kernel 3.5G patch
Date: Tue, 19 Aug 2003 16:51:33 -0600
Message-ID: <NFBBKNADOLMJPCENHEALAEOJGLAA.chuck@mrluciano.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
In-Reply-To: <1061327818.25944.48.camel@nighthawk>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave,

You're right. I did make an attribution when I posted the .18 version
of this, but I didn't this time. So,

	I believe the original code was written by someone named Andrea. It
	was a patch against 2.5.74.

	Dave Hansen and Martin Bligh were very helpful and answered numerous
	emails and gave me numerous pointers.

	Also, Mel Gorman's draft book "Understanding the Linux Virtual 
	Memory Manager" provided much useful context for me to dive into
	this code, and if I may give an unsolicited plug for his book, it's
	well worth buying. :)

Failing to gratefully acknowledge this help was a regrettable oversight.

Thank you,
Chuck Luciano
chuck@mrluciano.com


> -----Original Message-----
> From: Dave Hansen [mailto:haveblue@us.ibm.com]
> Sent: Tuesday, August 19, 2003 3:17 PM
> To: Chuck Luciano
> Cc: Linux-Kernel
> Subject: Re: redhat 2.4.20 kernel 3.5G patch, bug report on my
> previous2.4.18 kernel 3.5G patch
> 
> 
> On Tue, 2003-08-19 at 10:55, Chuck Luciano wrote:
> > Again, I've been kinda lazy about adding the configuration stuff,
> > but, this patch applied to kernel-2.4.20-18.7.src.rpm will give
> > you a kernel where PAGE_OFFSET can be set with 2 MB granularity
> > instead of 1GB.
> 
> This sounds familar from somewhere.  A little attribution to the source
> of the code would be nice. :) 
> 
> > BTW, there is a defect in the 2.4.18 version of this patch in the
> > function get_pgd_slow which doesn't handle the partial PGD
> > properly. In 2.4.20 the fix for this problem is in the function 
> > pgd_alloc. I will probably not have time to back port this fix to
> > 2.4.18.
> 
> Actually, I would just do what we did in 2.5 and throw away *_pgd_fast()
> functions and just use a slab constructor and destructor to handle it
> for you.
> 
> > Anyway, for your fun and amusement, the 2.4.20 patch is working 
> > and ready for use. I haven't tried seeing just how far I can push
> > PAGE_OFFSET yet, but I'd like to see how close I can get to 
> > 0xf0000000 and maybe beyond.
> 
> I know I've done at least 0xf8000000 on 2.5.  
> 
> -- 
> Dave Hansen
> haveblue@us.ibm.com
> 
