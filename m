Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264034AbTIBSI3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 14:08:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263945AbTIBSG5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 14:06:57 -0400
Received: from ns.suse.de ([195.135.220.2]:9962 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263848AbTIBRwy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 13:52:54 -0400
Date: Tue, 2 Sep 2003 19:52:46 +0200
From: Andi Kleen <ak@suse.de>
To: Matthew Wilcox <willy@debian.org>
Cc: willy@debian.org, linux-kernel@vger.kernel.org
Subject: Re: CONFIG_64_BIT
Message-Id: <20030902195246.7ba3515c.ak@suse.de>
In-Reply-To: <20030902174436.GP13467@parcelfarce.linux.theplanet.co.uk>
References: <20030902143424.GO13467@parcelfarce.linux.theplanet.co.uk.suse.lists.linux.kernel>
	<p73wucrm6uo.fsf@oldwotan.suse.de>
	<20030902174436.GP13467@parcelfarce.linux.theplanet.co.uk>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Sep 2003 18:44:36 +0100
Matthew Wilcox <willy@debian.org> wrote:

> On Tue, Sep 02, 2003 at 07:35:11PM +0200, Andi Kleen wrote:
> > Matthew Wilcox <willy@debian.org> writes:
> > 
> > > What do people think of CONFIG_64_BIT?  It saves us from using
> > > !(IA64 || MIPS64 || PARISC64 || S390X || SPARC64 || X86_64) or
> > 
> > For Kconfigs it may make sense, but is there any Config rule that 
> > checks for all 64bit archs (opposed to checking for specific archs)?
> > I cannot thinkg of any.
> 
> ... that was what the patch added.

It added a symbol that means that, but are there any users for it?

Ok, I2O and ATM and WANPIPE maybe but I assume that both are getting fixed
Still all those are non 64bit safe, so it may be better to have an 
CONFIG_32BIT_ONLY or similar.

-Andi
 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
On Tue, 2 Sep 2003 18:44:36 +0100
Matthew Wilcox <willy@debian.org> wrote:

> On Tue, Sep 02, 2003 at 07:35:11PM +0200, Andi Kleen wrote:
> > Matthew Wilcox <willy@debian.org> writes:
> > 
> > > What do people think of CONFIG_64_BIT?  It saves us from using
> > > !(IA64 || MIPS64 || PARISC64 || S390X || SPARC64 || X86_64) or
> > 
> > For Kconfigs it may make sense, but is there any Config rule that 
> > checks for all 64bit archs (opposed to checking for specific archs)?
> > I cannot thinkg of any.
> 
> ... that was what the patch added.

It added a symbol that means that, but are there any users for it?

Ok, I2O and ATM and WANPIPE maybe but I assume that both are getting fixed
Still all those are non 64bit safe, so it may be better to have an 
CONFIG_32BIT_ONLY or similar.

-Andi
 
