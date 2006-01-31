Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030238AbWAaAQW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030238AbWAaAQW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 19:16:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965049AbWAaAQW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 19:16:22 -0500
Received: from smtp.osdl.org ([65.172.181.4]:8380 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965048AbWAaAQV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 19:16:21 -0500
Date: Mon, 30 Jan 2006 16:15:51 -0800
From: Stephen Hemminger <shemminger@osdl.org>
To: Pekka Pietikainen <pp@ee.oulu.fi>
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
       Knut Petersen <Knut_Petersen@t-online.de>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>
Subject: Re: skge bridge & hw csum failure (Was: Re: [BUG] sky2 broken for
 Yukon PCI-E Gigabit Ethernet Controller 11ab:4362 (rev 19))
Message-ID: <20060130161551.623a3ad0@dxpl.pdx.osdl.net>
In-Reply-To: <20060130231658.GA6952@ee.oulu.fi>
References: <20060130231658.GA6952@ee.oulu.fi>
X-Mailer: Sylpheed-Claws 1.9.100 (GTK+ 2.6.10; x86_64-redhat-linux-gnu)
X-Face: &@E+xe?c%:&e4D{>f1O<&U>2qwRREG5!}7R4;D<"NO^UI2mJ[eEOA2*3>(`Th.yP,VDPo9$
 /`~cw![cmj~~jWe?AHY7D1S+\}5brN0k*NE?pPh_'_d>6;XGG[\KDRViCfumZT3@[
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Jan 2006 01:16:59 +0200
Pekka Pietikainen <pp@ee.oulu.fi> wrote:

> On Fri, Jan 27, 2006 at 11:22:42PM +1100, Herbert Xu wrote:
> > OK, although we can't rule out sky2/netfilter from the enquiry, I've
> > identified two bugs in ppp/pppoe that may be responsible for what you
> > are seeing.  So please try the following patch and let us know if the
> > problem still exists (or deteriorates/improves).
> Borrowing this thread for a related problem, I'm getting lots of those on a
> bridge device (this one running skge, rmmod skge; modprobe sk98lin actually
> seemed to do it too, I've disabled rx checksums with ethtool for now). 
> Kernel is a 2.6.15.1-ish Fedora one.

Okay, what is the hardware version:
	dmesg | grep skge
Maybe that chip rev is no good.
