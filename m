Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268111AbTBSAlW>; Tue, 18 Feb 2003 19:41:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268112AbTBSAlW>; Tue, 18 Feb 2003 19:41:22 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:2443
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S268111AbTBSAlV>; Tue, 18 Feb 2003 19:41:21 -0500
Subject: Re: PATCH: clean up the IDE iops, add ones for a dead iface
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Russell King <rmk@arm.linux.org.uk>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030218230910.A27653@flint.arm.linux.org.uk>
References: <E18lC5R-00067P-00@the-village.bc.nu>
	 <20030218230910.A27653@flint.arm.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1045619583.25795.11.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 19 Feb 2003 01:53:04 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-02-18 at 23:09, Russell King wrote:
> On Tue, Feb 18, 2003 at 06:03:21PM +0000, Alan Cox wrote:
> > +static u8 ide_unplugged_inb (unsigned long port)
> > +{
> > +	return 0xFF;
> > +}
> 
> Shouldn't this return 0x7f, ie bit 7 clear, as if we have an interface
> without drive attached?

0xFF is what most hardware returns for an unclaimed pci address. I'd rather
make sure it also works when we don't get the event, or the device 
summarily explodes than fake up something to make it look good. If
0xff doesnt work we have a bug anyway, lets find them.

Alan

