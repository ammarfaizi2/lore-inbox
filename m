Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261616AbVGaFFl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261616AbVGaFFl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 01:05:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261626AbVGaFFl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 01:05:41 -0400
Received: from fmr15.intel.com ([192.55.52.69]:19927 "EHLO
	fmsfmr005.fm.intel.com") by vger.kernel.org with ESMTP
	id S261616AbVGaFFi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 01:05:38 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: RE: revert yenta free_irq on suspend
Date: Sun, 31 Jul 2005 01:03:56 -0400
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B3004311E37@hdsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: revert yenta free_irq on suspend
Thread-Index: AcWVi11Bu0JyoJGeT1qyFI91BFLflgAACknw
From: "Brown, Len" <len.brown@intel.com>
To: "Linus Torvalds" <torvalds@osdl.org>, "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: <linux-kernel@vger.kernel.org>, "Russell King" <rmk+lkml@arm.linux.org.uk>,
       "Hugh Dickins" <hugh@veritas.com>, "Andrew Morton" <akpm@osdl.org>,
       "Dominik Brodowski" <linux@dominikbrodowski.net>,
       "Daniel Ritz" <daniel.ritz@gmx.ch>
X-OriginalArrivalTime: 31 Jul 2005 05:03:58.0130 (UTC) FILETIME=[42118920:01C5958D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>So I guess I'll just have to revert the ACPI change that 
>caused drivers to do request_irq/free_irq. I'd prefer it
>if the ACPI people did that revert themselves, though.

If that is what you want, I'll be happy to do it.

If one believes that suspend/resume is working on a large number of
systems -- working to a level that a distro can acutally support it,
then restoring our temporary resume IRQ router hack to make many systems
work
is clearly the right thing to do.

But that believe would be total fantasy -- supsend/resume is not
working on a large number of machines, and no distro is currently
able to support it.  (I'm talking about S3 suspend to RAM primarily,
suspend to disk is less interesting -- though Red Hat doesn't
even support _that_)

We can got back to the old hack, but it will probably just delay
the day that suspend/resume is working broadly, and actually
can be deployed and supported by distros.

-Len
