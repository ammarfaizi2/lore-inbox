Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261366AbUKSL6T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261366AbUKSL6T (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 06:58:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261351AbUKSL5h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 06:57:37 -0500
Received: from gprs214-55.eurotel.cz ([160.218.214.55]:6528 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261363AbUKSL40 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 06:56:26 -0500
Date: Fri, 19 Nov 2004 12:56:13 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Matthias Hentges <mailinglisten@hentges.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: pci-resume patch from 2.6.7-rc2 breakes S3 resume on some machines
Message-ID: <20041119115613.GC1030@elf.ucw.cz>
References: <1100811950.3470.23.camel@mhcln03>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1100811950.3470.23.camel@mhcln03>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I'm in the process of debugging S3 on my notebook and found out that I
> can resume from S3 with every kernel up to (and including) 2.6.7-rc1
> ( patch-2.6.6-bk8-bk9.bz2 ).
> 
> After 2.6.7-rc1, my notebook freezes upon a resume from S3. Tested with
> 2.6.7-rc2, -rc3, 2.6.8.1, 2.6.9 and some 2.6.10-rcX-bkX kernels.
> 
> Please note that these tests were run in single user mode with a
> barebone kernel
> .config (attached) just enough to boot (ie no modules, no usb etc)
> 
> I have found a hint on the web that the pci-resume code, which was
> included in 2.6.7-rc2, might cause this problem. I removed the call to
> pci_default_resume in drivers/pci/pci-driver.c and my laptop resumed
> into a working state again ( tested
> with 2.6.7 and 2.6.9 ).
> 
> I've written an email to Arjan van de Ven, the author of the resume
> patch and he suggested positing here, along with a full lspci output
> (attached)
> He thinks that some device is misbehaving and causing trouble if
> resumed.

Okay, patch is way too ugly. You probably should provide resume method
for your radeon that just does nothing. That should confirm your
theory, fix the crash, and you'll avoid touching common code with it.

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
