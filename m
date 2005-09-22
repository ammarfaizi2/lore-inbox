Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751464AbVIVKWb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751464AbVIVKWb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 06:22:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751465AbVIVKWb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 06:22:31 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:12810 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751464AbVIVKWb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 06:22:31 -0400
Date: Thu, 22 Sep 2005 11:22:21 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Mark Lord <liml@rtr.ca>, Richard Purdie <rpurdie@rpsys.net>,
       LKML <linux-kernel@vger.kernel.org>,
       Dominik Brodowski <linux@dominikbrodowski.net>, bzolnier@gmail.com,
       linux-ide@vger.kernel.org
Subject: Re: [RFC/BUG?] ide_cs's removable status
Message-ID: <20050922102221.GD16949@flint.arm.linux.org.uk>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Mark Lord <liml@rtr.ca>, Richard Purdie <rpurdie@rpsys.net>,
	LKML <linux-kernel@vger.kernel.org>,
	Dominik Brodowski <linux@dominikbrodowski.net>, bzolnier@gmail.com,
	linux-ide@vger.kernel.org
References: <1127319328.8542.57.camel@localhost.localdomain> <1127321829.18840.18.camel@localhost.localdomain> <433196B6.8000607@rtr.ca> <1127327243.18840.34.camel@localhost.localdomain> <20050921192932.GB13246@flint.arm.linux.org.uk> <1127347845.18840.53.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1127347845.18840.53.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 22, 2005 at 01:10:44AM +0100, Alan Cox wrote:
> With drive->removable = 0 if I insert a card I get partition tables, it
> will then not rescan that in future even if the card changed, because
> there is no "media change detect" line, unlike on a floppy.
> 
> If I pull the CF adapter out it is fine because you get pcmcia level
> hotplug but that is not neccessary for card changing on better designed
> adapters or when the CF adapter is on the board itself with a CF slot
> exposed to the user.

Interesting - all my CF adapters (and I have several, some cheapo
noname things to some branded ones) are dumb pieces of hardware -
they merely convert the PCMCIA connector to a CF connector, just as
dumb as those 240V mains adapters.

Also, "CF" is just a different form factor of PCMCIA - don't get
mislead by the term "Compact Flash" - you can get "CF" network
cards, serial cards, bluetooth cards, etc as well.  They're exactly
the same as PCMCIA network, serial, bluetooth cards, just in a
smaller package.

If you have a CF adapter which behaves as you describe above, could
you please check what happens as far as PCMCIA goes when you unplug
the CF card - particularly what happens to cardctl status / cardctl
ident ?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
