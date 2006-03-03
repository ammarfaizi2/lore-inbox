Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932577AbWCCXdx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932577AbWCCXdx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 18:33:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932562AbWCCXdx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 18:33:53 -0500
Received: from xenotime.net ([66.160.160.81]:55997 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751033AbWCCXdw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 18:33:52 -0500
Date: Fri, 3 Mar 2006 15:35:17 -0800
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Robert Hancock <hancockr@shaw.ca>, albertcc@tw.ibm.com,
       jtreubig@hotmail.com
Cc: linux-kernel@vger.kernel.org, scsi <linux-scsi@vger.kernel.org>
Subject: Re: CDROM support for Promise 20269
Message-Id: <20060303153517.0e10f5d7.rdunlap@xenotime.net>
In-Reply-To: <4408D082.2070203@shaw.ca>
References: <5Mquh-2mT-97@gated-at.bofh.it>
	<4408D082.2070203@shaw.ca>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.2 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 03 Mar 2006 17:25:54 -0600 Robert Hancock wrote:

> John Treubig wrote:
> > I've been working on a problem with Promise 20269 PATA adapter under 
> > LibATA that if I attach a CDROM drive, I can not see the drive.  The 
> > message log reports that the driver sees the device, but when I'm fully 
> > booted, there's no device available.
> 
> ..
> 
> > [  118.621489] scsi4 : pata_pdc2027x
> > [  118.643926] ata1(1): WARNING: ATAPI is disabled, device ignored.
> 
> Sounds like your problem there.. need to enable ATAPI in your 
> libata/PATA kernel configuration?

Please don't drop cc's etc.  Just use reply-to-all.

For John:  this means that you need to load libata with this option:
atapi_enabled=1
So if you build it into the kernel image, add this to the boot option:
  libata.atapi_enabled=1
or if you load it as a module, just add:  atapi_enabled=1
or you can edit the source file and change the variable to 1,
but that's the least preferable way IMO.

---
~Randy
