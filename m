Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271163AbTGWIpN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 04:45:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271160AbTGWIpN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 04:45:13 -0400
Received: from guug.galileo.edu ([168.234.203.30]:14296 "EHLO guug.galileo.edu")
	by vger.kernel.org with ESMTP id S271158AbTGWIpJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 04:45:09 -0400
Date: Wed, 23 Jul 2003 02:55:38 -0600
To: "David S. Miller" <davem@redhat.com>
Cc: hch@infradead.org, zaitcev@redhat.com, linux-kernel@vger.kernel.org,
       sparclinux@vger.kernel.org, debian-sparc@lists.debian.org
Subject: Re: sparc scsi esp depends on pci & hangs on boot
Message-ID: <20030723085538.GH30174@guug.org>
References: <20030722182609.GA30174@guug.org> <20030722175400.4fe2aa5d.davem@redhat.com> <20030723070739.A697@infradead.org> <20030722232410.7a37ed4d.davem@redhat.com> <20030723072836.A932@infradead.org> <20030722232911.2e6fda86.davem@redhat.com> <20030723064311.GE30174@guug.org> <20030723080454.B5245@infradead.org> <20030723072056.GF30174@guug.org> <20030723002737.376d93ca.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030723002737.376d93ca.davem@redhat.com>
User-Agent: Mutt/1.5.4i
From: Otto Solares <solca@guug.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 23, 2003 at 12:27:37AM -0700, David S. Miller wrote:
> On Wed, 23 Jul 2003 01:20:56 -0600
> Otto Solares <solca@guug.org> wrote:
> 
> > everything else includes the generic one (pci dependant).
> > With this model what happens if a box had more than one
> > bus type (if technically possible)?
> 
> If the architecture wants to support such situations,
> then the implementation needs to vector off to different
> operations based upon the actual bus type.
> 
> Even though technically devices having SBUS and PCI variants could do
> this, none do currently, and also I do not use the generic device
> model in the SBUS layer, therefore I'm not going to add such multi-bus
> support to what Sparc uses for dma-mapping.h

ok, i understand now.  Theorically could be nice the new API,
i better stick with the current per-bus-drivers.

> If someone is bored and willing to do all of the generic device and
> ->dma_ops work for Sparc and SBUS, feel free to send me some patches.
> Otherwise, it won't get done :-)

:) fine with me.

-solca

