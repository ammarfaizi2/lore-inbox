Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313820AbSDPSvK>; Tue, 16 Apr 2002 14:51:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313821AbSDPSvJ>; Tue, 16 Apr 2002 14:51:09 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:46856 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S313820AbSDPSvJ>; Tue, 16 Apr 2002 14:51:09 -0400
Date: Tue, 16 Apr 2002 14:47:45 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Dave Hansen <haveblue@us.ibm.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix ips driver compile problems
In-Reply-To: <3CBC4D18.1090005@us.ibm.com>
Message-ID: <Pine.LNX.3.96.1020416143110.27884A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Apr 2002, Dave Hansen wrote:

> Alan Cox wrote:
> > Nope.. thats not what Documentation/DMA-mapping.txt says
> > 
> > It needs updating to use the pci DMA API. That also conveniently should
> > put you close to having it work cross platform
> 
> Let me first point out, I have no official connection to the  writing of 
> this driver.  It's a big company :)  I'm most interested in this because 
> I have an old ServeRAID card at home.

  I have 15 systems with moderately new SR cards... I'm interested, too!
 
> I know that none of the real authors is actively working on fixing this. 
>   Can this be accepted as a band-aid until the maintainers decide to 
> maintain a 2.5 driver, or are we pushing authors to rewrite drivers 
> which don't use the new DMA scheme?

  Let's clarify. Is there a policy to get rid of drivers which don't
conform, and if so are all the other drivers claimed to be compliant and
this the only one which isn't? And if so, why hasn't someone just
commented the config lines out for non-conforming drivers. And if
other non-conforming drivers are being used short term, why reject a patch
for this one?

Otherwise:
- this makes the driver compile - good
- this patch makes the driver WORK - also good
- this patch allows people to test 2.5 and speed development - really good

  I assume that since IBM has spent millions on Linux they will release a
2.5 driver when 2.5 stops changing under them, and that with an official
driver coming no one will spend the time to do a full conforming rewrite
which will be scrapped. 

  What's the issue with this patch? It's not a permanent solution, but I
would bet that future changes in the kernel are going to require other
changes, so unless this breaks something, why reject an interim solution,
when there are interim scheduler and vm changes, etc.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

