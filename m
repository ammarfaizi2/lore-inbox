Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264525AbTIDCjD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 22:39:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264546AbTIDCiw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 22:38:52 -0400
Received: from fmr09.intel.com ([192.52.57.35]:45542 "EHLO hermes.hd.intel.com")
	by vger.kernel.org with ESMTP id S264525AbTIDChS convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 22:37:18 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: RE: 2.6.0-test4-mm5
Date: Wed, 3 Sep 2003 19:37:13 -0700
Message-ID: <7F740D512C7C1046AB53446D3720017304AF02@scsmsx402.sc.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.6.0-test4-mm5
Thread-Index: AcNyhKw+hj4HbJ1/TCmc4n78kNTXJAAB7saQ
From: "Nakajima, Jun" <jun.nakajima@intel.com>
To: "Bill Huey (hui)" <billh@gnuppy.monkey.org>,
       "Andrew Morton" <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, "linux-acpi" <linux-acpi@intel.com>
X-OriginalArrivalTime: 04 Sep 2003 02:37:14.0514 (UTC) FILETIME=[73325720:01C3728D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, that patch was intended for broader tests before we check it out.


As some people pointed out, it needs:


	int result;
+
+	ACPI_FUNCTION_TRACE("acpi_pci_link_try_get_current");
+
	result = acpi_pci_link_get_current(link);
	if (result && link->irq.active) {
 		return_VALUE(result);
 	}

> -----Original Message-----
> From: Bill Huey (hui) [mailto:billh@gnuppy.monkey.org]
> Sent: Wednesday, September 03, 2003 6:31 PM
> To: Andrew Morton
> Cc: linux-kernel@vger.kernel.org; Bill Huey (hui)
> Subject: Re: 2.6.0-test4-mm5
> 
> On Tue, Sep 02, 2003 at 11:18:12PM -0700, Andrew Morton wrote:
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-
> test4/2.6.0-test4-mm5/
> 
> make[1]: `arch/i386/kernel/asm-offsets.s' is up to date.
>   CHK     include/linux/compile.h
>   CC      drivers/acpi/pci_link.o
> drivers/acpi/pci_link.c: In function `acpi_pci_link_try_get_current':
> drivers/acpi/pci_link.c:290: error: `_dbg' undeclared (first use in
this
> function)
> drivers/acpi/pci_link.c:290: error: (Each undeclared identifier is
> reported only once
> drivers/acpi/pci_link.c:290: error: for each function it appears in.)
> make[2]: *** [drivers/acpi/pci_link.o] Error 1
> make[1]: *** [drivers/acpi] Error 2
> make: *** [drivers] Error 2
> 
>
------------------------------------------------------------------------
--
> ----------------
> 
> bill
> 
> -
> To unsubscribe from this list: send the line "unsubscribe
linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
