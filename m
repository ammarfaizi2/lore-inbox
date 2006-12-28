Return-Path: <linux-kernel-owner+w=401wt.eu-S1753813AbWL1XVX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753813AbWL1XVX (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 18:21:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753782AbWL1XVX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 18:21:23 -0500
Received: from smtp.osdl.org ([65.172.181.25]:40982 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753846AbWL1XVX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 18:21:23 -0500
Date: Thu, 28 Dec 2006 15:17:53 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Adrian Bunk <bunk@stusta.de>
cc: Greg KH <gregkh@suse.de>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ben Castricum <mail0612@bencastricum.nl>,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: 2.6.20-rc2: known unfixed regressions
In-Reply-To: <20061228230701.GL20714@stusta.de>
Message-ID: <Pine.LNX.4.64.0612281515470.4473@woody.osdl.org>
References: <Pine.LNX.4.64.0612232043030.3671@woody.osdl.org>
 <20061228223909.GK20714@stusta.de> <20061228225706.GA886@suse.de>
 <20061228230701.GL20714@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 29 Dec 2006, Adrian Bunk wrote:
> 
> In Linus' tree, it currently only depends on EXPERIMENTAL.
> 
> It seems commit 009af1ff78bfc30b9a27807dd0207fc32848218a wasn't intended 
> for Linus?

I think we should just remove it.

It's broken.

Nobody cares.

If people want to do concurrent stuff at bootup, it should be the _other_ 
buses (like USB, IDE or SCSI or anything like that, that actually has 
operations that can delay) that end up asynchronous. And I think we could 
have some generic functionality for the drivers themselves to do their 
probing in parallel. But I think the PCI one was just a mistake.

		Linus
