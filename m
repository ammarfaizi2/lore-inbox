Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263143AbSLZR1Q>; Thu, 26 Dec 2002 12:27:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263204AbSLZR1P>; Thu, 26 Dec 2002 12:27:15 -0500
Received: from louise.pinerecords.com ([213.168.176.16]:57768 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S263143AbSLZR1P>; Thu, 26 Dec 2002 12:27:15 -0500
Date: Thu, 26 Dec 2002 18:35:28 +0100
From: Tomas Szepe <szepe@pinerecords.com>
To: Frank van Maarseveen <F.vanMaarseveen@inter.NL.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Alot of DMA errors in 2.4.18, 2.4.20 and 2.5.52
Message-ID: <20021226173528.GF7348@louise.pinerecords.com>
References: <1040815160.533.6.camel@devcon-x> <20021225115820.GB7348@louise.pinerecords.com> <20021226123710.GA2442@iapetus.localdomain> <20021226132228.GE7348@louise.pinerecords.com> <20021226164229.GA26413@iapetus.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021226164229.GA26413@iapetus.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Thu, Dec 26, 2002 at 02:22:28PM +0100, Tomas Szepe wrote:
> > > 
> > > hdparm -X69 /dev/hda will put it into UDMA5/ata100 mode as well
> > > (69 == 64 + UDMA mode). No need to specify it at boot time.
> > 
> > Not true.  You definitely need to use the ideX boot param AND
> > run hdparm -X?? /dev/hd? to make use of UDMA3+ on newer PDC
> > controllers (unless you apply the patch posted on Dec 24 by
> > Nikolai Zhubr).
> 
> Driver says otherwise on RH8.0 + 2.4.20:
> iapetus /proc/ide# cat pdc202xx 
> 
> PROMISE Ultra series driver Ver 1.20.0.7 2002-05-23 Adapter: Ultra100 TX2
> --------------- Primary Channel ---------------- Secondary Channel -------------
>                 enabled                          enabled 
> 66 Clocking     enabled                          enabled 
> Mode            MASTER                           MASTER
> --------------- drive0 --------- drive1 -------- drive0 ---------- drive1 ------
> DMA enabled:    yes              no              no                no 
> UDMA Mode:      5                0               0                 0
> PIO Mode:       4                0               0                 0

Fair enough.  Can you give me your PCI ids, Promise BIOS version
and "hdparm -Iv /dev/hda"?

-- 
Tomas Szepe <szepe@pinerecords.com>
