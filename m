Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262927AbUFJUJb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262927AbUFJUJb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jun 2004 16:09:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262954AbUFJUJb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jun 2004 16:09:31 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:41165 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S262927AbUFJUJ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jun 2004 16:09:28 -0400
Date: Thu, 10 Jun 2004 22:05:04 +0200
From: Pavel Machek <pavel@suse.cz>
To: Pekka Pietikainen <pp@ee.oulu.fi>
Cc: "David S. Miller" <davem@redhat.com>, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: Dealing with buggy hardware (was: b44 and 4g4g)
Message-ID: <20040610200504.GG4507@openzaurus.ucw.cz>
References: <20040531202104.GA8301@ee.oulu.fi> <20040605200643.GA2210@ee.oulu.fi> <20040605131923.232f8950.davem@redhat.com> <20040609122905.GA12715@ee.oulu.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040609122905.GA12715@ee.oulu.fi>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > +	if(virt_to_bus(skb->data) + skb->len > B44_PCI_DMA_MAX) {
> > 
> > You can't use this non-portable interface, you have to:
> > 
> > 1) pci_map the data
> > 2) test the dma_addr_t returned
> Ok, fixed. Certainly not ideal, but should fix things for those with
> problems (ie. running the 4G4G patch) and work as before for everyone else.
>

This should hit machines with 2GB ram too, right?
Is it possible to find if it hits me? I get hard lockups on
2GB machine with b44, but they take ~5min.. few hours to
reproduce...
 
It seems to me like this should hit very quickly.
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

