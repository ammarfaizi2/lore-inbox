Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265588AbSJSMAg>; Sat, 19 Oct 2002 08:00:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265589AbSJSMAf>; Sat, 19 Oct 2002 08:00:35 -0400
Received: from marcie.netcarrier.net ([216.178.72.21]:24844 "HELO
	marcie.netcarrier.net") by vger.kernel.org with SMTP
	id <S265588AbSJSMAe>; Sat, 19 Oct 2002 08:00:34 -0400
Message-ID: <3DB14BED.722CFB06@compuserve.com>
Date: Sat, 19 Oct 2002 08:11:25 -0400
From: Kevin Brosius <cobra@compuserve.com>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.16-4GB i586)
X-Accept-Language: en
MIME-Version: 1.0
To: kernel <linux-kernel@vger.kernel.org>
CC: Dave Olien <dmo@osdl.org>
Subject: [PATCH] (was Re: [2.5.43] (DAC960 compile failure))
References: <3DAEDBFA.6A8A169B@kns.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave, all,
  Dave and I have made the 2.5.43 patch available for download.  You can
find it on my page at:

http://www.user1.netcarrier.com/~kbrosius/pages/mylex.html

This patch allows me to boot 2.5.43 on a dual Athlon system with a Mylex
eXtremeRAID 2000 controller successfully.

Thanks Dave!
Kevin


> 
> Hi Dave,
>   I'll give it a shot tonight.  Did you post the patch to the
> linux-kernel mailing list?  I can't find it in the archives.  If not,
> would you mail a copy to my home address (compuserve, or have you posted
> it on a web location?)  If you'd like me to put up copies of the patch
> for general consumption I'll make space available on a web page.
> 
> Kevin
> 
> >
> > I just posted a DAC960 patch for 2.5.42.  Tomorrow, I'll post
> > a 2.5.43 patch. There are some minor changes needed (about three
> > lines) for 2.5.43.  See the patch posting regarding ACPI
> > interactions.
> >
> > I'd love to hear any good or bad results you have with these
> > patches.
> >
> > Thanks!
> >
> > Dave Olien
> > Open Source Developement Lab
> >
> > On Wed, Oct 16, 2002 at 07:28:07PM -0400, Kevin Brosius wrote:
> > > >
> > > > looking at that i realise that DAC960 code in 2.5.43
> > > > is not supposed to be tested:
> > > > ======
> > > > #error I am a non-portable driver, please convert me to use the \
> > > > Documentation/DMA-mapping.txt interfaces ======
> > > > am i right?
> > > >
> > > > the following weirdo appears in both gcc-3.1 and 3.2 (also in 2.5.42)
> > > > ======
> > > > drivers/block/DAC960.c: In function `DAC960_DetectControllers':
> > > > drivers/block/DAC960.c:2465: `Controller' undeclared (first use in this function)
> > > > drivers/block/DAC960.c:2465: (Each undeclared identifier is reported only once
> > > > drivers/block/DAC960.c:2465: for each function it appears in.)
> > > >
> > >
> > > Yes, 2.5.42 did this also.  It looks like gcc 3.2 doesn't like goto's
> > > which reference variables outside their native scope.  You can move the
> > > Controller definition to full function scope to fix that error.
> > >
> > > The DAC960 doesn't seem usable out of the stock kernel build though.
> > > You'll need to try patches previously posted to the list.  (Which don't
> > > fully work for me either...)
> > >
> > > --
> > > Kevin

-- 
Kevin
