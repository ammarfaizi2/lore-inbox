Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262547AbUCCTP2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 14:15:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262549AbUCCTP2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 14:15:28 -0500
Received: from smtp-out4.xs4all.nl ([194.109.24.5]:16901 "EHLO
	smtp-out4.xs4all.nl") by vger.kernel.org with ESMTP id S262547AbUCCTPX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 14:15:23 -0500
Date: Wed, 3 Mar 2004 20:15:14 +0100
From: Jurriaan <thunder7@xs4all.nl>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Matthew Wilcox <willy@debian.org>
Subject: Re: 2.6.3-mm4 / 2.5 Gb memory / sym53c8xx_2 won't boot
Message-ID: <20040303191514.GA6998@middle.of.nowhere>
Reply-To: Jurriaan <thunder7@xs4all.nl>
References: <20040302185518.GA2886@middle.of.nowhere> <20040302144757.60a0630c.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040302144757.60a0630c.akpm@osdl.org>
X-Message-Flag: Still using Outlook? Please Upgrade to real software!
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Morton <akpm@osdl.org>
Date: Tue, Mar 02, 2004 at 02:47:57PM -0800
> Jurriaan <thunder7@xs4all.nl> wrote:
> >
> > After upgrading my memory from 1 Gb to 2.5 Gb my 2.6.3-mm4 kernel
> > wouldn't boot anymore.
> > 
> > It hang when detecting the scsi-chip.
> > I had in my .config:
> > 
> > CONFIG_SCSI_SYM53C8XX_DMA_ADDRESSING_MODE=1
> > 
> > the default value.
> > 
> > The scsi bus kept resetting before detecting any devices. Interestingly,
> > 2.6.3-mm1 did boot with that .config setting. Once I recompiled
> > 2.6.3-mm4 with 
> > 
> > CONFIG_SCSI_SYM53C8XX_DMA_ADDRESSING_MODE=0
> > 
> > it booted (and worked) fine.
> > 
> > So, something regressed in 2.6.3-mm4 versus 2.6.3-mm1, so the default
> > setting didn't work correctly anymore.
> 
> I don't know what caused this - there are a few patches in there which
> touch the DMA and BIO highmem areas.  Plus always the latest scsi
> development tree.
> 
> > If there is anything I can test, please let me know.
> 
> Could you test Linus's current tree?  The first link at
> http://www.kernel.org/pub/linux/kernel/v2.5/testing/cset/.
> 
> If this bug hasn't hit Linus's tree yet, it will soon do so...
> 
It probably will, since it's not in Linus's tree as of

cset-20040303_0509.txt

ie 2.6.4-rc1-mm1 + cset-20040303_0509 does boot with
CONFIG_SCSI_SYM53C8XX_DMA_ADDRESSING_MODE=1, and 2.6.3-mm4 doesn't.

Kind regards,
Jurriaan
-- 
HORROR FILM WISDOM:
9. If your car runs out of gas at night, do not go to the nearby
deserted-looking house to phone for help.
Debian (Unstable) GNU/Linux 2.6.3-mm4 3940 bogomips 0.00 0.00
