Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265467AbRF1BFF>; Wed, 27 Jun 2001 21:05:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265468AbRF1BE4>; Wed, 27 Jun 2001 21:04:56 -0400
Received: from pizda.ninka.net ([216.101.162.242]:33172 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S265467AbRF1BEq>;
	Wed, 27 Jun 2001 21:04:46 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15162.33445.396761.71174@pizda.ninka.net>
Date: Wed, 27 Jun 2001 18:04:37 -0700 (PDT)
To: anton@samba.org
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>, tom_gall@vnet.ibm.com,
        linux-kernel@vger.kernel.org
Subject: Re: RFC: Changes for PCI
In-Reply-To: <20010628091704.B23627@krispykreme>
In-Reply-To: <3B3A58FC.2728DAFF@vnet.ibm.com>
	<3B3A5B00.9FF387C9@mandrakesoft.com>
	<20010628091704.B23627@krispykreme>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


anton@samba.org writes:
 > > Why not use sysdata like the other arches?
 > > 
 > > Changing the meaning of dev->bus->number globally seems pointless.  If
 > > you are going to do that, just do it the right way and introduce another
 > > struct member, pci_domain or somesuch.
 > 
 > Thats 2.5 material. For 2.4 we should do as davem suggested and make
 > the bus number unique. I do this by just adding 256 to each overlapping
 > host bridge.

Looks, ppc64 is really still experimental right?  Which means it is
2.5.x material, and 2.5.x has been quoted as being a week or two away.

So we can solve this problem for real, with system bus domains, and
get ppc64 working all within the framework of 2.5.x which is just
around the corner.

For now, I am rather sure your systems for testing have < 256 physical
PCI busses and you can for 2.4.x use the remapping scheme sparc64 uses.

Later,
David S. Miller
davem@redhat.com
