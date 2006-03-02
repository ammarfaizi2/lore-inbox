Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751221AbWCBMYp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751221AbWCBMYp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 07:24:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751335AbWCBMYp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 07:24:45 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:9226 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751221AbWCBMYo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 07:24:44 -0500
Date: Thu, 2 Mar 2006 12:24:09 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Arjan van de Ven <arjan@infradead.org>, Jens Axboe <axboe@suse.de>,
       Dominik Brodowski <linux@dominikbrodowski.net>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pcmcia: add another ide-cs CF card id
Message-ID: <20060302122409.GD14017@flint.arm.linux.org.uk>
Mail-Followup-To: Jeff Garzik <jgarzik@pobox.com>,
	Arjan van de Ven <arjan@infradead.org>, Jens Axboe <axboe@suse.de>,
	Dominik Brodowski <linux@dominikbrodowski.net>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <200603012259.k21MxBXC013582@hera.kernel.org> <44062FF1.4010108@pobox.com> <20060302075004.GA17789@isilmar.linta.de> <4406D44A.4020101@pobox.com> <1141299117.3206.37.camel@laptopd505.fenrus.org> <20060302114220.GH4329@suse.de> <1141301225.3206.50.camel@laptopd505.fenrus.org> <4406E1C7.7020908@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4406E1C7.7020908@pobox.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 02, 2006 at 07:15:03AM -0500, Jeff Garzik wrote:
> Arjan van de Ven wrote:
> >Sure I can it being nice to CC linux-ide ANYWAY, but, to be honest,
> >while I see that is important for changes to the driver that change the
> >structure of it and how it interacts with the IDE layer, I fail to see
> >the hard required reason for that for just adding a *PCMCIA* ID.
> >
> >I think Jeff is a bit overreacting in this case.
> 
> About a quarter of the time when non-netdev maintainers add IDs, through 
> the magic of merges, we've wound up with duplicate IDs in the driver. 
> I've snipped several duplicate IDs from tulip and other net drivers over 
> the years.
> 
> Further, in the past Brodo has _already_ been asked to CC relevant 
> maintainers and lists -- or at least LKML -- with his patches.  He has 
> established a pattern of lacking time to add CC's to his emails; it 
> wasn't just this incident.
> 
> Where is the peer review?

I think it's fairly safe and obvious to say that Dominik is the peer
review for these tables - he _is_ the PCMCIA maintainer, he _is_
arguably the maintainer for the ide-cs driver, he _is_ the person
who invented these tables, he _is_ the one taking patches from people
to add IDs, he _is_ the one reviewing such patches.

If you want to know what's going on in PCMCIA land, subscribe to
linux-pcmcia.  In the same way that if you want to know what's going
in in IDE land, you subscribe to linux-ide, or PCI land linux-pci,
SCSI land linux-scsi, network land netdev.

Using your argument (which seems to be demanding that any patch to
any IDE driver no matter how trivial must be on linux-ide) that a patch
to a PCI network device driver must be copied to linux-pci and netdev
even though it may not touch the PCI specific code.

What about a cardbus network card?  Should any patch no matter how
trivial be sent to netdev, linux-pci and linux-pcmcia - all those three
mailing lists are within the "sphere of influence" of any patch to that
driver.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
