Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264593AbTFEKwf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 06:52:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264601AbTFEKwf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 06:52:35 -0400
Received: from rth.ninka.net ([216.101.162.244]:22657 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id S264593AbTFEKwe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 06:52:34 -0400
Subject: Re: PCI cache line messages 2.4/2.5
From: "David S. Miller" <davem@redhat.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jgarzik@pobox.com>,
       Margit Schubert-While <margitsw@t-online.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1054809554.15276.8.camel@dhcp22.swansea.linux.org.uk>
References: <5.1.0.14.2.20030602084908.00aed558@pop.t-online.de>
	 <3EDE7522.8040206@pobox.com>
	 <1054809554.15276.8.camel@dhcp22.swansea.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1054811157.19407.3.camel@rth.ninka.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 05 Jun 2003 04:05:58 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-06-05 at 03:39, Alan Cox wrote:
> > Your BIOS did not set the PCI cache line size correctly.  The kernel 
> > caught that mistake, and fixed it.
> 
> I can't find anywhere the BIOS is obliged to set it for you if a PnP OS
> is installed, ditto in the presence of any form of hotplug the test is
> wrong.
> 
> As far as I can see you can only warn if MWI is already set in the
> control word, and (I'd have to check the spec) possibly if the
> cache line size is non zero.

I don't know how PnP OS plays into it, but the last time I dug into this
deep dark area, the BIOS was expected to setup the cache line size for
all PCI devices in the system.

I do specifically remember situations, involving Acenic cards, where
one Acenic card would have things setup correctly but for whatever
reason the BIOS decided not to init the other Acenic cards.

-- 
David S. Miller <davem@redhat.com>
