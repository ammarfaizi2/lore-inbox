Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271152AbTGWHOy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 03:14:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271153AbTGWHOy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 03:14:54 -0400
Received: from pizda.ninka.net ([216.101.162.242]:35983 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S271152AbTGWHOw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 03:14:52 -0400
Date: Wed, 23 Jul 2003 00:27:37 -0700
From: "David S. Miller" <davem@redhat.com>
To: Otto Solares <solca@guug.org>
Cc: hch@infradead.org, zaitcev@redhat.com, linux-kernel@vger.kernel.org,
       sparclinux@vger.kernel.org, debian-sparc@lists.debian.org
Subject: Re: sparc scsi esp depends on pci & hangs on boot
Message-Id: <20030723002737.376d93ca.davem@redhat.com>
In-Reply-To: <20030723072056.GF30174@guug.org>
References: <20030722025142.GC25561@guug.org>
	<20030722080905.A21280@devserv.devel.redhat.com>
	<20030722182609.GA30174@guug.org>
	<20030722175400.4fe2aa5d.davem@redhat.com>
	<20030723070739.A697@infradead.org>
	<20030722232410.7a37ed4d.davem@redhat.com>
	<20030723072836.A932@infradead.org>
	<20030722232911.2e6fda86.davem@redhat.com>
	<20030723064311.GE30174@guug.org>
	<20030723080454.B5245@infradead.org>
	<20030723072056.GF30174@guug.org>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Jul 2003 01:20:56 -0600
Otto Solares <solca@guug.org> wrote:

> everything else includes the generic one (pci dependant).
> With this model what happens if a box had more than one
> bus type (if technically possible)?

If the architecture wants to support such situations,
then the implementation needs to vector off to different
operations based upon the actual bus type.

Even though technically devices having SBUS and PCI variants could do
this, none do currently, and also I do not use the generic device
model in the SBUS layer, therefore I'm not going to add such multi-bus
support to what Sparc uses for dma-mapping.h

If someone is bored and willing to do all of the generic device and
->dma_ops work for Sparc and SBUS, feel free to send me some patches.
Otherwise, it won't get done :-)

