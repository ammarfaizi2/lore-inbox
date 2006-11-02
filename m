Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752627AbWKBBGN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752627AbWKBBGN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 20:06:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752626AbWKBBGM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 20:06:12 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:50844 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1752622AbWKBBGL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 20:06:11 -0500
Message-ID: <4549447D.5010500@garzik.org>
Date: Wed, 01 Nov 2006 20:06:05 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20061008)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, John Stoffel <john@stoffel.org>,
       Linus Torvalds <torvalds@osdl.org>, linux-ide@vger.kernel.org,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [git patches] libata fixes
References: <20061101021301.GA21568@havoc.gtf.org>	<17736.43507.649685.484648@smtp.charter.net>	<1162391435.11965.128.camel@localhost.localdomain> <20061101160207.6b5e4c29.akpm@osdl.org>
In-Reply-To: <20061101160207.6b5e4c29.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Wed, 01 Nov 2006 14:30:35 +0000
> Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> 
>> Ar Mer, 2006-11-01 am 09:06 -0500, ysgrifennodd John Stoffel:
>>> Jeff> +	{ 0x8086, 0x7110, PCI_ANY_ID, PCI_ANY_ID, 0, 0, piix_pata_33 },
>>> Jeff>  	{ 0x8086, 0x7111, PCI_ANY_ID, PCI_ANY_ID, 0, 0, piix_pata_33 },
>>>
>>> Umm, according to lspci -nn on my 440GX box, isn't the 0x8086/0x7110
>>> an ISA bridge, not a PIIX? controller?  
>> Correct - the 7110 doesn't belong on that list.
> 
> So should it be moved elsewhere, or simply removed?

Well, according to Jens' own comment message, the PCI ID he needed was 
already in the driver (my eyes didn't catch this).

It looks like it should be reverted, based on this thread and also the 
patch's commit message itself.

	Jeff



