Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262628AbVCJOxb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262628AbVCJOxb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 09:53:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262629AbVCJOxb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 09:53:31 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:47247 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S262628AbVCJOx2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 09:53:28 -0500
Subject: Re: ITE8212
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: CaT <cat@zip.com.au>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050310122824.GX1811@zip.com.au>
References: <20050310122824.GX1811@zip.com.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1110466294.28860.287.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 10 Mar 2005 14:51:35 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2005-03-10 at 12:28, CaT wrote:
> hda: max request size: 128KiB
> hda: 390721968 sectors (200049 MB) w/8192KiB Cache, CHS=24321/255/63, BUG
> hda: cache flushes not supported
>  hda:hda: recal_intr: status=0x51 { DriveReady SeekComplete Error }
> hda: recal_intr: error=0x04 { DriveStatusError }

Ooh great stuff, definitely want to know more. A couple of folks report
that and mine won't do it.

> /dev/hdc:
> 
>  Model=IC35L060AVV207-0, FwRev=V22OA63A, SerialNo=VNVB01G2RAK8XH
>  Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
>  RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=52
>  BuffType=DualPortCache, BuffSize=1821kB, MaxMultSect=16, MultSect=off
>  CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=120103200
>  IORDY=on/off
>  PIO modes:  pio0 pio1 pio2 
>  DMA modes:  mdma0 mdma1 mdma2 

Ok its correctly trimmed the modes, but not it seems the current mode.
I'll send you a tweak to avoid multisect being played with.


