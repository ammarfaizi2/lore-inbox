Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135910AbRD0Eb1>; Fri, 27 Apr 2001 00:31:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135971AbRD0EbR>; Fri, 27 Apr 2001 00:31:17 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:58339 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S135910AbRD0EbI>; Fri, 27 Apr 2001 00:31:08 -0400
Date: Thu, 26 Apr 2001 22:31:04 -0600
Message-Id: <200104270431.f3R4V4630593@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Jonathan Lundell <jlundell@pobox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] adding PCI bus information to SCSI layer
In-Reply-To: <p05100313b70bb73ce962@[207.213.214.37]>
In-Reply-To: <CDF99E351003D311A8B0009027457F140810E286@ausxmrr501.us.dell.com>
	<200104242159.f3OLxoB07000@vindaloo.ras.ucalgary.ca>
	<p05100313b70bb73ce962@[207.213.214.37]>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jonathan Lundell writes:
> At 3:59 PM -0600 4/24/01, Richard Gooch wrote:
> >The plan I have (which I hope to get started on soon, now that I'm
> >back from travels), is to change /dev/scsi/host# from a directory into
> >a symbolic link to a directory called: /dev/bus/pci0/slot1/function0.
> >Thus, to access a partition via location, one would use the path:
> >/dev/bus/pci0/slot1/function0/bus0/target1/lun2/part3.
> 
> A minor PCI terminology point: PCI buses are subdivided into
> devices, not (necessarily) slots. So, for example, a multiple-device
> PCI card (say, two SCSI controllers) might have a PCI bridge
> creating a new bus, and two devices (not slots) on that bus. (It
> could alternatively be implemented as a single device with two
> functions, given a dual-interface chip, but not necessarily.)
>
> So a better name would be
> /dev/bus/pci0/dev1/fcn0/bus0/tgt1/lun2/part3 (taking the liberty of
> abbreviating some of the other names).

Sure. I haven't made a decision on the names yet. I was just sketching
out the idea.

> How, if at all, would RAID devices, using more than one physical
> device, or SCSI bus, or PCI card, fit into this naming scheme?

Same as it does now. There's the underlying devices, and then the meta
devices, which are under /dev/md.

BTW: please fix your mailer to do linewrap at 72 characters. Your
lines are hundreds of characters long, and that's hard to read.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
