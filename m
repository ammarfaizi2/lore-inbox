Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266645AbTBGTx5>; Fri, 7 Feb 2003 14:53:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266682AbTBGTx5>; Fri, 7 Feb 2003 14:53:57 -0500
Received: from [81.2.122.30] ([81.2.122.30]:29961 "EHLO darkstar.example.net")
	by vger.kernel.org with ESMTP id <S266645AbTBGTxz>;
	Fri, 7 Feb 2003 14:53:55 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200302072003.h17K3t2U002303@darkstar.example.net>
Subject: Re: [PATCH] 2.5.59 : sound/oss/vidc.c
To: rmk@arm.linux.org.uk (Russell King)
Date: Fri, 7 Feb 2003 20:03:55 +0000 (GMT)
Cc: fdavis@si.rr.com, linux-kernel@vger.kernel.org
In-Reply-To: <20030207194314.C30927@flint.arm.linux.org.uk> from "Russell King" at Feb 07, 2003 07:43:14 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > --- linux/sound/oss/vidc.c.old	2003-01-16 21:21:38.000000000 -0500
> > +++ linux/sound/oss/vidc.c	2003-02-07 02:59:44.000000000 -0500
> > @@ -225,7 +225,7 @@
> >  			newsize = 208;
> >  		if (newsize > 4096)
> >  			newsize = 4096;
> > -		for (new2size = 128; new2size < newsize; new2size <<= 1);
> > +		for (new2size = 128; new2size < newsize; new2size <<= 1)
> >  			if (new2size - newsize > newsize - (new2size >> 1))
> >  				new2size >>= 1;
> >  		if (new2size > 4096) {
> 
> The code is correct as it originally stood.
> 
> It looks like indent has a bug and incorrectly formats this to look wrong.
> Back in 2.2 times, the code looks  like this:
> 
> 		for (new2size = 128; new2size < newsize; new2size <<= 1);
> 		if (new2size - newsize > newsize - (new2size >> 1))
> 			new2size >>= 1;
> 
> and this is the intended functionality.  Please do NOT apply the patch.

I thought we were switching to negative tab indentation, anyway:

http://marc.theaimsgroup.com/?l=linux-kernel&m=104125431009832&w=2

:-)

John.
