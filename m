Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966196AbWKTQyR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966196AbWKTQyR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 11:54:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966197AbWKTQyR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 11:54:17 -0500
Received: from c2bthomr12.btconnect.com ([194.73.73.228]:54117 "EHLO
	c2bthomr12.btconnect.com") by vger.kernel.org with ESMTP
	id S966196AbWKTQyQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 11:54:16 -0500
Subject: Re: [PATCH] PCMCIA identification strings for cards manufactured
	by Elan
From: Tony Olech <tony.olech@elandigitalsystems.com>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>,
       Linux kernel development <linux-kernel@vger.kernel.org>,
       PCMCIA Maintainence <linux-pcmcia@lists.infradead.org>,
       David Hinds <dahinds@users.sourceforge.net>,
       Jaroslav Kysela <perex@suse.cz>,
       Bart Prescott <bart.prescott@elandigitalsystems.com>
In-Reply-To: <20061120152927.GA26791@flint.arm.linux.org.uk>
References: <200611201214.kAKCErcU005240@imap.elan.private>
	 <20061120130237.GA22330@flint.arm.linux.org.uk>
	 <1164032582.30853.36.camel@n04-143.elan.private>
	 <20061120152927.GA26791@flint.arm.linux.org.uk>
Content-Type: text/plain
Organization: Elan Digital Systems Limited
Date: Mon, 20 Nov 2006 16:51:48 +0000
Message-Id: <1164041509.30853.48.camel@n04-143.elan.private>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0-1mdv2007.0 
Content-Transfer-Encoding: 7bit
Elan-checked-message-originator: tony.olech@elandigitalsystems.com == tony-olech
Elan-message-recipient: rmk+lkml@arm.linux.org.uk
Elan-message-recipient: linux@dominikbrodowski.net
Elan-message-recipient: linux-pcmcia@lists.infradead.org
Elan-message-recipient: perex@suse.cz
Elan-message-recipient: dahinds@users.sourceforge.net
Elan-message-recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Russell,
if I take out the patches to parport_cs and serial_cs,
leaving in only the patch to "pdaudiocf" our SP230 card
no longer works - it does not lock up the kernel, admittedly,
and the serial only card does works, but we would like
all are cards to just work.

ALSO, I have found no way to force a particular 16-bit
pcmcia card to be handled by a particular module in a
similar way to the USB generic serial driver module
parameter. Have I misssed the obvious? Or is that a
desirable feature that have been taken out of the David
Hinds original implementation?

Tony Olech
Elan Digital Systems Limited
----------------------------------------------------------
On Mon, 2006-11-20 at 15:29 +0000, Russell King wrote:
> On Mon, Nov 20, 2006 at 02:23:02PM +0000, Tony Olech wrote:
> > Hi,
> > The strings came from our company product database.
> > I do not have the time to track down examples of each
> > varient, but here are the two I have been testing with:
> > 
> > Socket 0:
> >   product info: "Elan", "Serial+Parallel Port: SP230", "1.00",
> > "KIT:K51477-006           "
> >   manfid: 0x015d, 0x4c45
> >   function: 2 (serial)
> > 
> > Socket 1:
> >   product info: "Elan", "Serial Port: SL332", "1.01", "KIT:K51520-027
> > "
> >   manfid: 0x015d, 0x4c45
> >   function: 2 (serial)
> > 
> > AND NO, matching on function ID just randomly locked up the
> > kernel, but now I think that was because of the "pdaudiocf"
> > module and its MANF_ID/CARD_ID number matching.
> 
> The obvious question is - if you only remove the IDs from pdaudiocf, does
> it then work?
> 

