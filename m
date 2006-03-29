Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964861AbWC2AG0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964861AbWC2AG0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 19:06:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964863AbWC2AGZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 19:06:25 -0500
Received: from waste.org ([64.81.244.121]:54438 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S964861AbWC2AGY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 19:06:24 -0500
Date: Tue, 28 Mar 2006 18:03:45 -0600
From: Matt Mackall <mpm@selenic.com>
To: Alessandro Zummo <alessandro.zummo@towertech.it>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Andi Kleen <ak@muc.de>,
       akpm@osdl.org, torvalds@osdl.org, davem@davemloft.net,
       kkojima@rr.iij4u.or.jp, lethal@linux-sh.org, paulus@samba.org,
       ralf@linux-mips.org, rmk@arm.linux.org.uk, linux-kernel@vger.kernel.org
Subject: 11 minute RTC update (was Re: Remove RTC UIP)
Message-ID: <20060329000345.GZ3642@waste.org>
References: <200603270920.k2R9KYYx007214@shell0.pdx.osdl.net> <20060327111836.GA79131@muc.de> <20060327163218.GD3642@waste.org> <20060327190037.GB27030@muc.de> <20060327211143.55ef7c4e@inspiron> <1143512075.2284.2.camel@localhost.localdomain> <20060329000215.683eb2d5@inspiron>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060329000215.683eb2d5@inspiron>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[linux-kernel cc:ed]

On Wed, Mar 29, 2006 at 12:02:15AM +0200, Alessandro Zummo wrote:
> On Tue, 28 Mar 2006 13:14:34 +1100
> Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> 
> > >  While we are on the topic, I would like to ask everyone about
> > >  the 11 min ntp/rtc update feature of the kernel.
> > > 
> > >  It is something that makes sense to move to
> > >  userland?
> > 
> > YES !!! :)
> 
>  great! given that it is not implemented in the new RTC subsystem
>  and nobody objected, I will not add it :)

I agree that this should be migrated to userspace, but I'm more
worried about the functionality impact here than for the UIP case.

With existing NTP setups, and the kernel no longer writing to the RTC,
you might have the RTC drift far enough that NTP failed to sync on the
next boot. (Correct me if I'm wrong, of course.)

-- 
Mathematics is the supreme nostalgia of our time.
