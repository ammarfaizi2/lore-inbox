Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965914AbWKTP3g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965914AbWKTP3g (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 10:29:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965916AbWKTP3g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 10:29:36 -0500
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:35080 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S965914AbWKTP3f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 10:29:35 -0500
Date: Mon, 20 Nov 2006 15:29:27 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Tony Olech <tony.olech@elandigitalsystems.com>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>,
       Linux kernel development <linux-kernel@vger.kernel.org>,
       PCMCIA Maintainence <linux-pcmcia@lists.infradead.org>,
       David Hinds <dahinds@users.sourceforge.net>,
       Jaroslav Kysela <perex@suse.cz>,
       Bart Prescott <bart.prescott@elandigitalsystems.com>
Subject: Re: [PATCH] PCMCIA identification strings for cards manufactured by Elan
Message-ID: <20061120152927.GA26791@flint.arm.linux.org.uk>
Mail-Followup-To: Tony Olech <tony.olech@elandigitalsystems.com>,
	Dominik Brodowski <linux@dominikbrodowski.net>,
	Linux kernel development <linux-kernel@vger.kernel.org>,
	PCMCIA Maintainence <linux-pcmcia@lists.infradead.org>,
	David Hinds <dahinds@users.sourceforge.net>,
	Jaroslav Kysela <perex@suse.cz>,
	Bart Prescott <bart.prescott@elandigitalsystems.com>
References: <200611201214.kAKCErcU005240@imap.elan.private> <20061120130237.GA22330@flint.arm.linux.org.uk> <1164032582.30853.36.camel@n04-143.elan.private>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1164032582.30853.36.camel@n04-143.elan.private>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20, 2006 at 02:23:02PM +0000, Tony Olech wrote:
> Hi,
> The strings came from our company product database.
> I do not have the time to track down examples of each
> varient, but here are the two I have been testing with:
> 
> Socket 0:
>   product info: "Elan", "Serial+Parallel Port: SP230", "1.00",
> "KIT:K51477-006           "
>   manfid: 0x015d, 0x4c45
>   function: 2 (serial)
> 
> Socket 1:
>   product info: "Elan", "Serial Port: SL332", "1.01", "KIT:K51520-027
> "
>   manfid: 0x015d, 0x4c45
>   function: 2 (serial)
> 
> AND NO, matching on function ID just randomly locked up the
> kernel, but now I think that was because of the "pdaudiocf"
> module and its MANF_ID/CARD_ID number matching.

The obvious question is - if you only remove the IDs from pdaudiocf, does
it then work?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
