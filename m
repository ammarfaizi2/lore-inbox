Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263664AbUGCAfm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263664AbUGCAfm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 20:35:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265515AbUGCAfm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 20:35:42 -0400
Received: from gprs214-65.eurotel.cz ([160.218.214.65]:32653 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S263664AbUGCAfl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 20:35:41 -0400
Date: Sat, 3 Jul 2004 02:35:26 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Terence Ripperda <tripperda@nvidia.com>,
       Stefan Seyfried <seife@gmane0305.slipkontur.de>,
       swsusp-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [Swsusp-devel] Re: nvidia's driver and swsusp (need help w/ n forc e2 mobo)
Message-ID: <20040703003526.GF3889@elf.ucw.cz>
References: <20040702192044.GO1815@hygelac> <20040702200012.GU1815@hygelac> <20040702232228.GA19080@hell.org.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040702232228.GA19080@hell.org.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I tried hibernating/resuming while in X. but I don't see any acpi
> > calls coming through to our driver via the pci driver model. is this
> > expected?

If you have suspend/resume methods in struct pci_device, those should
be called. If they are not, something is very wrong... Take a look on
for example drivers/net/b44.c -- that implements suspend/resume.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
