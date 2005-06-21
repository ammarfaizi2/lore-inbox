Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262170AbVFUSWR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262170AbVFUSWR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 14:22:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261824AbVFUSWR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 14:22:17 -0400
Received: from osten.wh.uni-dortmund.de ([129.217.129.130]:6291 "EHLO
	osten.wh.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S262209AbVFUSWD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 14:22:03 -0400
Message-ID: <42B85AC9.4060708@web.de>
Date: Tue, 21 Jun 2005 20:22:01 +0200
From: Alexander Fieroch <fieroch@web.de>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050402)
X-Accept-Language: de-de, en-us, en
MIME-Version: 1.0
Newsgroups: gmane.linux.kernel
To: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>
Cc: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       bzolnier@gmail.com, axboe@suse.de,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: [2.6.12rc4] PROBLEM: "drive appears confused" and "irq 18:  
   nobody cared!"
References: <19D0D50E9B1D0A40A9F0323DBFA04ACCE04C08@USRV-EXCH4.na.uis.unisys.com>
In-Reply-To: <19D0D50E9B1D0A40A9F0323DBFA04ACCE04C08@USRV-EXCH4.na.uis.unisys.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Protasevich, Natalie wrote:
> I would try forcing legacy mode some way, say by tweaking the
> line in do_ide_setup_pci_device():
>    if ((dev->class >> 8) == PCI_CLASS_STORAGE_IDE && (dev->class & 5) !=
> 5) {
> 
> To something like
> 
>    if ((dev->class >> 8) == PCI_CLASS_STORAGE_IDE) {

I did this with kernel 2.6.12-git2. There are more much error messages
like...
"hda: lost interrupt"
...where linux hangs with a timeout. Finally linux falls in a loop of
errors and is repeating the following tree lines continually:

hda: lost interrupt
hda: dma_timer_expiry: dmastatus == 0x64
hda: DMA interrupt recovery


> Another thought is to dump PCI configuration space for ICH6 IDE, and
> verify the values, especially INT_LN, INTR_PIN, and PCICMD which has
> such info as whether IDE interrupt is enabled on the chip (bit 10), see
> Intel's ICH6 spec, chapter 11 (
> ftp://download.intel.com/design/chipsets/datashts/30147302.pdf ).

Ok, is there anything that I can do?

> I posted reply to you last email but surprisingly didn't see it going
> trough to the mailing list. Maybe, our mailer blocked it for some
> reason.

Curious. I also have recognized that some replys did not go through the
mailing list, but I've cc'd all of you. Perhaps someone should check the
filter?

Regards,
Alexander


