Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030218AbVHKHjr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030218AbVHKHjr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 03:39:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030219AbVHKHjr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 03:39:47 -0400
Received: from van-1-67.lab.dnainternet.fi ([62.78.96.67]:64159 "EHLO
	mail.zmailer.org") by vger.kernel.org with ESMTP id S1030218AbVHKHjr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 03:39:47 -0400
Date: Thu, 11 Aug 2005 10:39:46 +0300
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: "Stephen D. Williams" <sdw@lig.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Soft lockup in e100 driver ?
Message-ID: <20050811073946.GT22165@mea-ext.zmailer.org>
References: <20050809133647.GK22165@mea-ext.zmailer.org> <1123604182.15991.40.camel@c-67-188-6-232.hsd1.ca.comcast.net> <20050809163632.GQ22165@mea-ext.zmailer.org> <42FA9C02.3030406@lig.net> <42FA9CAD.7030607@lig.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42FA9CAD.7030607@lig.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 10, 2005 at 08:32:45PM -0400, Stephen D. Williams wrote:
> I just noticed that the Ubuntu setup says "GSI 20(level,low) -> IRQ 20" 
> whereas I remember my built kernels saying "No GSI......  IRQ 11".  I'll 
> investigate what that means and how to enable it.  Pointers appreciated.

That is most likely unrelated, but I had similar experiences
at times.  It turned out that something done recently in APIC
management code did break things, but lattest version is again
working.   For a while to have network card working I had to boot
with  "noapic"  option in my home SMP box.

In an UP box it is about same to boot as "noapic", but in SMP it
does result in "one CPU does all interrupts" thingie.  (In some
rare cases it could be desirable, even.)

   /Matti Aarnio


> sdw
> 
> Stephen D. Williams wrote:
> 
> >I have been working for days to get a recent kernel to work with these 
> >small-format UP Celeron 2Ghz (running at 1.33Ghz) motherboards that I 
> >am planning to use as thin clients.  I'm doing a PXE boot, loading 
> >kernels, and trying to get networking to come up.
> >
> >I eventually realized that the problem is that the e100 driver loads 
> >but does not allow any packet traffic.  The system isn't crashed, but 
> >I do get transmit timeouts.
> >
> >I've used kernels: 2.6.10, 2.6.11, and 2.6.12.4, stock with only the 
> >"squashfs" patch applied and compiled as 586/....
> >
> >The interesting thing is that Ubuntu 5.04, booted "Live" on the box, 
> >works just fine with the e100 driver with a kernel shown as: 
> >"2.6.10-5-386".  I'm going to work on pulling this kernel and its 
> >modules off to use.
> >
> >Any help urgently appreciated.
> >
> >sdw


