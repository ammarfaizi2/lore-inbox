Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264242AbTGBSGe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 14:06:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264256AbTGBSGe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 14:06:34 -0400
Received: from host-64-213-145-173.atlantasolutions.com ([64.213.145.173]:64642
	"EHLO havoc.gtf.org") by vger.kernel.org with ESMTP id S264242AbTGBSGb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 14:06:31 -0400
Date: Wed, 2 Jul 2003 14:20:56 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Jurgen Kramer <gtm.kramer@inter.nl.net>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: ata-scsi driver update
Message-ID: <20030702182056.GA15495@gtf.org>
References: <3F00CEDC.2010806@pobox.com> <1057086391.3444.3.camel@paragon.slim> <3F01E030.9060201@pobox.com> <1057089782.3274.1.camel@paragon.slim> <3F01F125.4060907@pobox.com> <1057169057.3261.7.camel@paragon.slim>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1057169057.3261.7.camel@paragon.slim>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 02, 2003 at 08:04:17PM +0200, Jurgen Kramer wrote:
> Only my DVD-ROM doesn't show here. It should be on scsi1 (or is ATAPI
> support not in yet?)

Correct, ATAPI isn't supported yet.


> What also shows is that ata1 is not being
> configured for maximum possible speed. Ata1 should be set to UDMA/100.

Correct.  For PATA, the code does not yet do 40/80-conductor cable
detection.  Without that detection, it's not safe to drive a PATA device
faster than UDMA/33.


> The SATA drive is configured properly though.

Yeah, SATA doesn't need to worry about PATA cable detection 
issues :)

Both ATAPI and PATA cable detection should be working in the next
release (a week or two from now).

	Jeff



