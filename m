Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264044AbTDOT1w (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 15:27:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264045AbTDOT1w 
	(for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 15:27:52 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:8915 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S264044AbTDOT1u (for <rfc822;linux-kernel@vger.kernel.org>); Tue, 15 Apr 2003 15:27:50 -0400
Date: Tue, 15 Apr 2003 21:39:32 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Robert Love <rml@tech9.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC][2.5 patch] K6-II/K6-II: enable X86_USE_3DNOW
Message-ID: <20030415193931.GS9640@fs.tum.de>
References: <20030414222110.GK9640@fs.tum.de> <1050359780.3664.114.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1050359780.3664.114.camel@localhost>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 14, 2003 at 06:36:20PM -0400, Robert Love wrote:
> On Mon, 2003-04-14 at 18:21, Adrian Bunk wrote:
> 
> > If my patch is wrong and this is a RTFM please give me a hint where to 
> > find the "M".
> 
> Patch looks right...
> 
> > Questions:
> > Is it really correct to enable CONFIG_X86_USE_3DNOW?
> 
> If you are right that the K6-2 and K6-3D support 3DNow!, then yes.  At
> least its "correct" but it may not be optimal: I seem to recall 3DNow
> memory copies were not worthwhile on anything before an Athlon.  Double
> check that, though.

It does, but Alan already explained why it doesn't make a difference.

> > Is the -march=k6-2 correct?
> 
> Yes.  Even if the above is true, splitting the K6 out like this is
> useful for the extra -march here.  It certainly does not hurt (picking
> the original K6 will give proper support for the whole family, in
> needed).

>From a quick look of the gcc-3.2.2 sources it seems that except for the 
3DNow! support gcc doesn't differenciate between K6 and K6-II, so this 
change alone doesn't seem to make it worth adding a new processor type.

> 	Robert Love

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

