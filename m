Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265269AbTIJQcu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 12:32:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265270AbTIJQct
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 12:32:49 -0400
Received: from fmr09.intel.com ([192.52.57.35]:48885 "EHLO hermes.hd.intel.com")
	by vger.kernel.org with ESMTP id S265269AbTIJQcs convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 12:32:48 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: RE: BugReport: USB (ACPI), E100, SWSUSP problems (test5 vs. test3)
Date: Wed, 10 Sep 2003 09:32:31 -0700
Message-ID: <C6F5CF431189FA4CBAEC9E7DD5441E010124F026@orsmsx402.jf.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: BugReport: USB (ACPI), E100, SWSUSP problems (test5 vs. test3)
Thread-Index: AcN3nZFUAbtFxDV4QHOLzZSG/H8Q5AAGrAoQ
From: "Feldman, Scott" <scott.feldman@intel.com>
To: <tom@qwws.net>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 10 Sep 2003 16:32:31.0425 (UTC) FILETIME=[21AE9310:01C377B9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> - The e100 driver seems to be broken
>   The NIC is detected correctly and ifconfig shows eth0 as 
> usually. But for some reason not a single Byte seems to go over the
NIC. 

The only change to e100 between test3 and test5 is:

-       kfree(dev);
+       free_netdev(dev);

But that's only relevant when the driver is unloaded, so I would
consider the drivers in test3 and test5 the same for your case.

What are you doing with eth0 that worked for test3, but not for test5?

-scott
