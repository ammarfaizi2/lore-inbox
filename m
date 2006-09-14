Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751043AbWINCvQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751043AbWINCvQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 22:51:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751021AbWINCvQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 22:51:16 -0400
Received: from de01egw01.freescale.net ([192.88.165.102]:57060 "EHLO
	de01egw01.freescale.net") by vger.kernel.org with ESMTP
	id S1750966AbWINCvP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 22:51:15 -0400
Subject: Re: [patch 3/3] Add tsi108 On Chip Ethernet device driver support
From: Zang Roy-r61911 <tie-fei.zang@freescale.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Roland Dreier <rdreier@cisco.com>, Andrew Morton <akpm@osdl.org>,
       netdev@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <4506C789.4050404@pobox.com>
References: <A0CDBA58F226D911B202000BDBAD46730A1B1410@zch01exm23.fsl.freescale.net>
	 <1157962200.10526.10.camel@localhost.localdomain>
	 <1158051351.14448.97.camel@localhost.localdomain>
	 <ada3bax2lzw.fsf@cisco.com>  <4506C789.4050404@pobox.com>
Content-Type: text/plain
Organization: 
Message-Id: <1158202261.22615.0.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 14 Sep 2006 10:51:01 +0800
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 14 Sep 2006 02:51:11.0199 (UTC) FILETIME=[A2C5D6F0:01C6D7A8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-09-12 at 22:43, Jeff Garzik wrote:
> Roland Dreier wrote:
> >  > +struct tsi108_prv_data {
> >  > +  volatile u32 regs;      /* Base of normal regs */
> >  > +  volatile u32 phyregs;   /* Base of register bank used for PHY
> access */
> > 
> > Why volatile?  This looks really wrong here.
> 
> Indeed.
I will remove it.
> 
> 
> >  > +  data->regs = (u32)ioremap(einfo->regs, 0x400);  /*FIX ME */
> >  > +  data->phyregs = (u32)ioremap(einfo->phyregs, 0x400);    /*FIX
> ME */
> > 
> > What needs to be fixed here?  And why are you casting the result of
> > ioremap to u32?  Shouldn't you keep the normal return value?
> 
> Oh, that's very, very wrong.
I will find method to avoid this :-).
Roy

