Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264522AbUDZM0w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264522AbUDZM0w (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Apr 2004 08:26:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264524AbUDZM0w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Apr 2004 08:26:52 -0400
Received: from smtp808.mail.sc5.yahoo.com ([66.163.168.187]:22610 "HELO
	smtp808.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S264522AbUDZM0u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Apr 2004 08:26:50 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: Re: [OOPS/HACK] atmel_cs and the latest changes in sysfs/symlink.c
Date: Mon, 26 Apr 2004 07:26:47 -0500
User-Agent: KMail/1.6.1
Cc: Russell King <rmk+lkml@arm.linux.org.uk>,
       Marcel Holtmann <marcel@holtmann.org>,
       Simon Kelley <simon@thekelleys.org.uk>
References: <200404230142.46792.dtor_core@ameritech.net> <200404251653.55385.dtor_core@ameritech.net> <20040425235844.E13748@flint.arm.linux.org.uk>
In-Reply-To: <20040425235844.E13748@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200404260726.47571.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 25 April 2004 05:58 pm, Russell King wrote:
> On Sun, Apr 25, 2004 at 04:53:53PM -0500, Dmitry Torokhov wrote:
> > On Friday 23 April 2004 03:39 pm, Russell King wrote:
> > > On Fri, Apr 23, 2004 at 10:14:24PM +0200, Marcel Holtmann wrote:
> > > > should we apply the pcmcia_get_sys_device() patch from Dmitry for now to
> > > > fix the current drivers that need a device for loading the firmware?
> > > 
> > > I don't think so - it obtains the struct device for the bridge itself
> > > which has nothing to do with the card inserted in the slot.
> > > 
> > 
> > Yes, my bad... I wonder if something like the patch below could be useful
> > for now (although it created only one device entry even if card has multiple
> > functions so we really need another device for every function):
> 
> This breaks modular builds - pcmcia_bus_type is in ds.c which is a
> separate module.
>

Ok, then one question before I shut up - why is it exported if other modules
can not use it?

-- 
Dmitry
