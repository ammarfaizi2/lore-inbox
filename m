Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263146AbTENXTt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 19:19:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263150AbTENXTt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 19:19:49 -0400
Received: from palrel11.hp.com ([156.153.255.246]:36253 "EHLO palrel11.hp.com")
	by vger.kernel.org with ESMTP id S263146AbTENXTr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 19:19:47 -0400
Date: Wed, 14 May 2003 16:32:35 -0700
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@digeo.com>,
       David Gibson <hermes@gibson.dropbear.id.au>,
       Benjamin Reed <breed@almaden.ibm.com>,
       Javier Achirica <achirica@ttd.net>, Jouni Malinen <jkmaline@cc.hut.fi>
Subject: Re: airo and firmware upload (was Re: 2.6 must-fix list, v3)
Message-ID: <20030514233235.GA11581@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <20030514211222.GA10453@bougret.hpl.hp.com> <3EC2BDEC.6020401@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EC2BDEC.6020401@pobox.com>
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 14, 2003 at 06:06:36PM -0400, Jeff Garzik wrote:
> Jean Tourrilhes wrote:
> >	o get the latest airo.c fixes from CVS. This will hopefully
> >fix problems people have reported on the LKML.
> 
> please beg Javier to split up his patch.  He sends me a _huge_ patch 
> with tons of changes each time.  If I object to one thing, we spin in 
> another huge-patch loop... :/
> 
> Sending me 20, 50, 100 patches to the same file is ok.  Even encouraged.

	Javier is cc'ed.
	While we are on the subject : a few months ago, Javier added
support for MIC to the airo driver. It's basically crypto based on
AES. You refused to include that part in the kernel because crypto was
not accepted in the kernel.
	Fast forward : today we have crypto in the 2.5.X kernel. Does
this mean that you would have no objection accepting a patch from
Javier including the crypto part ?

> >	o get HostAP driver in the kernel. No consolidation of the
> >802.11 management across driver can happen until this one is in (which
> >is probably 2.7.X material). I think Jouni is mostly ready but didn't
> >find time for it.
> 
> yeah, there are many requests for this one

	By the way, the HostAP driver include crypto (currently only
RC4 for WEP). Same question, I hope you would not refuse the crypto
part of HostAP (which is mandatory because most PrismII firmwares are
broken and can't do basic WEP properly).

> >	o The last two drivers mentioned above are held up by firmware
> >issues (see flamewar on LKML a few days ago). So maybe fixing those
> >firmware issues should be a requirement for 2.6.X, because we can
> >expect more wireless devices to need firmware upload at startup coming
> >to market.
> 
> >	As this firmware business seems to me not a wireless specific
> >issue (see for example drivers/scsi/qlogicfc_asm.c or
> >drivers/atm/atmsar11.data), I would prefer a generic solution to that
> >problem, either saying it's OK to put firmware in the kernel (with
> >proper licensing) or providing working technical solutions.
> 
> 
> We need firmware upload, and, firmware _should_ be uploaded from userspace.

	Ok, so I ask it this way : currently the kernel include some
drivers containing some binary firmwares blobs which are linked
directly into the kernel/module (including networking). Does this mean
that you are going to remove those driver from the kernel ASAP ? Or
does this mean that the rule above only apply to wireless drivers ?
	Let's be logical and coherent here...

> All someone needs to do is actually write the code for their driver to 
> receive firmware from userspace, and the rest is easy.  A working 
> technical solution is obvious, it just needs interested parties to 
> implement.
> 
> We can upload firmware from initrd, if no boot device is available at 
> the time.

	Currently, it looks like every driver will use its own method,
which I guess is ok.

> 	Jeff

	Thanks !

	Jean
