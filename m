Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262047AbTDXJUR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 05:20:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262426AbTDXJUR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 05:20:17 -0400
Received: from [63.246.199.14] ([63.246.199.14]:8839 "EHLO ns.briggsmedia.com")
	by vger.kernel.org with ESMTP id S262047AbTDXJUQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 05:20:16 -0400
Content-Type: text/plain; charset=US-ASCII
From: joe briggs <jbriggs@briggsmedia.com>
Organization: BMS
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [Motion] Re: IDE corruption during heavy bt878-induced interr upt load [LKM]
Date: Thu, 24 Apr 2003 06:31:49 -0400
User-Agent: KMail/1.4.3
Cc: David Brodbeck <DavidB@mail.interclean.com>,
       "'motion@lists.frogtown.com'" <motion@pdx.frogtown.com>,
       andras@t-online.de,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       motion@frogtown.com
References: <C823AC1DB499D511BB7C00B0D0F0574C583D23@serverdell2200.interclean.com> <200304231813.46892.jbriggs@briggsmedia.com> <1051135875.2062.101.camel@dhcp22.swansea.linux.org.uk>
In-Reply-To: <1051135875.2062.101.camel@dhcp22.swansea.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200304240631.49222.jbriggs@briggsmedia.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

That's what I thought, which is why I suspected that the underlying problem 
might be related to the scope and completeness of the hardware arbitration.  
Specifically, if a PCI board is DMA'ing a block of data to main memory, how 
is the operation of the direct-connect IDE device impacted?  When most PCI 
devices transfer data to main memory, don't they arbitrate the bus, become 
master, and blast it accross in chunks?  Doesn't onboard IDE (legacy?) use 
the DMA controller (8237 derivate I gues) to transfer?

On Wednesday 23 April 2003 06:11 pm, Alan Cox wrote:
> On Mer, 2003-04-23 at 23:13, joe briggs wrote:
> > Is this true??? Does onboard IDE controllers appear and work the same way
> > as IDE or PCI controllers with respect to IRQ, DMA, and memory access?
>
> They appear to. Most of them nowdays are wired directly to the
> north/southbridge link for performance.
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Joe Briggs
Briggs Media Systems
105 Burnsen Ave.
Manchester NH 01304 USA
TEL/FAX 603-232-3115 MOBILE 603-493-2386
www.briggsmedia.com
