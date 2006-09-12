Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965153AbWILOne@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965153AbWILOne (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 10:43:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965161AbWILOne
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 10:43:34 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:9693 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S965153AbWILOnc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 10:43:32 -0400
Message-ID: <4506C789.4050404@pobox.com>
Date: Tue, 12 Sep 2006 10:43:21 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: Roland Dreier <rdreier@cisco.com>
CC: Zang Roy-r61911 <tie-fei.zang@freescale.com>,
       Andrew Morton <akpm@osdl.org>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 3/3] Add tsi108 On Chip Ethernet device driver support
References: <A0CDBA58F226D911B202000BDBAD46730A1B1410@zch01exm23.fsl.freescale.net>	<1157962200.10526.10.camel@localhost.localdomain>	<1158051351.14448.97.camel@localhost.localdomain> <ada3bax2lzw.fsf@cisco.com>
In-Reply-To: <ada3bax2lzw.fsf@cisco.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.2 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.2 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland Dreier wrote:
>  > +struct tsi108_prv_data {
>  > +	volatile u32 regs;	/* Base of normal regs */
>  > +	volatile u32 phyregs;	/* Base of register bank used for PHY access */
> 
> Why volatile?  This looks really wrong here.

Indeed.


>  > +	data->regs = (u32)ioremap(einfo->regs, 0x400);	/*FIX ME */
>  > +	data->phyregs = (u32)ioremap(einfo->phyregs, 0x400); 	/*FIX ME */
> 
> What needs to be fixed here?  And why are you casting the result of
> ioremap to u32?  Shouldn't you keep the normal return value?

Oh, that's very, very wrong.

	Jeff



