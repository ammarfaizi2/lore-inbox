Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270455AbTG1T2o (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 15:28:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270462AbTG1T2o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 15:28:44 -0400
Received: from firewall.mdc-dayton.com ([12.161.103.180]:27102 "EHLO
	firewall.mdc-dayton.com") by vger.kernel.org with ESMTP
	id S270455AbTG1T2m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 15:28:42 -0400
From: "Kathy Frazier" <kfrazier@mdc-dayton.com>
To: "Mike Dresser" <mdresser_l@windsormachine.com>,
       <linux-kernel@vger.kernel.org>
Subject: RE: DMA not supported with Intel ICH4 I/O controller?
Date: Mon, 28 Jul 2003 15:40:09 -0500
Message-ID: <PMEMILJKPKGMMELCJCIGEEIKCDAA.kfrazier@mdc-dayton.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Importance: Normal
In-Reply-To: <Pine.LNX.4.56.0307281443300.8747@router.windsormachine.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>On Mon, 28 Jul 2003, Kathy Frazier wrote:

>> I just read on an Intel site
>> (http://64.143.3.64/downloads/drivers/845/perform/linux/udma.htmthat)
"ICH4
>> requires kernel 2.5.12 or later to enable any DMA mode".  Can you guys
>> support or refute this?  No wonder I'm having problems with my DMA device
on

On Mon, 28 Jul 2003, Mike Dresser wrote:
>I'm running 2.4.21 on this particular machine, and know it worked under
>2.4.20.

>  Bus  0, device  31, function  1:
>    IDE interface: Intel Corp. 82801DB ICH4 IDE (rev 1).
>      IRQ 10.
>      I/O at 0xf000 [0xf00f].
>      Non-prefetchable 32 bit memory at 0x20000000 [0x200003ff].

>mike:~# hdparm /dev/hda

>/dev/hda:
> multcount    = 16 (on)
> IO_support   =  3 (32-bit w/sync)
> unmaskirq    =  0 (off)
> using_dma    =  1 (on)



I checked the results of the hdparm on my system and it shows that hda has
DMA on . . .  Hmmm. I have seen a lot of rumblings concerning DMA and IDE
devices in the archives of this mailing list.  Is it possible that the ide
drivers now set up the hardware correctly for the DMA?  But somehow the O/S
does not support ICH4 for other DMA devices?

Kathy

