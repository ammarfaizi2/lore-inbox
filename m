Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136567AbREIPvh>; Wed, 9 May 2001 11:51:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136571AbREIPv2>; Wed, 9 May 2001 11:51:28 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:521 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S136567AbREIPvN>; Wed, 9 May 2001 11:51:13 -0400
Message-ID: <3AF967B5.E9FD1223@redhat.com>
Date: Wed, 09 May 2001 11:52:21 -0400
From: Doug Ledford <dledford@redhat.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.17-11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Benedict Bridgwater <bennyb@ntplx.net>,
        Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.4-ac5 aic7xxx causes hang on my machine
In-Reply-To: <E14xWDP-0002dE-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

> The tables are then described by the $PIRQ table in the BIOS. We use that to
> load the mapping registers in the PCI bridge (and also to read them). If the
> tables are wrong then we will mismap interrupt INTA-D lines to IRQ lines.
> 
> IRQ11 appearing on IRQ10 sounds exactly like the INTA-D line setting for IRQ
> 11 is wrong and we connected it to IRQ 10

Which brings me back to my question in my previous email.  Why are we
remapping working configs again?  I'm at a loss here.  This isn't a hot plug
capably motherboard, we don't have to worry about new PCI cards getting thrown
in, and yet we are remapping the IRQs.  Why?

-- 

 Doug Ledford <dledford@redhat.com>  http://people.redhat.com/dledford
      Please check my web site for aic7xxx updates/answers before
                      e-mailing me about problems
