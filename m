Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261330AbVAMRfi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261330AbVAMRfi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 12:35:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261341AbVAMRfH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 12:35:07 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:2222 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261331AbVAMReI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 12:34:08 -0500
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: John Rose <johnrose@austin.ibm.com>
Subject: Re: [PATCH] release_pcibus_dev() crash
Date: Thu, 13 Jan 2005 09:33:58 -0800
User-Agent: KMail/1.7.1
Cc: Greg KH <greg@kroah.com>, lkml <linux-kernel@vger.kernel.org>
References: <1105576756.8062.17.camel@sinatra.austin.ibm.com> <200501121655.42947.jbarnes@engr.sgi.com> <1105636311.30960.8.camel@sinatra.austin.ibm.com>
In-Reply-To: <1105636311.30960.8.camel@sinatra.austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501130933.59041.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, January 13, 2005 9:11 am, John Rose wrote:
> Jesse-
>
> I'm having trouble with enabling the legacy PCI stuff.  I added #define
> HAVE_PCI_LEGACY to pci.h, but probe.c doesn't build:
>
> drivers/pci/probe.c: In function `pci_create_legacy_files':
> drivers/pci/probe.c:50: error: `pci_read_legacy_io' undeclared (first
> use in this function)
> drivers/pci/probe.c:50: error: (Each undeclared identifier is reported
> only oncedrivers/pci/probe.c:50: error: for each function it appears
> in.)
> drivers/pci/probe.c:51: error: `pci_write_legacy_io' undeclared (first
> use in this function)
> drivers/pci/probe.c:60: error: `pci_mmap_legacy_mem' undeclared (first
> use in this function)
>
> Am I missing something obvious? :)

Maybe, did you read Documentation/filesystems/sysfs-pci.c?  You need to do 
more than just enable HAVE_PCI_LEGACY, you also need to implement some 
functions.

Jesse
