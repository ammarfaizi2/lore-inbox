Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262789AbSKMUHD>; Wed, 13 Nov 2002 15:07:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262804AbSKMUHD>; Wed, 13 Nov 2002 15:07:03 -0500
Received: from dsl2.external.hp.com ([192.25.206.7]:33804 "EHLO
	dsl2.external.hp.com") by vger.kernel.org with ESMTP
	id <S262789AbSKMUHB>; Wed, 13 Nov 2002 15:07:01 -0500
To: Miles Bader <miles@gnu.org>
Cc: Greg KH <greg@kroah.com>,
       "J.E.J. Bottomley" <James.Bottomley@steeleye.com>,
       Matthew Wilcox <willy@debian.org>,
       "Adam J. Richter" <adam@yggdrasil.com>, andmike@us.ibm.com, hch@lst.de,
       linux-kernel@vger.kernel.org, mochel@osdl.org,
       parisc-linux@lists.parisc-linux.org
Subject: Re: [parisc-linux] Untested port of parisc_device to generic device interface 
In-Reply-To: Message from Miles Bader <miles@lsi.nec.co.jp> 
   of "13 Nov 2002 17:02:39 +0900." <buoisz1sxr4.fsf@mcspd15.ucom.lsi.nec.co.jp> 
References: <20021109060342.GA7798@kroah.com> <200211091533.gA9FXuW02017@localhost.localdomain> <20021113061310.GD2106@kroah.com> <buon0odsyh9.fsf@mcspd15.ucom.lsi.nec.co.jp> <20021113075223.GZ2106@kroah.com>  <buoisz1sxr4.fsf@mcspd15.ucom.lsi.nec.co.jp> 
Date: Wed, 13 Nov 2002 13:13:57 -0700
From: Grant Grundler <grundler@dsl2.external.hp.com>
Message-Id: <20021113201357.5302F4829@dsl2.external.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miles Bader wrote:
> I can't speak for `real machines,' but on my wierd embedded board,
> pci_alloc_consistent allocates from a special area of memory (not
> located at 0) that is the only shared memory between PCI devices and the
> CPU.  pci_alloc_consistent happens to fit this situation quite well, but
> I don't think a bitmask is enough to express the situation.

HP PARISC V-Class do that as well. The "consistent" memory lives
on the PCI Bus Controller - not in host mem.
Note that parisc-linux does not (yet) support V-class.

grant
