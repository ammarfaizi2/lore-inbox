Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272240AbTG3U5U (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 16:57:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272241AbTG3U5U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 16:57:20 -0400
Received: from [64.140.61.236] ([64.140.61.236]:14219 "EHLO diva.home")
	by vger.kernel.org with ESMTP id S272240AbTG3U5S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 16:57:18 -0400
From: Michael Driscoll <fenris@ulfheim.net>
Organization: FFW/CO
To: linux-kernel@vger.kernel.org
Subject: Re: OOPS 2.6.0-test2, modprobe i810fb
Date: Wed, 30 Jul 2003 14:56:04 -0600
User-Agent: KMail/1.5.2
References: <Pine.LNX.3.96.1030729225445.27753D-100000@gatekeeper.tmr.com>
In-Reply-To: <Pine.LNX.3.96.1030729225445.27753D-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307301456.04083.fenris@ulfheim.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 29 July 2003 20:56, Bill Davidsen wrote:
> > diff -puN drivers/char/agp/intel-agp.c~intel-agp-oops-fix
> > drivers/char/agp/intel-agp.c ---
> > 25/drivers/char/agp/intel-agp.c~intel-agp-oops-fix	2003-07-28
> > 22:30:30.000000000 -0700 +++
> > 25-akpm/drivers/char/agp/intel-agp.c	2003-07-28 22:30:53.000000000 -0700
> > @@ -1426,7 +1426,7 @@ static struct pci_device_id agp_intel_pc
> >  	.subvendor	= PCI_ANY_ID,
> >  	.subdevice	= PCI_ANY_ID,
> >  	},
> > -	{ }
> > +	{ 0, },
> >  };
> >
> >  MODULE_DEVICE_TABLE(pci, agp_intel_pci_table);
> >
> > _
>
> Sure about that last comma? Any compiler version issues?

It's allowed in K&R2 (and explicitly marked as a feature, see pp.218-219).

I don't have C99 handy but I'm pretty sure it's still legal.

-- 
Michael Driscoll, fenris@ulfheim.net
"A noble spirit embiggens the smallest man" -- J. Springfield
