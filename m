Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265906AbUAUAbJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 19:31:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265908AbUAUAbJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 19:31:09 -0500
Received: from mail.kroah.org ([65.200.24.183]:21673 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265906AbUAUAar (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 19:30:47 -0500
Date: Tue, 20 Jan 2004 16:30:52 -0800
From: Greg KH <greg@kroah.com>
To: Andi Kleen <ak@suse.de>
Cc: Gerd Knorr <kraxel@suse.de>, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [patch] -mm5 has no i2c on amd64
Message-ID: <20040121003052.GB5472@kroah.com>
References: <20040120124626.GA20023@bytesex.org.suse.lists.linux.kernel> <p73n08ihj25.fsf@verdi.suse.de> <20040120183259.GA23706@bytesex.org> <20040120195132.1dbaabb8.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040120195132.1dbaabb8.ak@suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 20, 2004 at 07:51:32PM +0100, Andi Kleen wrote:
> On Tue, 20 Jan 2004 19:32:59 +0100
> Gerd Knorr <kraxel@suse.de> wrote:
> 
> > On Tue, Jan 20, 2004 at 01:59:46PM +0100, Andi Kleen wrote:
> > > Gerd Knorr <kraxel@bytesex.org> writes:
> > > > 
> > > > +++ linux-mm5-2.6.1/arch/x86_64/Kconfig	2004-01-20 13:15:10.000000000 +0100
> > > > +source "drivers/i2c/Kconfig"
> > > > +
> > > 
> > > There is no such source in arch/i386/Kconfig.  So it's probably wrong.
> > 
> > i386 includes that indirectly via drivers/Kconfig
> > So should the other archs do that too?
> 
> Yep. Or at least x86-64 should likely.
> 
> But it must have worked until recently because I got a report about I2C on x86-64 for 2.6.0.

Yes, I just moved the i2c Kconfig out of the char menu, and into the
main drivers/Kconfig.

And here I thought all of the archs had switched to using that file,
instead of trying to put together their own drivers menus :)

thanks,

greg k-h
