Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262548AbULPANT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262548AbULPANT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 19:13:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262539AbULPAJu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 19:09:50 -0500
Received: from fmr19.intel.com ([134.134.136.18]:37248 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S262543AbULPAGq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 19:06:46 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH]PCI Express Port Bus Driver
Date: Wed, 15 Dec 2004 16:06:44 -0800
Message-ID: <C7AB9DA4D0B1F344BF2489FA165E5024073EBAE0@orsmsx404.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH]PCI Express Port Bus Driver
Thread-Index: AcTi7k9jsYVqDHcUTQCzDYMGjAfc5gAAbXlQ
From: "Nguyen, Tom L" <tom.l.nguyen@intel.com>
To: "Greg KH" <greg@kroah.com>
Cc: <linux-kernel@vger.kernel.org>, "Nguyen, Tom L" <tom.l.nguyen@intel.com>
X-OriginalArrivalTime: 16 Dec 2004 00:06:45.0544 (UTC) FILETIME=[213F9A80:01C4E303]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, December 15, 2004 1:37 PM, Greg KH wrote: 
>> +config PCIEPORTBUS
>> +	bool "PCI Express support"
>> +	depends on PCI_GOMMCONFIG
>
> This should also work if PCI_GOANY is selected, right?  Otherwise this
> feature will never be turned on by any distro :(
PCIE port bus driver depends on PCI_GOMMCONFIG to locate service
attributes
for advanced error reporting (AER) and virtual channel (VC) for each
PCIE port.
Without PCI_GOMMCONFIG, then a read to 0x100 offset or above will return
0xffff;
in other words, neither AER nor VC service support is found. We would
like to move
forward to have PCI_GOMMCONFIG dependency as the new features come
along. RHEL 4
is shipping with PCI_GOMMCONFIG configured into the kernel by default
and we 
expect the next major version of SuSE linux to do the same.

Thanks,
Long

