Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750812AbWEOXp0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750812AbWEOXp0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 19:45:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750821AbWEOXp0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 19:45:26 -0400
Received: from animx.eu.org ([216.98.75.249]:57768 "EHLO animx.eu.org")
	by vger.kernel.org with ESMTP id S1750812AbWEOXpY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 19:45:24 -0400
Date: Mon, 15 May 2006 19:50:47 -0400
From: Wakko Warner <wakko@animx.eu.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [RFT] major libata update
Message-ID: <20060515235047.GE4699@animx.eu.org>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <20060515170006.GA29555@havoc.gtf.org> <20060515230256.GB4699@animx.eu.org> <4469081D.7080608@garzik.org> <1147736451.26686.227.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1147736451.26686.227.camel@localhost.localdomain>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Llu, 2006-05-15 at 19:00 -0400, Jeff Garzik wrote:
> > Always helpful.  ata_piix should support Intel PATA controllers, modulo 
> > some bugs that Alan is fixing / has fixed.  If your PCI ID isn't listed, 
> > you will have to add it, and an associated info entry.  Again, take a 
> > look at Alan's libata PATA patches for guidance.
> 
> Without the patches I've got everything non ATAPI should work (ATAPI
> will I think 99% work) and anything that is ICH or later (UDMA66 or
> higher) should behave correctly.
> 
> PIIX/MPIIX won't work with it, and UDMA33 chips may work providing the
> scribbles to the wrong register happen to be harmless.

The test machine I have is this:
# lspci -v -s 7.1
0000:00:07.1 IDE interface: Intel Corp. 82371AB/EB/MB PIIX4 IDE (rev 01) (prog-if 80 [Master])
        Flags: bus master, medium devsel, latency 64
        I/O ports at 10a0 [size=16]

# lspci -v -s 7.1 -n
0000:00:07.1 0101: 8086:7111 (rev 01) (prog-if 80 [Master])
        Flags: bus master, medium devsel, latency 64
        I/O ports at 10a0 [size=16]

#

If this won't work, let me know.

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
 Got Gas???
