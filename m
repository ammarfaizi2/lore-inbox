Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161070AbWFVLUA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161070AbWFVLUA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 07:20:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161069AbWFVLUA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 07:20:00 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:16822 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1161067AbWFVLT7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 07:19:59 -0400
Subject: Re: Memory corruption in 8390.c ?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: David Miller <davem@davemloft.net>
Cc: herbert@gondor.apana.org.au, snakebyte@gmx.de,
       linux-kernel@vger.kernel.org, jgarzik@pobox.com, netdev@vger.kernel.org
In-Reply-To: <20060622.013440.97293561.davem@davemloft.net>
References: <20060622023029.GA6156@gondor.apana.org.au>
	 <20060622.012609.25474139.davem@davemloft.net>
	 <20060622083037.GB26083@gondor.apana.org.au>
	 <20060622.013440.97293561.davem@davemloft.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 22 Jun 2006 12:34:23 +0100
Message-Id: <1150976063.15275.146.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Iau, 2006-06-22 am 01:34 -0700, ysgrifennodd David Miller:
> From: Herbert Xu <herbert@gondor.apana.org.au>
> Date: Thu, 22 Jun 2006 18:30:37 +1000
> 
> > On Thu, Jun 22, 2006 at 01:26:09AM -0700, David Miller wrote:
> > >
> > > Want me to let this cook in 2.6.18 for a while before sending
> > > it off to -stable?
> > 
> > You know I'm never one to push anything quickly so absolutely yes :)
> 
> Ok, applied to net-2.6.18 for now :)

The 8390 change (corrected version) also makes 8390.c faster so should
be applied anyway, and the orinoco one fixes some code that isn't even
needed and someone forgot to remove long ago. Otherwise the skb_padto
behaviour change with the newer skb style makes a lot more sense I
agree.

