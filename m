Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261381AbVE2SPj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261381AbVE2SPj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 May 2005 14:15:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261379AbVE2SP1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 May 2005 14:15:27 -0400
Received: from atlmail.prod.rxgsys.com ([69.61.70.25]:26525 "EHLO
	bastet.signetmail.com") by vger.kernel.org with ESMTP
	id S261384AbVE2SOo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 May 2005 14:14:44 -0400
Date: Sun, 29 May 2005 14:14:34 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Erik Slagter <erik@slagter.name>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
       Jens Axboe <axboe@suse.de>
Subject: Re: Playing with SATA NCQ
Message-ID: <20050529181434.GA5632@havoc.gtf.org>
References: <20050526140058.GR1419@suse.de> <1117382598.4851.3.camel@localhost.localdomain> <4299EF16.2050208@pobox.com> <1117385429.4851.8.camel@localhost.localdomain> <4299F4E2.4020305@pobox.com> <1117387432.4851.13.camel@localhost.localdomain> <20050529172949.GA3578@havoc.gtf.org> <1117388703.4851.21.camel@localhost.localdomain> <429A036D.8090104@pobox.com> <1117390251.4851.24.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1117390251.4851.24.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 29, 2005 at 08:10:51PM +0200, Erik Slagter wrote:
> On Sun, 2005-05-29 at 14:01 -0400, Jeff Garzik wrote:
> > Erik Slagter wrote:
> > > I guess the only way to have, for example the ICH6, not using legacy
> > > IRQ/ports, is to switch it to AHCI, which only the BIOS can do (if
> > > implemented).
> > 
> > "native mode" is where PATA and/or SATA PCI device is programmed into 
> > full PCI mode -- PCI BARs, PCI irq, etc.  Some BIOSen allow you to 
> > enable mode, which disables all use of legacy IRQ/ports.
> > 
> > Also, ICH6 silicon does not support AHCI, only ICH6-R and ICH6-M.
> 
> So, I do have this laptop with ICH6-M, is there a way to get it in
> "native" mode without having to enable AHCI mode (can't do that, the
> BIOS doesn't allow it)?

Same as enabling AHCI mode -- really need a BIOS option to do that.


> I still think still using IRQ14/15 etc. is
> silly ;-)

<shrug>  IRQ14/15 are dedicated to IDE, whereas PCI irqs might be shared.
That can sometimes be faster, and/or lead to fewer problems.

	Jeff



