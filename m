Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265258AbUBJFPx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 00:15:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265264AbUBJFPx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 00:15:53 -0500
Received: from fmr04.intel.com ([143.183.121.6]:40581 "EHLO
	caduceus.sc.intel.com") by vger.kernel.org with ESMTP
	id S265258AbUBJFPw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 00:15:52 -0500
Subject: Re: [PATCH] pci-mmconfig for 2.6.3-rc1
From: Len Brown <len.brown@intel.com>
To: Matthew Wilcox <willy@debian.org>
Cc: Sundarapandian Durairaj <sundarapandian.durairaj@intel.com>,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       Harinarayanan Seshadri <harinarayanan.seshadri@intel.com>,
       Vladimir Kondratiev <vladimir.kondratiev@intel.com>,
       Jun Nakajima <jun.nakajima@intel.com>, Greg KH <greg@kroah.com>,
       Andrew Morton <akpm@zip.com.au>
In-Reply-To: <20040210044540.GA13351@parcelfarce.linux.theplanet.co.uk>
References: <20040210044540.GA13351@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain
Organization: 
Message-Id: <1076390140.4105.671.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 10 Feb 2004 00:15:40 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-02-09 at 23:45, Matthew Wilcox wrote:
> Another round of the MMCONFIG patch.  Changes since last time ...

If the system has no MADT, then acpi_boot_init() will never call
acpi_parse_mcfg() -- looks like that call needs to be moved up.  (And
yes, it seems that HPET has the same problem).

I see i386 and ia64 updates -- are they the only platforms that will
support pci-express?

thanks,
-Len


