Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266670AbUHWUMP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266670AbUHWUMP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 16:12:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266378AbUHWUK0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 16:10:26 -0400
Received: from av2-1-sn3.vrr.skanova.net ([81.228.9.107]:38596 "EHLO
	av2-1-sn3.vrr.skanova.net") by vger.kernel.org with ESMTP
	id S267335AbUHWS7p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 14:59:45 -0400
Subject: Re: dma problems with Serverworks CSB5 chipset
From: =?ISO-8859-1?Q?Torbj=F6rn?= Olander <tosse@wlug.westbo.se>
To: linux-kernel@vger.kernel.org
In-Reply-To: <1091988557.769.18.camel@iota>
References: <4107E4B3.6070904@watson.wustl.edu>
	 <20040803180821.GB6265@logos.cnet>
	 <1091554289.3898.5.camel@localhost.localdomain>
	 <1091988557.769.18.camel@iota>
Content-Type: text/plain; charset=ISO-8859-1
Message-Id: <1093287580.1884.1.camel@iota>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 23 Aug 2004 20:59:41 +0200
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just want to report that after changing the disks to two Maxtor 6Y160P0
drives it works fine so the problem must be something in the combination
of CSB5 + WD400BB.

On Sun, 2004-08-08 at 20:09, Torbjörn Olander wrote:
> I'm having the same problems here with linux 2.6.8-rc2 kernel here with
> an Intel SAI2 dual SMP P3 motherboard with Serverworks Serverset III LE
> chipset and CSB5 southbridge.
> 
> I run one WDC WD400BB-00DEA0 as master on each channel with SW RAID1 for
> system. To even get DMA working I had to add
> append="ide0=ata66 ide1=ata66"
> in my lilo config. The system works fine with low load on the disks, but
> if I copy greater amounts of data from a local SW RAID5 array I get the
> same DMA timeout error and often it locks up completely.
> 
> If i disable DMA with hdparm the system works fine.
> 
> /proc/ide/svwks output:
> (DMA disabled with hdparm)
> 
>                              ServerWorks OSB4/CSB5/CSB6
> 
>                             ServerWorks CSB5 Chipset (rev 93)
> ------------------------------- General Status
> ---------------------------------
> --------------- Primary Channel ---------------- Secondary Channel
> -------------
>                  enabled                          enabled
> --------------- drive0 --------- drive1 -------- drive0 ----------
> drive1 ------
> DMA enabled:    no               no              no                no 
> UDMA enabled:   yes              no              yes               no 
> UDMA enabled:   2                0               2                 0
> DMA enabled:    2                2               2                 2
> PIO  enabled:   4                0               4                 0
> 
> 
> 
> On Tue, 2004-08-03 at 19:31, Alan Cox wrote:
> > On Maw, 2004-08-03 at 19:08, Marcelo Tosatti wrote:
> > > ServerWorks OSB4/5 chipsets are known to not work reliably with the Linux
> > > IDE code. AFAIK its a hardware problem which we dont correctly work around.
> > > 
> > > Have you tried disabling DMA?
> > > 
> > > Bart and Alan are IDE experts, they can probably give you more useful
> > > information.
> > 
> > CSB5 is reliable, rock solidly so in my experience. OSB4 was the older
> > interface with problems. Are these systems SMP, what disks are you using
> > and in what IDE mode ?
> > 
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
-- 
Med vänliga hälsningar / Best regards
Torbjörn Olander
tosse@wlug.westbo.se

