Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269470AbUJSPn3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269470AbUJSPn3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 11:43:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269471AbUJSPn3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 11:43:29 -0400
Received: from DELFT.AURA.CS.CMU.EDU ([128.2.206.88]:55525 "EHLO
	delft.aura.cs.cmu.edu") by vger.kernel.org with ESMTP
	id S269470AbUJSPn1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 11:43:27 -0400
Date: Tue, 19 Oct 2004 11:43:15 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Ronald Moesbergen <r.moesbergen@hccnet.nl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM: 2.6.9-rc3, i8042.c: Can't read CTR while initializing i8042
Message-ID: <20041019154315.GA10692@delft.aura.cs.cmu.edu>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Ronald Moesbergen <r.moesbergen@hccnet.nl>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <4161A2C1.8000901@hccnet.nl> <1097079186.29255.53.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1097079186.29255.53.camel@localhost.localdomain>
User-Agent: Mutt/1.5.6+20040907i
From: Jan Harkes <jaharkes@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 06, 2004 at 05:13:07PM +0100, Alan Cox wrote:
> On Llu, 2004-10-04 at 20:21, Ronald Moesbergen wrote:
> > Since 2.6.9-rc3 (I tested rc3-bk3 also) on 3 out of 10 boots my PS/2 
> > keyboard is dead and 'i8042.c: Can't read CTR while initializing i8042' 
> > shows up in my logfile. Google found this:
> > 
> > http://marc.theaimsgroup.com/?l=linux-kernel&m=109463125415432&w=2
> > 
> > which suggests to add i8042.noacpi=1 to my boot parameters, but 
> > unfortunately that doesn't help, the kernel doesn't even recognize this 
> > option. Reverting back to 2.6.9-rc2 fixes it. The machine is a P4 3Ghz 
> > HT, E7205 chipset, ASUS P4P8X board.
> 
> For E7xxx systems you need to disable USB legacy support in the BIOS
> because SMM only works on the boot processor. There is a patch to
> automate it in 2.6.8.1-ac you can also borrow

Same problem on a Dell Dimension 8250. However I couldn't find an option
on the BIOS to disable usb legacy support. 

The only thing that worked was booting with 'acpi=off'.

Jan

