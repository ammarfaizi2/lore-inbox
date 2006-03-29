Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750726AbWC2BLT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750726AbWC2BLT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 20:11:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750739AbWC2BLT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 20:11:19 -0500
Received: from mx0.towertech.it ([213.215.222.73]:58004 "HELO mx0.towertech.it")
	by vger.kernel.org with SMTP id S1750726AbWC2BLT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 20:11:19 -0500
Date: Wed, 29 Mar 2006 03:11:02 +0200
From: Alessandro Zummo <alessandro.zummo@towertech.it>
To: Matt Mackall <mpm@selenic.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Andi Kleen <ak@muc.de>,
       akpm@osdl.org, torvalds@osdl.org, davem@davemloft.net,
       kkojima@rr.iij4u.or.jp, lethal@linux-sh.org, paulus@samba.org,
       ralf@linux-mips.org, rmk@arm.linux.org.uk, linux-kernel@vger.kernel.org
Subject: Re: 11 minute RTC update (was Re: Remove RTC UIP)
Message-ID: <20060329031102.0e056d85@inspiron>
In-Reply-To: <20060329000345.GZ3642@waste.org>
References: <200603270920.k2R9KYYx007214@shell0.pdx.osdl.net>
	<20060327111836.GA79131@muc.de>
	<20060327163218.GD3642@waste.org>
	<20060327190037.GB27030@muc.de>
	<20060327211143.55ef7c4e@inspiron>
	<1143512075.2284.2.camel@localhost.localdomain>
	<20060329000215.683eb2d5@inspiron>
	<20060329000345.GZ3642@waste.org>
Organization: Tower Technologies
X-Mailer: Sylpheed
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Mar 2006 18:03:45 -0600
Matt Mackall <mpm@selenic.com> wrote:

> > > >  While we are on the topic, I would like to ask everyone about
> > > >  the 11 min ntp/rtc update feature of the kernel.
> > > > 
> > > >  It is something that makes sense to move to
> > > >  userland?
> > > 
> > > YES !!! :)
> > 
> >  great! given that it is not implemented in the new RTC subsystem
> >  and nobody objected, I will not add it :)
> 
> I agree that this should be migrated to userspace, but I'm more
> worried about the functionality impact here than for the UIP case.
> 
> With existing NTP setups, and the kernel no longer writing to the RTC,
> you might have the RTC drift far enough that NTP failed to sync on the
> next boot. (Correct me if I'm wrong, of course.)

 That's probably true, I'm not expert on the matter. The new subsystem only
 covers platforms that were not covered before (i.e. without external patches),
 so that this should not impact users because the NTP update mode
 was not working on them.

 The problem might arise when other RTC drivers (i.e. x86) will be converted
 and deployed.

 We need a migration plan. Any suggestion? 

-- 

 Best regards,

 Alessandro Zummo,
  Tower Technologies - Turin, Italy

  http://www.towertech.it

