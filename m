Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751280AbVI2WBl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751280AbVI2WBl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 18:01:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751316AbVI2WBl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 18:01:41 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:52753 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751280AbVI2WBk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 18:01:40 -0400
Date: Thu, 29 Sep 2005 23:01:34 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Pavel Machek <pavel@ucw.cz>
Cc: Marcel Holtmann <marcel@holtmann.org>, bluez-devel@lists.sourceforge.net,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Problems with CF bluetooth
Message-ID: <20050929220134.GJ7684@flint.arm.linux.org.uk>
Mail-Followup-To: Pavel Machek <pavel@ucw.cz>,
	Marcel Holtmann <marcel@holtmann.org>, bluez-devel@lists.sf.net,
	kernel list <linux-kernel@vger.kernel.org>
References: <1128008752.5123.28.camel@localhost.localdomain> <20050929155602.GA1990@elf.ucw.cz> <1128011355.30743.14.camel@localhost.localdomain> <20050929175420.GN1990@elf.ucw.cz> <1128016693.6052.2.camel@localhost.localdomain> <20050929213219.GA2180@elf.ucw.cz> <20050929213707.GH7684@flint.arm.linux.org.uk> <20050929214340.GB2180@elf.ucw.cz> <20050929214559.GI7684@flint.arm.linux.org.uk> <20050929215234.GC2180@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050929215234.GC2180@elf.ucw.cz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 29, 2005 at 11:52:34PM +0200, Pavel Machek wrote:
> Hi!
> 
> > > > > > > I believe it would happen with any other CF card, too. Can you
> > > > > > > hciattach it, unplug, hciattach again?
> > > > > > 
> > > > > > actually I don't have any of them with me and I don't saw a problem with
> > > > > > my Casira of a serial port.
> > > > > 
> > > > > Following patch seems to work around it. And yes, printk() triggers
> > > > > twice after 
> > > > 
> > > > What's the problem this patch is trying to address?
> > > 
> > > I get oops after starting my bluetooth subsystem for second
> > > time. billionton_start, unplug CF, billionton_start will oops the
> > > system. That patch prevents it.
> > 
> > More details please.  I don't have the ability to run bluetooth myself.
> 
> Unfortunately I do not know much about bluetooth. The card is
> basically CF serial with bluetooth chip attached to that. billionton
> start does setserial, then attaches bluetooth subsystem to that chip,
> and enables bluetooth.

How about showing the oops?  The patch is definitely wrong btw - there's
no way state->info should be NULL here.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
