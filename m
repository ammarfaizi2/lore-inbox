Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261895AbVCUVLm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261895AbVCUVLm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 16:11:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261903AbVCUVJJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 16:09:09 -0500
Received: from mailgw4.technion.ac.il ([132.68.238.37]:21669 "EHLO
	mailgw4.technion.ac.il") by vger.kernel.org with ESMTP
	id S261890AbVCUU5e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 15:57:34 -0500
Date: Mon, 21 Mar 2005 22:57:21 +0200 (IST)
From: Jacques Goldberg <goldberg@phep2.technion.ac.il>
X-X-Sender: goldberg@localhost.localdomain
Reply-To: Jacques Goldberg <Jacques.Goldberg@cern.ch>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: Need break driver<-->pci-device automatic association
In-Reply-To: <20050321201847.A16069@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.58_heb2.09.0503212248010.7910@localhost.localdomain>
References: <Pine.LNX.4.58_heb2.09.0503181042470.8660@localhost.localdomain>
 <20050318165124.GC14952@kroah.com> <Pine.LNX.4.58_heb2.09.0503192021431.11358@localhost.localdomain>
 <20050321081638.GC2703@pazke> <20050321082228.A22099@flint.arm.linux.org.uk>
 <Pine.LNX.4.58_heb2.09.0503211336090.6491@localhost.localdomain>
 <20050321201847.A16069@flint.arm.linux.org.uk>
X-MailKey: 829.36.63
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


   Great, Russell. Now we understand each other.
   Actually some chip manufacturers are responsible for this mess. Some do
NOT burn a modem class flag in the hardware, others do.
   Is it nonsense to imagine that the part of 8250_pci which handles modem
class become a loadable module?
   We could then load the "linmodem" driver first, which would not disturb
use of true modems.
   My suggestion is very likely going to reveal the depth of my ignorance
about kernel architecture, I guess.

                                             Jacques

On Mon, 21 Mar 2005, Russell King wrote:

> On Mon, Mar 21, 2005 at 01:39:30PM +0200, Jacques Goldberg wrote:
> >       Here is a modem which cannot be used because it is grabbed by the
> > serial driver:
> >
> > 00:0f.0 Modem: ALi Corporation SmartLink SmartPCI561 56K Modem (prog-if 00
> > [Generic])
>
> Ok, this is what I wanted to know.
>
> There seems to be growing evidence that 8250_pci should not claim the
> "modem" class, but should match any such cards which do look like
> serial ports by vendor/device IDs.The problem is that dropping the
> modem class id match could leave a fair number of people in the lurch,
> but I'm game to try it and see.
>
> --
> Russell King
>  Linux kernel  2.6 ARM Linux   - http://www.arm.linux.org.uk/
>  maintainer of:2.6 Serial core
>

                                Jacques.Goldberg@cern.ch
                                >>>> Currently at TECHNION <<<<
                                PHONE: Technion=+(972)(0)(4)829.36.63
                                           CERN=+(41)(22)767.73.85
                                FAX:   Technion=+(972)(0)(4)829.39.01
                                           CERN=+(41)(22)767.31.00
                                HOME: Haifa=+(972)(4)825.29.04
                                GSM portable: +(972)(0)544.29.36.63
