Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264668AbUJNNiV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264668AbUJNNiV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 09:38:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264704AbUJNNiV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 09:38:21 -0400
Received: from gprs212-10.eurotel.cz ([160.218.212.10]:42112 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S264668AbUJNNiT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 09:38:19 -0400
Date: Thu, 14 Oct 2004 15:38:03 +0200
From: Pavel Machek <pavel@suse.cz>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Patrick Mochel <mochel@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: swsusp resume doesn't sysdev_resume
Message-ID: <20041014133803.GA4144@elf.ucw.cz>
References: <200410111659.16373.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200410111659.16373.bjorn.helgaas@hp.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Sorry for long delay.

> Swsusp often fails on -mm kernels because sysdev_resume doesn't
> get called in the resume path.  So things like ACPI IRQ links
> used by modular drivers don't get restored.
> 
> We can work around this by using "pci=routeirq", so all the IRQ
> setup gets done at boot-time, but that's an ugly hack, and I
> expect that we'll trip over other sysdevs that need to be resumed
> anyway.
> 
> I don't understand swsusp well enough to fix this.  It's not enough
> to just call device_power_up() before device_resume(), because it
> relies on sysdev_suspend() having been called before the suspend
> image was created.

Can you try adding sysdev_suspend() and sysdev_resume() and see what
breaks? Its probably right thing to do...
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
