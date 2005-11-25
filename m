Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161119AbVKYPf6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161119AbVKYPf6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Nov 2005 10:35:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161115AbVKYPf6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Nov 2005 10:35:58 -0500
Received: from webbox4.loswebos.de ([213.187.93.205]:47820 "EHLO
	webbox4.loswebos.de") by vger.kernel.org with ESMTP
	id S1161109AbVKYPf5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Nov 2005 10:35:57 -0500
Date: Fri, 25 Nov 2005 16:36:01 +0100
From: Marc Koschewski <marc@osknowledge.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Assorted bugs in the PIIX drivers
Message-ID: <20051125153601.GA6814@stiffy.osknowledge.org>
References: <1132929808.3298.18.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1132929808.3298.18.camel@localhost.localdomain>
X-PGP-Fingerprint: D514 7DC1 B5F5 8989 083E  38C9 5ECF E5BD 3430 ABF5
X-PGP-Key: http://www.osknowledge.org/~marc/pubkey.asc
X-Operating-System: Linux stiffy 2.6.15-rc2-marc
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Alan Cox <alan@lxorguk.ukuu.org.uk> [2005-11-25 14:43:28 +0000]:

> I finally got all the documents rounded up to try and redo Jgarzik's
> PIIX driver a bit more completely (I'm short MPIIX if anyone has it ?)
> 
> I then started reading the docs and the code and noticing a couple of
> problems
> 
> 1.	We set IE1 on PIO0-2 which the docs say is for PIO3+
> 
> 2.	The ata_piix one (but not the ide/pci one) have shifts wrong so that
> the secondary slave timings are half loaded into the primary slave
> 
> 
> I'm also not clear if the "no MWDMA0" list has been updated correctly
> for the newer chipsets.
> 
> I've yet to review the DMA programming, just the PIO so far.

Alan,

	could it be possible to again drop the ide=nodma kernel parameter in my
configs that use reiserfs? reiserfs just bails out when I mount devices on ide
busses that miss that parameter. I somtimes had to --rebuild-tree after a boot
with DMA enabled.

Regards,
	Marc
