Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266825AbUIIUPI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266825AbUIIUPI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 16:15:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267565AbUIIUOb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 16:14:31 -0400
Received: from the-village.bc.nu ([81.2.110.252]:46507 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S264997AbUIIUNJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 16:13:09 -0400
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk4-R1
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Ingo Molnar <mingo@elte.hu>
Cc: Mark_H_Johnson@raytheon.com, Lee Revell <rlrevell@joe-job.com>,
       Free Ekanayaka <free@agnula.org>,
       Eric St-Laurent <ericstl34@sympatico.ca>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "K.R. Foley" <kr@cybsft.com>,
       Felipe Alfaro Solana <lkml@felipe-alfaro.com>,
       Daniel Schmitt <pnambic@unu.nu>,
       "P.O. Gaillard" <pierre-olivier.gaillard@fr.thalesgroup.com>,
       nando@ccrma.stanford.edu, luke@audioslack.com, free78@tin.it
In-Reply-To: <20040909194737.GA2778@elte.hu>
References: <OF1EEB0481.83AB73CE-ON86256F0A.006A8955-86256F0A.006A8968@raytheon.com>
	 <20040909194737.GA2778@elte.hu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1094756507.14657.64.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 09 Sep 2004 20:02:00 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2004-09-09 at 20:47, Ingo Molnar wrote:
> there are also tools that tweak chipsets directly - powertweak and the
> PCI latency settings. Maybe something tweaks the IDE controller just the
> right way. Also, try disabling specific controller support in the
> .config (or turn it on) - by chance the generic IDE code could program
> the IDE controller in a way that generates nicer DMA.

Do not tweak your IDE controller pci latency without making a backup if
its anything but the base motherboard chipset. Not unless you make
backups first and test it very hard.

Its a particularly popular area for errata.

You could also try lower DMA modes, I don't know if that will help or
not but UDMA133 is essentially "one entire PCI 32/33Mhz bus worth of
traffic so the effects are not too suprising. IDE control ports can give
you long stalls too especially if IORDY is in use.

Alan

