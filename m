Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271330AbTHMAkx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 20:40:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271331AbTHMAkx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 20:40:53 -0400
Received: from fw.osdl.org ([65.172.181.6]:40930 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S271330AbTHMAkv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 20:40:51 -0400
Date: Tue, 12 Aug 2003 17:37:42 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: greg@kroah.com, willy@debian.org, davem@redhat.com,
       linux-kernel@vger.kernel.org,
       kernel-janitor-discuss@lists.sourceforge.net
Subject: Re: C99 Initialisers
Message-Id: <20030812173742.6e17f7d7.rddunlap@osdl.org>
In-Reply-To: <3F3986ED.1050206@pobox.com>
References: <20030812020226.GA4688@zip.com.au>
	<1060654733.684.267.camel@localhost>
	<20030812023936.GE3169@parcelfarce.linux.theplanet.co.uk>
	<20030812053826.GA1488@kroah.com>
	<20030812112729.GF3169@parcelfarce.linux.theplanet.co.uk>
	<20030812180158.GA1416@kroah.com>
	<3F397FFB.9090601@pobox.com>
	<20030812171407.09f31455.rddunlap@osdl.org>
	<3F3986ED.1050206@pobox.com>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Aug 2003 20:31:41 -0400 Jeff Garzik <jgarzik@pobox.com> wrote:

| Randy.Dunlap wrote:
| > On Tue, 12 Aug 2003 20:02:03 -0400 Jeff Garzik <jgarzik@pobox.com> wrote:
| > 
| > | Greg KH wrote:
| > | > In the end, it's up to the maintainer of the driver what they want to
| >                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
| > | > do.  So, Jeff and David, here's a patch against the latest 2.6.0-test3
| > | > tg3.c that converts the pci_device_id table to C99 initializers.  If you
| > | > want to, please apply it.
| > 
| > I strongly agree with Greg's comment above.
| > | 
| > | it expands a few lines to a bazillion :(   I would rather leave it as 
| > | is...  you'll find several PCI ethernet drivers with pci_device_id 
| > | entries that fit entirely on one line, and I think that compactness has 
| > | value at least to me.
| > 
| > However, I would change for readability.  Maybe not my readability,
| > but for all others who read and try to help maintain all of Linux
| > source code.
| 
| 
| I find the compact form quite readable, and comfortable on the eyes. 

and since you are the drivers/net/ maintainer, you can make the decision.
However, in the end, it's not just about you.  You are the primary
maintainer but not the only user or maintainer of those drivers.

| Users don't seem to complain, either.  I get compact-form pci_device_id 
| patches from Joe Sixpack quite often :)
| 
| Expanding this device id struct to use C99 initializers isn't terribly 
| scalable:  once you get past just a few ids, you bloat up the source 
| code considerably.  I would much rather move the PCI ids out of the 
| drivers altogether, into some metadata file(s) in the kernel source 
| tree, than bloat up tg3, tulip, e100, and the other PCI id-heavy 
| drivers' source code.

That last few lines certainly sounds desirable.

--
~Randy				For Linux-2.6, see:
http://www.kernel.org/pub/linux/kernel/people/davej/misc/post-halloween-2.5.txt
