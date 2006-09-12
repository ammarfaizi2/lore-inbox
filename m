Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965252AbWILOdL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965252AbWILOdL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 10:33:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965255AbWILOdL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 10:33:11 -0400
Received: from sj-iport-6.cisco.com ([171.71.176.117]:34171 "EHLO
	sj-iport-6.cisco.com") by vger.kernel.org with ESMTP
	id S965250AbWILOdJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 10:33:09 -0400
To: Zang Roy-r61911 <tie-fei.zang@freescale.com>
Cc: Andrew Morton <akpm@osdl.org>, jgarzik <jgarzik@pobox.com>,
       netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [patch 3/3] Add tsi108 On Chip Ethernet device driver support
X-Message-Flag: Warning: May contain useful information
References: <A0CDBA58F226D911B202000BDBAD46730A1B1410@zch01exm23.fsl.freescale.net>
	<1157962200.10526.10.camel@localhost.localdomain>
	<1158051351.14448.97.camel@localhost.localdomain>
From: Roland Dreier <rdreier@cisco.com>
Date: Tue, 12 Sep 2006 07:33:07 -0700
In-Reply-To: <1158051351.14448.97.camel@localhost.localdomain> (Zang Roy-r's message of "12 Sep 2006 16:55:52 +0800")
Message-ID: <ada3bax2lzw.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 12 Sep 2006 14:33:08.0012 (UTC) FILETIME=[5D85FEC0:01C6D678]
Authentication-Results: sj-dkim-4.cisco.com; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > +struct tsi108_prv_data {
 > +	volatile u32 regs;	/* Base of normal regs */
 > +	volatile u32 phyregs;	/* Base of register bank used for PHY access */

Why volatile?  This looks really wrong here.

 > +	data->regs = (u32)ioremap(einfo->regs, 0x400);	/*FIX ME */
 > +	data->phyregs = (u32)ioremap(einfo->phyregs, 0x400); 	/*FIX ME */

What needs to be fixed here?  And why are you casting the result of
ioremap to u32?  Shouldn't you keep the normal return value?

 - R.
