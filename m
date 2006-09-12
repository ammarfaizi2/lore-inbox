Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030289AbWILRAz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030289AbWILRAz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 13:00:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030290AbWILRAz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 13:00:55 -0400
Received: from cantor2.suse.de ([195.135.220.15]:15853 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030289AbWILRAy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 13:00:54 -0400
From: Andi Kleen <ak@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] quirks: Flag up and handle the AMD 8151 Errata #24
Date: Tue, 12 Sep 2006 17:29:11 +0200
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
References: <1158078540.6780.61.camel@localhost.localdomain> <200609121710.57393.ak@suse.de> <1158081220.6780.71.camel@localhost.localdomain>
In-Reply-To: <1158081220.6780.71.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609121729.12009.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 12 September 2006 19:13, Alan Cox wrote:
> Ar Maw, 2006-09-12 am 17:10 +0200, ysgrifennodd Andi Kleen:
> > On Tuesday 12 September 2006 18:29, Alan Cox wrote:
> > > AMD states the following
> > >
> > > "Some PCI cards generate peer-to-peer posted-write traffic targetting
> > > the AGP bridge (from the PCI bus, through the graphics tunnel to the
> > > AGP bus). The combination of such cards and some AGP cards can generate
> > > traffic patters that result in a system deadlock."
> >
> > Hmm, you add all that code just to trigger printks? Looks like overkill
> > to me.
>
> Firstly it's important users get the correct messages about hardware
> problems and don't just assume Linux sucks. 

If the system really locks up afterwards they will likely never see it though? 

I just don't think the printk will that useful and if it locks up people will
blame Linux anyways even with printk.

> And "all that code" is a single quirk (which I think can be __init as
> you can't get a hotplug bridge) and updated logic checks which my gcc
> generates the same amount of code for as it did previously.
>
> All what code ?

Well it was a large change.

-Andi
