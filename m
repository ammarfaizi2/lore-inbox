Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263685AbUFIM7a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263685AbUFIM7a (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 08:59:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265729AbUFIM73
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 08:59:29 -0400
Received: from mail.fh-wedel.de ([213.39.232.194]:7830 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S263685AbUFIM72 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 08:59:28 -0400
Date: Wed, 9 Jun 2004 14:59:12 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: chase.maupin@hp.com, iss_storagedev@hp.com, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [STACK] >4k call path in hp/compaq fibre channel driver
Message-ID: <20040609125912.GK21168@wohnheim.fh-wedel.de>
References: <20040609124302.GI21168@wohnheim.fh-wedel.de> <1086785454.2810.13.camel@laptop.fenrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1086785454.2810.13.camel@laptop.fenrus.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 June 2004 14:50:54 +0200, Arjan van de Ven wrote:
> On Wed, 2004-06-09 at 14:43, Jörn Engel wrote:
> > Chase, I guess this code won't live long with 4k stacks.  Can you
> > please fix CpqTsProcessIMQEntry() and PeekIMQEntry()?
> > 
> > Linus, Andrew, how about marking CONFIG_SCSI_CPQFCTS as broken for the
> > time being?
> 
> isn't it already? I thought it never got adjusted to the 2.6 scsi layer
> already (or the 2.4 one for that matter)

Doesn't look like it.

But that's a good point.  I could use allnonbrokenconfig for stack
tests the next time.

config SCSI_CPQFCTS
	tristate "Compaq Fibre Channel 64-bit/66Mhz HBA support"
	depends on PCI && SCSI
	help
	  Say Y here to compile in support for the Compaq StorageWorks Fibre
	  Channel 64-bit/66Mhz Host Bus Adapter.

Jörn

-- 
Happiness isn't having what you want, it's wanting what you have.
-- unknown
