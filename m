Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266275AbUA2Aqs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jan 2004 19:46:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266276AbUA2Aqs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jan 2004 19:46:48 -0500
Received: from intra.cyclades.com ([64.186.161.6]:59543 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S266275AbUA2Aqq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jan 2004 19:46:46 -0500
Date: Wed, 28 Jan 2004 22:02:34 -0200 (BRST)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: Greg KH <greg@kroah.com>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PC300 update
In-Reply-To: <20040128214356.GA8999@kroah.com>
Message-ID: <Pine.LNX.4.58L.0401282157530.4345@logos.cnet>
References: <Pine.LNX.4.58L.0401281741120.2088@logos.cnet>
 <20040128214356.GA8999@kroah.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cyclades-MailScanner-Information: Please contact the ISP for more information
X-Cyclades-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Greg!

On Wed, 28 Jan 2004, Greg KH wrote:

> On Wed, Jan 28, 2004 at 05:42:11PM -0200, Marcelo Tosatti wrote:
> >
> > - Mark pci_device_id list with __devinitdata
>
> Noooo!!!   I think we've finally audited all uses of this.  Do not do
> this please, it is wrong for 2.6.

[root@yage wan]# pwd
/root/linux-2.6.1/drivers/net/wan
[root@yage wan]# grep __devexit_p *
dscc4.c:  .remove = __devexit_p(dscc4_remove_one),
farsync.c:  .remove = __devexit_p(fst_remove_one),

So this ones are wrong too I assume?

Mind explaining me what is the deal with __devexit_p() in 2.6?

> > - Add #ifdef DEBUG around debug printk()
>
> What's wrong with dev_dbg()?  It gives you a much better idea of which
> device is spitting out the messages.

Indeed, dev_dbg() is fine. I will replace all #ifdef DEBUG entries in the
driver with dev_dgb(...). Thanks for the hint.

Linus, hold the patch :)


