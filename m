Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261569AbSJQAaN>; Wed, 16 Oct 2002 20:30:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261597AbSJQAaN>; Wed, 16 Oct 2002 20:30:13 -0400
Received: from air-2.osdl.org ([65.172.181.6]:3734 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S261569AbSJQAaL>;
	Wed, 16 Oct 2002 20:30:11 -0400
Date: Wed, 16 Oct 2002 17:36:11 -0700
From: Dave Olien <dmo@osdl.org>
To: Kevin Brosius <cobra@compuserve.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.5.43] (DAC960 compile failure)
Message-ID: <20021016173611.B25937@acpi.pdx.osdl.net>
References: <3DADF607.4B83C107@compuserve.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3DADF607.4B83C107@compuserve.com>; from cobra@compuserve.com on Wed, Oct 16, 2002 at 07:28:07PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I just posted a DAC960 patch for 2.5.42.  Tomorrow, I'll post
a 2.5.43 patch. There are some minor changes needed (about three
lines) for 2.5.43.  See the patch posting regarding ACPI
interactions.

I'd love to hear any good or bad results you have with these
patches.

Thanks!

Dave Olien
Open Source Developement Lab

On Wed, Oct 16, 2002 at 07:28:07PM -0400, Kevin Brosius wrote:
> > 
> >  looking at that i realise that DAC960 code in 2.5.43
> > is not supposed to be tested:
> > ======
> > #error I am a non-portable driver, please convert me to use the Documentation/DMA-mapping.txt interfaces
> > ======
> >  am i right?
> > 
> > the following weirdo appears in both gcc-3.1 and 3.2 (also in 2.5.42)
> > ======
> > drivers/block/DAC960.c: In function `DAC960_DetectControllers':
> > drivers/block/DAC960.c:2465: `Controller' undeclared (first use in this function)
> > drivers/block/DAC960.c:2465: (Each undeclared identifier is reported only once
> > drivers/block/DAC960.c:2465: for each function it appears in.)
> > 
> 
> Yes, 2.5.42 did this also.  It looks like gcc 3.2 doesn't like goto's
> which reference variables outside their native scope.  You can move the
> Controller definition to full function scope to fix that error.
> 
> The DAC960 doesn't seem usable out of the stock kernel build though. 
> You'll need to try patches previously posted to the list.  (Which don't
> fully work for me either...)
> 
> -- 
> Kevin
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
