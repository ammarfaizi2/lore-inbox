Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275312AbTHSDRt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 23:17:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275319AbTHSDRt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 23:17:49 -0400
Received: from fmr04.intel.com ([143.183.121.6]:17646 "EHLO
	caduceus.sc.intel.com") by vger.kernel.org with ESMTP
	id S275312AbTHSDRs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 23:17:48 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: RE: [SOLVED] RE: 2.6.0-test3 latest bk hangs when enabling IO-APIC
Date: Mon, 18 Aug 2003 23:17:01 -0400
Message-ID: <BF1FE1855350A0479097B3A0D2A80EE009FC7B@hdsmsx402.hd.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [SOLVED] RE: 2.6.0-test3 latest bk hangs when enabling IO-APIC
Thread-Index: AcNl9UWXKfttaYPySV2W38TxVkHwAQACNO8Q
From: "Brown, Len" <len.brown@intel.com>
To: "Jeff Garzik" <jgarzik@pobox.com>
Cc: "Stian Jordet" <liste@jordet.nu>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 19 Aug 2003 03:17:03.0152 (UTC) FILETIME=[5C539300:01C36600]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> So... concrete suggestions?  Overall, IMO, move everything under 
> CONFIG_ACPI, or, make CONFIG_ACPI_BOOT a _peer_ option, whose 
> selection 
> or lackthereof doesn't affect CONFIG_ACPI visibility at all.

Simply re-naming CONFIG_ACPI_HT to be CONFIG_ACPI_BOOT might help, as it
would be more clear that it is necessary for the rest of ACPI.  However,
it may not be obvious that it provides the minimal config to enable HT.

Re: peers
Unfortunately ACPI doesn't work so well if CONFIG_ACPI_BOOT is left out.
Yes, it's conceivable, but I spent several hours tinkering with it in
search of a "noht" build option, but ditched it b/c it seemed like a
build option very few would use.

Re: CONFIG_ACPI is the the master switch, and all other ACPI options
subservient...
If implemented literally, this is sort of a pain, as CONFIG_ACPI appears
all over the code.  However, a dummy config master ACPI config option
could be used to enable the menu that contains all the rest of ACPI...

-Len
