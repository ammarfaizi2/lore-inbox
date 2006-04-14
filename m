Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751445AbWDNXRe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751445AbWDNXRe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Apr 2006 19:17:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751444AbWDNXRc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Apr 2006 19:17:32 -0400
Received: from mga03.intel.com ([143.182.124.21]:12364 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S1751442AbWDNXRb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Apr 2006 19:17:31 -0400
X-IronPort-AV: i="4.04,121,1144047600"; 
   d="scan'208"; a="23394930:sNHT17450839"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [patch 1/3] acpi: dock driver
Date: Fri, 14 Apr 2006 19:17:27 -0400
Message-ID: <CFF307C98FEABE47A452B27C06B85BB6300EF2@hdsmsx411.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [patch 1/3] acpi: dock driver
Thread-Index: AcZgF31J/ODn3YVsTpKjMBEeovQKhwAAezsA
From: "Brown, Len" <len.brown@intel.com>
To: "Accardi, Kristen C" <kristen.c.accardi@intel.com>
Cc: "Andrew Morton" <akpm@osdl.org>, <greg@kroah.com>,
       <linux-acpi@vger.kernel.org>, <pcihpd-discuss@lists.sourceforge.net>,
       <linux-kernel@vger.kernel.org>, <mochel@linux.intel.com>,
       <arjan@linux.intel.com>, <muneda.takahiro@jp.fujitsu.com>,
       <pavel@ucw.cz>, <temnota@kmv.ru>
X-OriginalArrivalTime: 14 Apr 2006 23:17:28.0281 (UTC) FILETIME=[98EDD490:01C66019]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
On Fri, 2006-04-14 at 15:42 -0700, Brown, Len wrote:

>> Re: acpi_os_free()
>> Please call kfree() instead, that wrapper is intended
>> just for the ACPICA core and although it appears symmetric,
>> it really shouldn't be used outside drivers/acpi/*/*.c

> Really?  why is it exported then?  We use this in drivers/pci/hotplug
as
> well, and it is all over the place in drivers/acpi.  Should I be
> modifying the hotplug drivers to not use this call?

yes.

re: why it is exported?
this is just the tip of the ice-berg of things that are exported and
should not be.

thanks,
-Len
