Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271116AbTGWGLZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 02:11:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271115AbTGWGLZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 02:11:25 -0400
Received: from pizda.ninka.net ([216.101.162.242]:52622 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S271113AbTGWGLW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 02:11:22 -0400
Date: Tue, 22 Jul 2003 23:24:10 -0700
From: "David S. Miller" <davem@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: solca@guug.org, zaitcev@redhat.com, linux-kernel@vger.kernel.org,
       sparclinux@vger.kernel.org, debian-sparc@lists.debian.org
Subject: Re: sparc scsi esp depends on pci & hangs on boot
Message-Id: <20030722232410.7a37ed4d.davem@redhat.com>
In-Reply-To: <20030723070739.A697@infradead.org>
References: <20030722025142.GC25561@guug.org>
	<20030722080905.A21280@devserv.devel.redhat.com>
	<20030722182609.GA30174@guug.org>
	<20030722175400.4fe2aa5d.davem@redhat.com>
	<20030723070739.A697@infradead.org>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Jul 2003 07:07:39 +0100
Christoph Hellwig <hch@infradead.org> wrote:

> Sparc unfortunately defines the new DMA API in terms of the PCI DMA API
> which gets you this mess.

Sparc did not do this, the person coding up the new DMA API
decided it was a good idea to implement the generic version
this way. :-)

I think it's rediculious that I have to implement the whole
new DMA API abstraction thing just to get rid of this PCI
dependency.

Why don't we put the enum dma_direction somewhere else?  Some
linux/foo.h header that doesn't require asm/dma*.h
