Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261666AbSJQDIW>; Wed, 16 Oct 2002 23:08:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261667AbSJQDIW>; Wed, 16 Oct 2002 23:08:22 -0400
Received: from smtp2.san.rr.com ([24.25.195.39]:15336 "EHLO smtp2.san.rr.com")
	by vger.kernel.org with ESMTP id <S261666AbSJQDIR>;
	Wed, 16 Oct 2002 23:08:17 -0400
Date: Wed, 16 Oct 2002 20:11:25 -0700
From: Andrew Vasquez <praka@san.rr.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [Kernel 2.5] Qlogic 2x00 driver
Message-ID: <20021017031125.GA21251@praka.local.home>
Mail-Followup-To: Andrew Vasquez <praka@san.rr.com>,
	linux-kernel@vger.kernel.org
References: <1034710299.1654.4.camel@localhost.localdomain> <200210152153.08603.simon.roscic@chello.at> <3DACD41F.2050405@metaparadigm.com> <1034740592.29313.0.camel@localhost> <3DACEB6E.6050700@metaparadigm.com> <3DACEC85.3020208@tmsusa.com> <3DACF908.70207@metaparadigm.com> <20021016054035.GM15552@clusterfs.com> <20021017015903.GA20960@praka.local.home> <1034822651.27.3.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1034822651.27.3.camel@localhost>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.4.20-pre10-ac2
X-Message-Flag: Get a real e-mail client.  http://www.mutt.org/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Oct 2002, GrandMasterLee wrote:

> On Wed, 2002-10-16 at 20:59, Andrew Vasquez wrote:
> > > Yes, we have seen that ext3 is a stack hog in some cases, and I
> > > know there were some fixes in later LVM versions to remove some
> > > huge stack allocations.  Arjan also reported stack problems with
> > > qla2x00, so it is not a surprise that the combination causes
> > > problems.
> > > 
> > The stack issues were a major problem in the 5.3x series driver.  I
> > believe, I can check tomorrow, 5.38.9 (the driver Dell distributes)
> > contains fixes for the stack clobbering -- qla2x00-rh1-3 also contain
> > the fixes.
> 
> Does this mean that 6.01 will NOT work either? What drivers will be
> affected? We've already made the move to remove LVM from the mix, but
> your comments above give me some doubt as to how definite it is, that
> the stack clobbering will be fixed by doing so. 
> 
The 6.x series driver basically branched from the 5.x series driver.  
Changes made, many moons ago, are already in the 6.x series driver.
To quell your concerns, yes, stack overflow is not an issue with the
6.x series driver. 

I believe if we are to get anywhere regarding this issue, we need to 
shift focus from stack corruption in early versions of the driver.

> > IAC, I believe the support tech working with MasterLee had asked 
> > for additional information regarding the configuration as well as
> > some basic logs.  Ideally we'd like to setup a similiar configuration
> > in house and see what's happening...
> 
> In-house?
> 
Sorry, short introduction, Andrew Vasquez, Linux driver development at
QLogic.

> Just curious. What can "I" do to know if our configuration
> won't get broken, just by removing LVM? TIA.
>
I've personally never used LVM before, so I cannot even begin to
attempt to answer your question --  please work with the tech on this
one, if it's a driver problem, we'd like to fix it.

--
Andrew
