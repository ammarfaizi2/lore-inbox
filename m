Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264982AbTFCMio (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 08:38:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264983AbTFCMio
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 08:38:44 -0400
Received: from boden.synopsys.com ([204.176.20.19]:53938 "EHLO
	boden.synopsys.com") by vger.kernel.org with ESMTP id S264982AbTFCMil
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 08:38:41 -0400
Date: Tue, 3 Jun 2003 14:52:03 +0200
From: Alex Riesen <alexander.riesen@synopsys.COM>
To: Miles Lane <miles.lane@attbi.com>
Cc: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.70-bk7 -- drivers/net/irda/w83977af_ir.ko needs unknown	symbol setup_dma
Message-ID: <20030603125203.GD11885@Synopsys.COM>
Reply-To: alexander.riesen@synopsys.COM
Mail-Followup-To: Miles Lane <miles.lane@attbi.com>,
	"David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
References: <3EDBCC44.8000009@attbi.com> <1054612898.9352.3.camel@rth.ninka.net> <3EDC3B52.6030604@attbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EDC3B52.6030604@attbi.com>
Organization: Synopsys, Inc.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miles Lane, Tue, Jun 03, 2003 08:08:18 +0200:
> David S. Miller wrote:
> >On Mon, 2003-06-02 at 15:14, Miles Lane wrote:
> >
> >>if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.5.70-bk7; fi
> >>WARNING: /lib/modules/2.5.70-bk7/kernel/drivers/net/irda/w83977af_ir.ko 
> >>needs unknown symbol setup_dma
> >
> >
> >What platform is this?  It needs to set CONFIG_ISA correctly.
> 
> It's PPC.
> 
> CONFIG_PPC=y
> CONFIG_PPC32=y
> CONFIG_6xx=y
> 
> #
> # General setup
> #
> # CONFIG_HIGHMEM is not set
> # CONFIG_ISA is not set
> CONFIG_PCI=y
> 

i386 as well:

*** Warning: "setup_dma" [drivers/net/irda/w83977af_ir.ko] undefined!
*** Warning: "setup_dma" [drivers/net/irda/smsc-ircc2.ko] undefined!
*** Warning: "setup_dma" [drivers/net/irda/nsc-ircc.ko] undefined!
*** Warning: "setup_dma" [drivers/net/irda/ali-ircc.ko] undefined!

grep 'ISA\|PCI' .config
CONFIG_GENERIC_ISA_DMA=y
# Bus options (PCI, PCMCIA, EISA, MCA, ISA)
CONFIG_PCI=y
# CONFIG_ISA is not set


