Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265130AbUFGXYg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265130AbUFGXYg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 19:24:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265131AbUFGXYg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 19:24:36 -0400
Received: from mx1.redhat.com ([66.187.233.31]:28313 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265130AbUFGXY1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 19:24:27 -0400
Date: Mon, 7 Jun 2004 16:21:10 -0700
From: "David S. Miller" <davem@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: hch@infradead.org, hadi@zynx.com, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.7-rc3
Message-Id: <20040607162110.29cb3cdf.davem@redhat.com>
In-Reply-To: <Pine.LNX.4.58.0406071407190.1637@ppc970.osdl.org>
References: <Pine.LNX.4.58.0406071227400.2550@ppc970.osdl.org>
	<20040607204142.GA26986@infradead.org>
	<Pine.LNX.4.58.0406071407190.1637@ppc970.osdl.org>
X-Mailer: Sylpheed version 0.9.11 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Jun 2004 14:09:04 -0700 (PDT)
Linus Torvalds <torvalds@osdl.org> wrote:

> On Mon, 7 Jun 2004, Christoph Hellwig wrote:
> > 
> > This one here:
> > 
> > diff -Nru a/include/linux/netfilter_arp.h b/include/linux/netfilter_arp.h
> > --- a/include/linux/netfilter_arp.h     2004-06-07 21:58:09 +02:00
> > +++ b/include/linux/netfilter_arp.h     2004-06-07 21:58:09 +02:00
> > @@ -17,4 +17,5 @@
> >  #define NF_ARP_FORWARD 2
> >  #define NF_ARP_NUMHOOKS        3
> > 
> > +static DECLARE_MUTEX(arpt_mutex);
> >  #endif /* __LINUX_ARP_NETFILTER_H */
> > 
> > looks perfectly fucked up.
> 
> Agreed. David? Jamal?

It happens to be OK since arp_tables.c is the only includer of that header
but I agree it's gross and I'll put it back into arp_tables.c
