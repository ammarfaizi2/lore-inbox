Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262571AbVHDP7E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262571AbVHDP7E (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 11:59:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262622AbVHDP6g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 11:58:36 -0400
Received: from atlrel7.hp.com ([156.153.255.213]:63164 "EHLO atlrel7.hp.com")
	by vger.kernel.org with ESMTP id S262585AbVHDP57 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 11:57:59 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: matthieu castet <castet.matthieu@free.fr>
Subject: Re: [ACPI] Re: [PATCH] PNPACPI: fix types when decoding ACPI resources [resend]
Date: Thu, 4 Aug 2005 09:57:55 -0600
User-Agent: KMail/1.8.1
Cc: acpi-devel@lists.sourceforge.net, Shaohua Li <shaohua.li@intel.com>,
       Adam Belay <ambx1@neo.rr.com>, linux-kernel@vger.kernel.org
References: <200508020955.54844.bjorn.helgaas@hp.com> <200508031541.53777.bjorn.helgaas@hp.com> <42F20C5B.3020506@free.fr>
In-Reply-To: <42F20C5B.3020506@free.fr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508040957.55485.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 04 August 2005 6:38 am, matthieu castet wrote:
> Bjorn Helgaas wrote:
> > On Wednesday 03 August 2005 3:16 pm, matthieu castet wrote:
> >>Bjorn Helgaas wrote:
> >> > 	drivers/char/hpet.c
> >> > 		This probably should be converted to PNP.  I'll
> >> > 		look into doing this.
> >>IIRC, I am not sure that the pnp layer was able to pass the 64 bits 
> >>memory adress for hpet correctly. But it would be nice if it works.
> > 
> > You're right, this was broken.  But I've been pushing a PNPACPI
> > patch to fix this.
> > 
> Yes but is ACPI_RSTYPE_ADDRESS64 possible on 32 bit machine ?

I can't think of a case where that would make sense, but I don't
actually know the answer.

> In this case your patch won't work as res->mem_resource[i].start and 
> res->mem_resource[i].end are unsigned long, and 64 bit value won't fit.

True.  But fixing that would be pretty far-reaching (changing struct
resource), so I'm not worried until it is shown to be a problem.
