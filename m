Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263866AbTFEK2X (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 06:28:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264554AbTFEK2W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 06:28:22 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:49798
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S263866AbTFEK2V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 06:28:21 -0400
Subject: Re: PCI cache line messages 2.4/2.5
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Margit Schubert-While <margitsw@t-online.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3EDE7522.8040206@pobox.com>
References: <5.1.0.14.2.20030602084908.00aed558@pop.t-online.de>
	 <3EDE7522.8040206@pobox.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1054809554.15276.8.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 05 Jun 2003 11:39:15 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2003-06-04 at 23:39, Jeff Garzik wrote:
> > PCI: 00:1d.7 PCI cache line size set incorrectly (0 bytes) by BIOS/FW.
> > PCI: 00:1d.7 PCI cache line size corrected to 128.
> > 
> > This is the onboard USB EHCI (Intel D845 PESV).
> > lspci below.
> > 
> > What's going on ?
> 
> 
> Pretty much exactly what the message says :)
> 
> Your BIOS did not set the PCI cache line size correctly.  The kernel 
> caught that mistake, and fixed it.

I can't find anywhere the BIOS is obliged to set it for you if a PnP OS
is installed, ditto in the presence of any form of hotplug the test is
wrong.

As far as I can see you can only warn if MWI is already set in the
control word, and (I'd have to check the spec) possibly if the
cache line size is non zero.

(simple hotplug thought experiment to prove the point

	Soft boot a thinkpad 600
	As the bios transfers to grub insert in docking station
	
explain how the bios sets the cache line size..)

