Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262267AbUCBWh2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 17:37:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262184AbUCBWgv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 17:36:51 -0500
Received: from fed1mtao07.cox.net ([68.6.19.124]:23293 "EHLO
	fed1mtao07.cox.net") by vger.kernel.org with ESMTP id S262202AbUCBWeF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 17:34:05 -0500
Date: Tue, 2 Mar 2004 15:34:03 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: "Amit S. Kale" <amitkale@emsyssoft.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       kgdb-bugreport@lists.sourceforge.net
Subject: Re: [KGDB PATCH][1/7] Add / use kernel/Kconfig.kgdb
Message-ID: <20040302223403.GI20227@smtp.west.cox.net>
References: <20040227212301.GC1052@smtp.west.cox.net> <200403021709.26396.amitkale@emsyssoft.com> <20040302150544.GC16434@smtp.west.cox.net> <20040302222307.GB1225@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040302222307.GB1225@elf.ucw.cz>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 02, 2004 at 11:23:07PM +0100, Pavel Machek wrote:

> Hi!
> 
> > > It also makes core.patch dependent on 8250.patch
> > > Any ideas on fixing that?
> > 
> > No, it's intentional.  eth.patch also depends on 8250.patch.
> 
> Perhaps that parts should be moved to core-lite? It should not be
> neccessary to have serial support...
> 
> Or perhaps we want to decrease number of modules, and merge 8250 into
> core-lite, having one less patch to care about?

If it's really important to not have patches depend on eachother until
we get to the non-lite core, i386 (and soon ppc, x86_64) patches, then
we should put all of the Kconfig bits in the main patch, so long as we
think all of the related drivers will be able to make it in as well (or
will move those bits out again when it's time).  Or we could just
document dependancies and move on.

-- 
Tom Rini
http://gate.crashing.org/~trini/
