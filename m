Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751323AbWIOU1K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751323AbWIOU1K (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 16:27:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751336AbWIOU1J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 16:27:09 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:41604 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751323AbWIOU1I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 16:27:08 -0400
Subject: Re: Same MCE on 4 working machines (was Re: Early boot hang on
	recent 2.6 kernels (> 2.6.3), on x86-64 with 16gb of RAM)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Robin Lee Powell <rlpowell@digitalkingdom.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060915182915.GR4610@chain.digitalkingdom.org>
References: <20060912223258.GM4612@chain.digitalkingdom.org>
	 <20060914190548.GI4610@chain.digitalkingdom.org>
	 <1158320742.29932.20.camel@localhost.localdomain>
	 <20060915182915.GR4610@chain.digitalkingdom.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 15 Sep 2006 21:50:39 +0100
Message-Id: <1158353439.29932.146.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Gwe, 2006-09-15 am 11:29 -0700, ysgrifennodd Robin Lee Powell:
> > 	pci=conf2
> 
> No effect without acpi=off.
> 
> With acpi=off, it gets rather farther before apparently failing to
> talk the 3-ware card:

Thats helpful. The conf2 cycles are the wrong type for the board so with
acpi=off pci=conf2 it doesn't see any PCI devices and doesn't explode. I
see nothing odd in the lspci data at all however.

You also have a lot of RAM, that shouldn't matter but it means you hit
code paths most users don't. If you boot with mem limited to 1GB I
assume it still blows up ?

