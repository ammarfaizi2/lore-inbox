Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271124AbTGWHKc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 03:10:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271152AbTGWHKc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 03:10:32 -0400
Received: from guug.org ([168.234.203.30]:64471 "EHLO guug.galileo.edu")
	by vger.kernel.org with ESMTP id S271124AbTGWHK0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 03:10:26 -0400
Date: Wed, 23 Jul 2003 01:20:56 -0600
To: Christoph Hellwig <hch@infradead.org>,
       "David S. Miller" <davem@redhat.com>, zaitcev@redhat.com,
       linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org,
       debian-sparc@lists.debian.org
Subject: Re: sparc scsi esp depends on pci & hangs on boot
Message-ID: <20030723072056.GF30174@guug.org>
References: <20030722025142.GC25561@guug.org> <20030722080905.A21280@devserv.devel.redhat.com> <20030722182609.GA30174@guug.org> <20030722175400.4fe2aa5d.davem@redhat.com> <20030723070739.A697@infradead.org> <20030722232410.7a37ed4d.davem@redhat.com> <20030723072836.A932@infradead.org> <20030722232911.2e6fda86.davem@redhat.com> <20030723064311.GE30174@guug.org> <20030723080454.B5245@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030723080454.B5245@infradead.org>
User-Agent: Mutt/1.5.4i
From: Otto Solares <solca@guug.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 23, 2003 at 08:04:55AM +0100, Christoph Hellwig wrote:
> If you want to help fix asm-generic/dma-mapping.h to be noops
> if !CONFIG_PCI or even better make it always noops and add an
> asm-generic/dma-mapping-in-terms-of-pci.h for those who want
> them to map to PCI.

if !CONFIG_PCI -> noops
else include asm-generic/dma-mapping.h

That seems doable, but..
just arm, i386 & parisc have their own dma-mapping.h
everything else includes the generic one (pci dependant).
With this model what happens if a box had more than one
bus type (if technically possible)?

-solca

