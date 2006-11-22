Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755899AbWKVNy1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755899AbWKVNy1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 08:54:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755906AbWKVNy0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 08:54:26 -0500
Received: from palinux.external.hp.com ([192.25.206.14]:10398 "EHLO
	mail.parisc-linux.org") by vger.kernel.org with ESMTP
	id S1755899AbWKVNyZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 08:54:25 -0500
Date: Wed, 22 Nov 2006 06:54:23 -0700
From: Matthew Wilcox <matthew@wil.cx>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, Greg KH <greg@kroah.com>,
       Grant Grundler <grundler@parisc-linux.org>,
       Andrew Morton <akpm@osdl.org>, e1000-devel@lists.sourceforge.net,
       linux-scsi@vger.kernel.org,
       Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Subject: Re: [PATCH 4/5] e1000 : Make Intel e1000 driver legacy I/O port free
Message-ID: <20061122135423.GV18567@parisc-linux.org>
References: <4564050C.70607@jp.fujitsu.com> <1164185809.31358.714.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1164185809.31358.714.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2006 at 09:56:49AM +0100, Arjan van de Ven wrote:
> On Wed, 2006-11-22 at 17:06 +0900, Hidetoshi Seto wrote:
> >  static struct pci_device_id e1000_pci_tbl[] = {
> > +	INTEL_E1000_ETHERNET_DEVICE(0x1004, 0),
> > +	INTEL_E1000_ETHERNET_DEVICE(0x1008, E1000_USE_IOPORT),
> 
> Hi,
> 
> this has the unfortunate effect that it's now a lot harder to add PCI
> ID's to this driver at runtime via sysfs ;(

It does?  Normally you get 0 passed in that field, so you'll just not
get io ports enabled ...

Need to set use_driver_data to get non-0 passed in that field.
