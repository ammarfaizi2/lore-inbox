Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262294AbUCBWh2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 17:37:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262267AbUCBWgl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 17:36:41 -0500
Received: from gprs40-190.eurotel.cz ([160.218.40.190]:35450 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262274AbUCBWfl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 17:35:41 -0500
Date: Tue, 2 Mar 2004 23:35:26 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Tom Rini <trini@kernel.crashing.org>
Cc: "Amit S. Kale" <amitkale@emsyssoft.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       kgdb-bugreport@lists.sourceforge.net
Subject: Re: [KGDB PATCH][1/7] Add / use kernel/Kconfig.kgdb
Message-ID: <20040302223526.GH1225@elf.ucw.cz>
References: <20040227212301.GC1052@smtp.west.cox.net> <200403021709.26396.amitkale@emsyssoft.com> <20040302150544.GC16434@smtp.west.cox.net> <20040302222307.GB1225@elf.ucw.cz> <20040302223403.GI20227@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040302223403.GI20227@smtp.west.cox.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > It also makes core.patch dependent on 8250.patch
> > > > Any ideas on fixing that?
> > > 
> > > No, it's intentional.  eth.patch also depends on 8250.patch.
> > 
> > Perhaps that parts should be moved to core-lite? It should not be
> > neccessary to have serial support...
> > 
> > Or perhaps we want to decrease number of modules, and merge 8250 into
> > core-lite, having one less patch to care about?
> 
> If it's really important to not have patches depend on eachother until
> we get to the non-lite core, i386 (and soon ppc, x86_64) patches, then
> we should put all of the Kconfig bits in the main patch, so long as we
> think all of the related drivers will be able to make it in as well (or
> will move those bits out again when it's time).  Or we could just
> document dependancies and move on.

I believe "put kconfig into core" is the right thing to do.
								Pavel

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
