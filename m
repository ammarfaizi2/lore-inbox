Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266264AbUBDHXQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 02:23:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266254AbUBDHXQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 02:23:16 -0500
Received: from fmr09.intel.com ([192.52.57.35]:22938 "EHLO hermes.hd.intel.com")
	by vger.kernel.org with ESMTP id S266264AbUBDHW4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 02:22:56 -0500
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: ACPI -- Workaround for broken DSDT
Date: Wed, 4 Feb 2004 02:22:18 -0500
Message-ID: <BF1FE1855350A0479097B3A0D2A80EE0CC8A9F@hdsmsx402.hd.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: ACPI -- Workaround for broken DSDT
Thread-Index: AcPp/EWWxiNYp/2wSa26qLUv3RkgVgAp3hWQ
From: "Brown, Len" <len.brown@intel.com>
To: <trelane@digitasaru.net>
Cc: <bluefoxicy@linux.net>, <linux-kernel@vger.kernel.org>,
       <acpi-devel@lists.sourceforge.net>
X-OriginalArrivalTime: 04 Feb 2004 07:22:20.0081 (UTC) FILETIME=[A01C7A10:01C3EAEF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From Brown, Len on Sunday, 01 February, 2004:
> >The vendor should supply a correct DSDT with their BIOS.
> >In the case of Dell, you might inquire here: http://linux.dell.com/
> >For non-vendor supplied solutions, you might also follow the 
> DSDT link
> >here: http://acpi.sourceforge.net/  
> 
> Hmm.  Do vendors generally release these?  I know Dell's very shaky on
>   the Linux support front, at least for desktop/laptop.
> Also, how do non-vendor supplied ones get made?  Seems like something
>   you need NDA'ed docs for.

Non-vendor supplied DSDTs are created by end-users who bought machines
that don't work.  Per the DSDT link above, one can extract,
dis-assemble, modify a DSDT -- and tell Linux to use your copy instead
of the version burned into PROM.

While detailed hardware docs would be required to understand all the
code, that is not necessary to fix the majority of DSDT errors that
confuse Linux.  The common errors generally result from simple
programming blunders that are not caught at build-time by the partciular
AML compiler the vendor uses, nor at run-time by the particular OS the
vendor uses for validation.

When vendors use an improved AML compiler (such as the one freely
available from Intel;-), and test their platforms on ACPI-enabled Linux,
these problems generally go away and so does the topic of fixing broken
DSDTs.

Indeed, I'm not confident that fixing DSDTs for vendors is always a good
idea -- particularly if the vendors don't take the feedback.  I'd rather
see Linux users able to vote with their dollars to support vendors that
best support Linux.

That said, if you're stuck with a box that needs a DSDT fix -- I
encourage you to work with the vendor to get the DSDT fixed.  Yes, I've
seen handing them the fix on a silver platter work just fine;-)
However, as I'm not a lawyer and don't play one on TV, note that I can't
give anybody permission to _publish_ modified vendor firmware -- only
the vendor can do that. 

Cheers,
-Len
