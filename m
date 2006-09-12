Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030332AbWILSWg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030332AbWILSWg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 14:22:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030333AbWILSWg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 14:22:36 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:59308 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1030332AbWILSWf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 14:22:35 -0400
Subject: Re: [PATCH] quirks: Flag up and handle the AMD 8151 Errata #24
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200609121729.12009.ak@suse.de>
References: <1158078540.6780.61.camel@localhost.localdomain>
	 <200609121710.57393.ak@suse.de>
	 <1158081220.6780.71.camel@localhost.localdomain>
	 <200609121729.12009.ak@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 12 Sep 2006 19:45:43 +0100
Message-Id: <1158086743.6780.86.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Maw, 2006-09-12 am 17:29 +0200, ysgrifennodd Andi Kleen:
> If the system really locks up afterwards they will likely never see it though? 

They'll see it at boot.

> I just don't think the printk will that useful and if it locks up people will
> blame Linux anyways even with printk.

Which is why I also intend to make sure the drivers aren't defaulting to
ignore but all do it properly and require a force flag. PCIPCI_FAIL
means it doesn't work. No driver should be ignoring that flag.
> 
> > And "all that code" is a single quirk (which I think can be __init as
> > you can't get a hotplug bridge) and updated logic checks which my gcc
> > generates the same amount of code for as it did previously.
> >
> > All what code ?
> 
> Well it was a large change.

You must use a bigger font than I do ;)

Alan

