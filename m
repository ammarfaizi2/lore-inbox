Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261542AbUCDIKv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 03:10:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261557AbUCDIKv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 03:10:51 -0500
Received: from smtp-out6.xs4all.nl ([194.109.24.7]:59141 "EHLO
	smtp-out6.xs4all.nl") by vger.kernel.org with ESMTP id S261542AbUCDIKr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 03:10:47 -0500
Date: Thu, 4 Mar 2004 09:10:32 +0100
From: Jurriaan <thunder7@xs4all.nl>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, willy@debian.org
Subject: Re: 2.6.3-mm4 / 2.5 Gb memory / sym53c8xx_2 won't boot
Message-ID: <20040304081032.GA3539@middle.of.nowhere>
Reply-To: Jurriaan <thunder7@xs4all.nl>
References: <20040302185518.GA2886@middle.of.nowhere> <20040302144757.60a0630c.akpm@osdl.org> <20040303191514.GA6998@middle.of.nowhere> <20040303153830.7ae00ba3.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040303153830.7ae00ba3.akpm@osdl.org>
X-Message-Flag: Still using Outlook? Please Upgrade to real software!
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Morton <akpm@osdl.org>
Date: Wed, Mar 03, 2004 at 03:38:30PM -0800
> Jurriaan <thunder7@xs4all.nl> wrote:
> >
> > > Could you test Linus's current tree?  The first link at
> > > http://www.kernel.org/pub/linux/kernel/v2.5/testing/cset/.
> > > 
> > > If this bug hasn't hit Linus's tree yet, it will soon do so...
> > > 
> > It probably will, since it's not in Linus's tree as of
> > 
> > cset-20040303_0509.txt
> > 
> > ie 2.6.4-rc1-mm1 + cset-20040303_0509 does boot with
> 
>      You meant 2.6.4-rc1, I assume?
> 
> > CONFIG_SCSI_SYM53C8XX_DMA_ADDRESSING_MODE=1, and 2.6.3-mm4 doesn't.
> 
> I continue to be stumped.  Could you please test a Linus tree, plus
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.4-rc1/2.6.4-rc1-mm2/broken-out/bk-scsi.patch
> 
> and
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.4-rc1/2.6.4-rc1-mm2/broken-out/dma_sync_for_device-cpu.patch
> 
I'm now stumped also. I tested

2.6.4-rc2 CONFIG.*DMA.*MODE=1: ok
2.6.4-rc2+bk-scsi CONFIG.*DMA.*MODE=1: ok
2.6.4-rc2+bk-scsi+dma_sync CONFIG.*DMA.*MODE=1: ok

then I recompiled a fresh 2.6.3-mm4 kernel from source with
CONFIG.*DMA.*MODE=1, and it booted also.

So it appears to (have) be(en) a Heisenbug. It was there, when I
recompiled, it was gone.

Oh well,
Jurriaan
-- 
You aren't going to do anything about it then?
Of course I am.
What?
I'm going to ignore it.
        David Eddings - The Sapphire Rose
Debian (Unstable) GNU/Linux 2.6.3-mm4 3940 bogomips 1.91 0.84
