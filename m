Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261884AbUKVBf4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261884AbUKVBf4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Nov 2004 20:35:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261891AbUKVBfz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Nov 2004 20:35:55 -0500
Received: from fmr12.intel.com ([134.134.136.15]:21695 "EHLO
	orsfmr001.jf.intel.com") by vger.kernel.org with ESMTP
	id S261884AbUKVBfM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Nov 2004 20:35:12 -0500
Subject: Re: [PATCH] smsc-ircc2: Add PnP support.
From: Li Shaohua <shaohua.li@intel.com>
To: matthieu castet <castet.matthieu@free.fr>
Cc: Meelis Roos <mroos@linux.ee>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Jean Tourrilhes <jt@bougret.hpl.hp.com>, Adam Belay <ambx1@neo.rr.com>,
       Ville =?ISO-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
In-Reply-To: <41A0F893.9020106@free.fr>
References: <E1CVAfT-0002n9-Rn@rhn.tartu-labor> <419E16E5.1000601@free.fr>
	 <419E17FF.1000503@free.fr> <Pine.SOC.4.61.0411191822030.9059@math.ut.ee>
	 <419E2D2B.4020804@free.fr> <Pine.SOC.4.61.0411191934070.29328@math.ut.ee>
	 <419E3B7A.4000904@free.fr> <Pine.SOC.4.61.0411200102580.12992@math.ut.ee>
	 <419F136B.8010308@free.fr> <Pine.SOC.4.61.0411211949260.23880@math.ut.ee>
	 <41A0DB78.2010807@free.fr> <Pine.SOC.4.61.0411212050490.11420@math.ut.ee>
	 <41A0F893.9020106@free.fr>
Content-Type: text/plain
Message-Id: <1101086961.2940.7.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 22 Nov 2004 09:29:22 +0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-11-22 at 04:20, matthieu castet wrote:
> Meelis Roos wrote:
> >> Could I have the log from smsc-ircc2 when it failed with pnpacpi ?
> > 
> > 
> > found SMC SuperIO Chip (devid=0x5a rev=00 base=0x002e): LPC47N227
> > smsc_superio_flat(): IrDA not enabled
> > smsc_superio_flat(): fir: 0x00, sir: 0x00, dma: 15, irq: 0, mode: 0x02
> > 
> just for curiosity, when you have time, could try pnpacpi and jean PNP 
> smsc patch?
> 
> It sould find the correct resources because there are provided by PnP 
> layer, but if the resources are not well allocated by PnPacpi, the 
> device shouldn't work.
Could you please attach the output of 'cat 00:0a/resources' (0a is the
device, right?). ACPI spec said set resource should be according to the
output of current resource. That is we should build a template according
to current resource (_CRS). If _CRS doesn't return a correct resource
templete, set resource will fail.

Adam, I think a boot option (such as pnpacpi=off) is required. Users
possibly want to use pnpbios or BIOS is buggy.

Thanks,
Shaohua

