Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966285AbWKTRpz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966285AbWKTRpz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 12:45:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966287AbWKTRpz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 12:45:55 -0500
Received: from isilmar.linta.de ([213.239.214.66]:61888 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S966285AbWKTRpy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 12:45:54 -0500
Date: Mon, 20 Nov 2006 12:45:52 -0500
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Tony Olech <tony.olech@elandigitalsystems.com>,
       Linux kernel development <linux-kernel@vger.kernel.org>,
       PCMCIA Maintainence <linux-pcmcia@lists.infradead.org>,
       David Hinds <dahinds@users.sourceforge.net>,
       Jaroslav Kysela <perex@suse.cz>,
       Bart Prescott <bart.prescott@elandigitalsystems.com>
Subject: Re: [PATCH] PCMCIA identification strings for cards manufactured by Elan
Message-ID: <20061120174552.GB18660@isilmar.linta.de>
Mail-Followup-To: Tony Olech <tony.olech@elandigitalsystems.com>,
	Linux kernel development <linux-kernel@vger.kernel.org>,
	PCMCIA Maintainence <linux-pcmcia@lists.infradead.org>,
	David Hinds <dahinds@users.sourceforge.net>,
	Jaroslav Kysela <perex@suse.cz>,
	Bart Prescott <bart.prescott@elandigitalsystems.com>
References: <200611201214.kAKCErcU005240@imap.elan.private> <20061120130237.GA22330@flint.arm.linux.org.uk> <1164032582.30853.36.camel@n04-143.elan.private> <20061120152927.GA26791@flint.arm.linux.org.uk> <1164041509.30853.48.camel@n04-143.elan.private> <20061120172731.GC26791@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061120172731.GC26791@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20, 2006 at 05:27:31PM +0000, Russell King wrote:
> On Mon, Nov 20, 2006 at 04:51:48PM +0000, Tony Olech wrote:
> > Hi Russell,
> > if I take out the patches to parport_cs and serial_cs,
> > leaving in only the patch to "pdaudiocf" our SP230 card
> > no longer works - it does not lock up the kernel, admittedly,
> > and the serial only card does works, but we would like
> > all are cards to just work.
> 
> Sounds like function ID matching is broken.  Dominik?

No, it isn't -- it is a multifunction card, and these require special
care (i.e. manf_id / prod_id matches). If func_id says "multifunction", that
does not say anything about which drivers to use...

Thanks,
	Dominik
