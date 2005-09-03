Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751277AbVICQ6f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751277AbVICQ6f (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Sep 2005 12:58:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751252AbVICQ6e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Sep 2005 12:58:34 -0400
Received: from fmr13.intel.com ([192.55.52.67]:3304 "EHLO
	fmsfmr001.fm.intel.com") by vger.kernel.org with ESMTP
	id S1751113AbVICQ6c convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Sep 2005 12:58:32 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: 2.6.13-mm1 login fails  (RE: 2.6.13-mm1: hangs during boot ...)
Date: Sat, 3 Sep 2005 12:58:15 -0400
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B30047FA093@hdsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.6.13-mm1 login fails  (RE: 2.6.13-mm1: hangs during boot ...)
Thread-Index: AcWwitF/MNHt3x7zQnecMYQFwazRswAFYwkw
From: "Brown, Len" <len.brown@intel.com>
To: "Reuben Farrelly" <reuben-lkml@reub.net>,
       "Peter Williams" <pwil3058@bigpond.net.au>
Cc: "Andrew Morton" <akpm@osdl.org>, <linux-kernel@vger.kernel.org>,
       "James Bottomley" <James.Bottomley@steeleye.com>,
       <linux-scsi@vger.kernel.org>
X-OriginalArrivalTime: 03 Sep 2005 16:58:17.0291 (UTC) FILETIME=[AE2A01B0:01C5B0A8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
>As for the inability to log in, this bug may be relevant, 
>given I also had 
>that problem:
>
>https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=166422
>
>There are fixes in the pipeline for util-linux audit 
>interaction in Fedora as 
>well.  I know because I reported those too ;)
>
>> after the scsi initialization which I don't normally see.  
>I've attached 
>> the scsi initialization output.  The PF_NETLINK error 
>messages after the 
>> login prompt in this output are created whenever I try to log in or 
>> connect via ssh.
>
>The workaround by enabling audit support, but obviously a 
>better fix is in the 
>pipeline..
>
>I'm surprised more people aren't discovering these 
>'interactions' due to 
>having audit not turned on.  Does everyone build audit into 
>their kernels?

This sure made my FC4 test boxes hard to use!

CONFIG_AUDIT=y indeed did the trick.

When will I be able to delete CONFIG_AUDIT from my kernel again?

thanks
-Len
