Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932273AbWFYKPt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932273AbWFYKPt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jun 2006 06:15:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932291AbWFYKPt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jun 2006 06:15:49 -0400
Received: from mail13.bluewin.ch ([195.186.18.62]:48042 "EHLO
	mail13.bluewin.ch") by vger.kernel.org with ESMTP id S932273AbWFYKPs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jun 2006 06:15:48 -0400
Date: Sun, 25 Jun 2006 12:14:20 +0200
From: Roger Luethi <rl@hellgate.ch>
To: Jeff Garzik <jeff@garzik.org>
Cc: akpm@osdl.org, Linux Kernel <linux-kernel@vger.kernel.org>,
       enrico.scholz@informatik.tu-chemnitz.de, greg@kroah.com
Subject: Re: + via-rhine-on-epia-pd-needs.patch added to -mm tree
Message-ID: <20060625101420.GA15771@k3.hellgate.ch>
References: <200606242219.k5OMIxxY006085@shell0.pdx.osdl.net> <449DBF48.2050607@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <449DBF48.2050607@garzik.org>
X-Operating-System: Linux 2.6.16 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 24 Jun 2006 18:40:08 -0400, Jeff Garzik wrote:
> akpm@osdl.org wrote:
> >     via-rhine on epia-pd needs irq-quirk
> >
> >has been added to the -mm tree.  Its filename is
> >
> >     via-rhine-on-epia-pd-needs.patch
> 
> It strikes me as very unwise to do this.  I know that some VIA Rhine 
> exist on a PCI card, which is a valid case where this quirk should -not- 
> be executed.

There are PCI cards for each of Rhine-I, -II, and -III.

> The VIA quirk is only for on-motherboard devices, which have special PCI 
> interrupt line behavior (makes some internal PIC connections).

What exactly does on-motherboard mean in this context? Separate chip
soldered to the motherboard? Or integrated into the south bridge? Or both?

> How can we solve this conditionally?  I agree this is needed...  for 

VIA uses the PCI revision number to identify their chips. In fact, I have
some patch lying around that identifies the model of every Rhine ever
produced (at the time, anyway): VT86C100A, VT6102, VT8231, VT8233, VT8235,
VT8237, VT6105, VT6105L, VT6107, and VT6105M. I am not sure whether this
can be used to identify the models with this particular quirk, though.

> on-mobo devices.  But 0x3065 is not always glued in, AFAIK.

Correct. But 0x3065 is fairly meaningless in VIA world.

Roger
