Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132483AbRECTKJ>; Thu, 3 May 2001 15:10:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132571AbRECTKA>; Thu, 3 May 2001 15:10:00 -0400
Received: from cisco7500-mainGW.gts.cz ([194.213.32.131]:2820 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S132483AbRECTJu>;
	Thu, 3 May 2001 15:09:50 -0400
Message-ID: <20010503210904.B9715@bug.ucw.cz>
Date: Thu, 3 May 2001 21:09:04 +0200
From: Pavel Machek <pavel@suse.cz>
To: Helge Hafting <helgehaf@idb.hist.no>, linux-kernel@vger.kernel.org
Subject: Re: X15 alpha release: as fast as TUX but in user space (fwd)
In-Reply-To: <Pine.LNX.4.33.0104281752290.10866-100000@localhost.localdomain> <20010428215301.A1052@gruyere.muc.suse.de> <200104282256.f3SMuRW15999@vindaloo.ras.ucalgary.ca> <9cg7t7$gbt$1@cesium.transmeta.com> <20010430104231.C3294@bug.ucw.cz> <3AF14DC5.17E35108@idb.hist.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <3AF14DC5.17E35108@idb.hist.no>; from Helge Hafting on Thu, May 03, 2001 at 02:23:33PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > Whatever happened to that hack that was discussed a year or two ago?
> > > > The one where (also on IA32) a magic page was set up by the kernel
> > > > containing code for fast system calls, and the kernel would write
> > > > calibation information to that magic page. The code written there
> > > > would use the TSC in conjunction with that calibration data.
> 
> >                                                                 Pavel
> > PS: Hmm, how do you do timewarp for just one userland appliation with
> > this installed?
> 
> 1. Kernel solution: give that particular process a different magic page
> 2. User solution:   Don't obtain time from the magic page.
> 2a                  By changing program source, if available
> 2b                  By switching the c library, assuming it is used

That means that for fooling closed-source statically-linked binary,
you now need to patch kernel. That's regression; subterfugue.org could
do this with normal user rights in 2.4.0.
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
