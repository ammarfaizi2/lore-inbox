Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030281AbWILQuU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030281AbWILQuU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 12:50:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030283AbWILQuT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 12:50:19 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:13443 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1030281AbWILQuS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 12:50:18 -0400
Subject: Re: [PATCH] quirks: Flag up and handle the AMD 8151 Errata #24
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200609121710.57393.ak@suse.de>
References: <1158078540.6780.61.camel@localhost.localdomain>
	 <200609121710.57393.ak@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 12 Sep 2006 18:13:40 +0100
Message-Id: <1158081220.6780.71.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Maw, 2006-09-12 am 17:10 +0200, ysgrifennodd Andi Kleen:
> On Tuesday 12 September 2006 18:29, Alan Cox wrote:
> > AMD states the following
> >
> > "Some PCI cards generate peer-to-peer posted-write traffic targetting
> > the AGP bridge (from the PCI bus, through the graphics tunnel to the AGP
> > bus). The combination of such cards and some AGP cards can generate
> > traffic patters that result in a system deadlock."
> 
> Hmm, you add all that code just to trigger printks? Looks like overkill
> to me. 

Firstly it's important users get the correct messages about hardware
problems and don't just assume Linux sucks. Secondly at least some of
the capture drivers do the right thing and fall back to other methods.
Those that don't I intend to take up further because the default
behaviour should be the safe behaviour.

And "all that code" is a single quirk (which I think can be __init as
you can't get a hotplug bridge) and updated logic checks which my gcc
generates the same amount of code for as it did previously.

All what code ?

Alan
