Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751010AbWCFAcf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751010AbWCFAcf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Mar 2006 19:32:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751089AbWCFAcf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Mar 2006 19:32:35 -0500
Received: from cavan.codon.org.uk ([217.147.92.49]:34730 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S1750959AbWCFAce (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Mar 2006 19:32:34 -0500
Date: Mon, 6 Mar 2006 00:32:22 +0000
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: PATA failure with piix, works with libata
Message-ID: <20060306003221.GA8805@srcf.ucam.org>
References: <20060303183937.GA30840@srcf.ucam.org> <20060305225733.GA8578@srcf.ucam.org> <440B770A.8090707@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <440B770A.8090707@garzik.org>
User-Agent: Mutt/1.5.9i
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mjg59@codon.org.uk
X-SA-Exim-Scanned: No (on vavatch.codon.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 05, 2006 at 06:40:58PM -0500, Jeff Garzik wrote:
> Matthew Garrett wrote:
> >Ok, it /seems/ that things are happier (though still not entirely happy) 
> >if I explicitly acknowledge the interrupt by writing the dma status 
> >register back again. This doesn't seem to be done anywhere in the IDE 
> >interrupt routine, but is in the libata one. I'm afraid I don't 
> >understand IDE well enough to have any idea what's going on here - is it 
> >possible that a piix in native mode (rather than legacy mode) and 
> >sharing an interrupt needs some special handling?
> 
> ICH definitely needs that irq ack...

Yeah, this is an ICH7. I can't find anything in drivers/ide that would 
result in it being done, which is why I'm kind of confused. ide_ack_intr 
seems to be defined to do nothing on x86 since IDE_ARCH_ACK_INTR isn't 
defined there?

-- 
Matthew Garrett | mjg59@srcf.ucam.org
