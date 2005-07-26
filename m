Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261722AbVGZFXX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261722AbVGZFXX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 01:23:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261728AbVGZFXX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 01:23:23 -0400
Received: from fmr15.intel.com ([192.55.52.69]:54667 "EHLO
	fmsfmr005.fm.intel.com") by vger.kernel.org with ESMTP
	id S261722AbVGZFXU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 01:23:20 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: RE: 2.6.13-rc3 Battery times at 100/250/1000 Hz = Zero difference
Date: Tue, 26 Jul 2005 01:23:08 -0400
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B300424AE32@hdsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.6.13-rc3 Battery times at 100/250/1000 Hz = Zero difference
Thread-Index: AcWRS4omMVcQV3szTeGFSvdW2+Ti8gAVbzpQ
From: "Brown, Len" <len.brown@intel.com>
To: "Bill Davidsen" <davidsen@tmr.com>, "Tony Lindgren" <tony@atomide.com>
Cc: "Pavel Machek" <pavel@ucw.cz>, <jesper.juhl@gmail.com>,
       <linux-kernel@vger.kernel.org>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
X-OriginalArrivalTime: 26 Jul 2005 05:23:11.0717 (UTC) FILETIME=[1D983150:01C591A2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
>>>Digging up this patch from last month regarding C2
>>>on a AMD K7 implies
>>>that the whole blame can be put on kernel acpi:
>>>
>>>http://marc.theaimsgroup.com/?l=linux-kernel&m=111933745131301&w=2

The current Linus tree includes generic ACPI support
for deep C-states on SMP machines. (deep means higher than C1)

I don't have any problem with people having platform specific
modules to handle platform specific features.  However, if
the system really intends to support SMP ACPI C-states deeper
than C1 and the generic ACPI code doesn't support it,
then it is either a Linux/ACPI bug or a BIOS bug -- file away:-)

I.e. The whole concept of ACPI is that you shoulud _not_ need
a platform specific driver to accomplish this.

cheers,
-Len
