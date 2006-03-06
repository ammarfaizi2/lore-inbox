Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751423AbWCFPM6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751423AbWCFPM6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 10:12:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751385AbWCFPM6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 10:12:58 -0500
Received: from cavan.codon.org.uk ([217.147.92.49]:15778 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S1751423AbWCFPM5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 10:12:57 -0500
Date: Mon, 6 Mar 2006 15:12:52 +0000
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: PATA failure with piix, works with libata
Message-ID: <20060306151251.GA11678@srcf.ucam.org>
References: <20060303183937.GA30840@srcf.ucam.org> <1141481507.10341.1.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1141481507.10341.1.camel@localhost>
User-Agent: Mutt/1.5.9i
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mjg59@codon.org.uk
X-SA-Exim-Scanned: No (on vavatch.codon.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 04, 2006 at 02:11:46PM +0000, Alan Cox wrote:

> Make sure the IRQ is setup properly. Legacy mode IRQs are level
> triggered which might fit this description.

It's a shared PCI interrupt, so yeah, it's level. As I mentioned to 
Jeff, explicitly writing back the DMA status register while 
acknowledging interrupts works (and is what ata_piix does in PATA mode)

-- 
Matthew Garrett | mjg59@srcf.ucam.org
