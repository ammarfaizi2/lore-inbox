Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261753AbTIPC11 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 22:27:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261754AbTIPC11
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 22:27:27 -0400
Received: from amdext2.amd.com ([163.181.251.1]:56564 "EHLO amdext2.amd.com")
	by vger.kernel.org with ESMTP id S261753AbTIPC1Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 22:27:25 -0400
Message-ID: <99F2150714F93F448942F9A9F112634C0638B1EA@txexmtae.amd.com>
From: richard.brunner@amd.com
To: davidsen@tmr.com, bunk@fs.tum.de
cc: john@grabjohn.com, zwane@linuxpower.ca, linux-kernel@vger.kernel.org
Subject: RE: [PATCH] 2.6 workaround for Athlon/Opteron prefetch errata
Date: Mon, 15 Sep 2003 21:23:17 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
X-WSS-ID: 1378AB95504891-01-01
Content-Type: text/plain;
 charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill,

FWIW, I think you are on the right track!

I may haggle over really "*slow* it in some way",
but I think that can be worked out. It just a nit
in the grand scheme.

Thanks!

] -Rich ...
] AMD Fellow
] richard.brunner at amd com 

> -----Original Message-----
> From: Bill Davidsen [mailto:davidsen@tmr.com] 
> Sent: Monday, September 15, 2003 5:27 PM
> To: Adrian Bunk
> Cc: John Bradford; zwane@linuxpower.ca; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH] 2.6 workaround for Athlon/Opteron prefetch errata
> 
> 
> On Mon, 15 Sep 2003, Adrian Bunk wrote:
> 
> > On Mon, Sep 15, 2003 at 07:32:49AM +0100, John Bradford wrote:
> > >...
> > > It should be possible, and straightforward, to compile a 
> kernel which:
> > > 
> > > 1. Supports, (I.E. has workarounds for), any combination of CPUs.
> > >    E.G. a kernel which supports 386s, and Athlons _only_ would not
> > >    need the F00F bug workaround.  Currently '386' kernels 
> include it,
> > >    because '386' means 'support 386 and above processors'.
> > > 
> > > 2. Has compiler optimisations for one particular CPU.
> > >    E.G. the 386 and Athlon supporting kernel above could have
> > >    alignment optimised for either 386 or Athlon.
> > >...
> > 
> > That's the point where even I consider such a system to be 
> too complex.
> 
> How does it strike you to have these:
>  - compile support for any CPU which doesn't break the target
>    (including slow it in some serious way)
>  - drop support for any CPU except the target
> 
> It seems to me that this is what the vendors want (as general 
> as possible)
> and the size limited users want (small is beautiful).
> 
> Fitting the code to this model could be done gradually and 
> hopefully with
> some macros to prevent too much ugly ifdef code.
> 
> -- 
> bill davidsen <davidsen@tmr.com>
>   CTO, TMR Associates, Inc
> Doing interesting things with little computers since 1979.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

