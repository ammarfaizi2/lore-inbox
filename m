Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261759AbTDQRLI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 13:11:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261764AbTDQRLI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 13:11:08 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:36296
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S261759AbTDQRLH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 13:11:07 -0400
Subject: Re: Subtle semantic issue with sleep callbacks in drivers
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: John Bradford <john@grabjohn.com>, Patrick Mochel <mochel@osdl.org>,
       Grover Andrew <andrew.grover@intel.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030417155602.GC25696@gtf.org>
References: <20030417150926.GA25402@gtf.org>
	 <200304171547.h3HFljoK000140@81-2-122-30.bradfords.org.uk>
	 <20030417155602.GC25696@gtf.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1050596681.31390.100.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 17 Apr 2003 17:24:41 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2003-04-17 at 16:56, Jeff Garzik wrote:
> On Thu, Apr 17, 2003 at 04:47:45PM +0100, John Bradford wrote:
> > Hmm, well what about with a PCI hotswap capable board - presumably
> > then we could have the situation where a new VGA card appears that we
> > _have_ to POST?
> 
> Then XFree86 will POST it.
> 
> The kernel really only cares about POST'ing the primary display, too.
> Firmware typically completely disables, and does not POST, secondary
> displays.  XFree86 is charged with the responsibility of POST'ing
> secondary displays.

XFree86 currently has to do some pray and hope stuff here. We cannot have
X and the kernel both controlling PCI allocations and config space at once.
X needs kernel interfaces to do the job right some day.

