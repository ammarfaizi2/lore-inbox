Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131645AbRCOE3A>; Wed, 14 Mar 2001 23:29:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131647AbRCOE2v>; Wed, 14 Mar 2001 23:28:51 -0500
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:14087
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S131645AbRCOE2g>; Wed, 14 Mar 2001 23:28:36 -0500
Date: Wed, 14 Mar 2001 20:27:46 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: CODEZ <DACODECZ_KERN@PHREAKER.NET>, Andrew Morton <andrewm@uow.edu.au>
cc: linux-kernel@vger.kernel.org, Mark Lord <mlord@pobox.com>
Subject: Re: IDE poweroff -> hangup
In-Reply-To: <00cb01c0acf8$83125ee0$61acd6d2@ninzazrouter>
Message-ID: <Pine.LNX.4.10.10103142010300.7091-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Mar 2001, CODEZ wrote:

> Ello folkz,
> Ummm the same problem I am facing whenevr I try to mount my cdrom. I am
> using kernel 2.4.2 ac-18 and yep ofcourse I am not removing my cdrom power
> supply......
> I tried hdparm -T and got
> ide_dmaproc: chipset supported ide_dma_timeout func only: 14
> I have ASUS 440BX/F mb with intel PIIX4 chipset......
> any suggestion

All of the 440*X Chipsets using a PIIX4/PIIX4AB/PIIX4EB are broken beyond
repair.  Several weeks ago, the old hat and I discussed the issue and
after sending him the same docs I have from Intel, we both laugh because
the errata clear states "NO FIX"

Now after going back to Intel with a puzzled look, I found out
why/where/how the breakage exists but the fix is not pretty nor does it
retain DMA transfer rates.

The hack job is fugly, it ruptures the ISR's the TIMERS and the PCI-DMA
space locally, but it is not a fatal barf, but a noisy messy one.

I will pop a nasty patch to get you through the almost death, but it is
nasty and not the preferred unknow solution.

Andre Hedrick
Linux ATA Development


