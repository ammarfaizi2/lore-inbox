Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030336AbWBHBEH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030336AbWBHBEH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 20:04:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030338AbWBHBEH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 20:04:07 -0500
Received: from [81.2.110.250] ([81.2.110.250]:63385 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S1030336AbWBHBEG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 20:04:06 -0500
Subject: Re: Linux drivers management
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: David Chow <davidchow@shaolinmicro.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <43E8F8EB.8010800@shaolinmicro.com>
References: <20060207044204.8908.qmail@science.horizon.com>
	 <m1zml3rvkg.fsf@ebiederm.dsl.xmission.com>
	 <43E8F8EB.8010800@shaolinmicro.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 08 Feb 2006 01:06:03 +0000
Message-Id: <1139360763.22595.10.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2006-02-08 at 03:45 +0800, David Chow wrote:
> Community Developers and Maintainers:
> - Look at the matter on community development process, programming
> - Chase for performance, optimization in source level, even though it is 
> difficult to maintain, who cares?

I've done real studies on this. The majority of the kernel interfaces
favour simplicity and independance.

> - Willing to maintain and develop drivers for free, even though they 
> don't work for the hardware vendor.

Most of our drivers are maintained by people with economic incentives to
maintain them. Economic incentives are not always cash and employment.

> - We will follow the convention who make changes to the API will have to 
> patch all the mess in the kernel source, even though there are 3,714,234 
> hardware peripheral drivers in the kernel in year 2012, I am happy to do 
> that :) . Because I want to make change and following the convention. 
> (how much time to make change or test?)

I'd beg to differ. The amount of hardware interfaces in a system that
are non standard has been dropping like a stone. Software is *expensive*
and it is getting cheaper and cheaper for commodity products to adopt a
commodity API, especially in the open source world where pure software
pricing scams (eg extra cost for flipping the 'raid enable' bit on a
controller) don't work.

The recent directions are pretty clear
	IDE -> Various interfaces -> AHCI
	A billion periphals -> USB (EHCI/OHCI/UHCI) + Class drivers
	SATA -> AHCI
	Sound -> Intel i810 clones/AC97
	USB imaging random drivers -> USB video classes
	Scanners -> USB video/image classes
	A billion camera interfaces -> USB storage
	A load of MP3 player interfaces -> USB storage

Its getting harder and harder to justify non-standard APIs except in a
few areas like infinibong and 3D graphics where they can make a product
genuinely better. Even RAID cards are drifting inexorably to either
extinction or emulating standard interfaces, and no doubt will
eventually end up AHCI.

> the community. But strictly speaking, it shouldn't. Please refer to the 
> process of making a driver from a manufacturers point of view and 
> consider user using old OS'es which don't want to upgrade.

But those people have a stable API - usually RHEL3, RHEL4, SuSE
Enterprise. 

> Sure its not going to change, maybe but not in a year or two, but 
> freedom of speech exists, right?

Time will tell. People said the same when Linux got so big it wouldn't
fit on one floppy disk. I can't prove you are wrong but my suspicion is
that economic incentives and pressures will mould the development
process over time according to the problems it faces.

Alan

