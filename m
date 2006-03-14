Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751950AbWCNWe3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751950AbWCNWe3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 17:34:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751947AbWCNWe3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 17:34:29 -0500
Received: from fmr21.intel.com ([143.183.121.13]:34285 "EHLO
	scsfmr001.sc.intel.com") by vger.kernel.org with ESMTP
	id S1751944AbWCNWe2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 17:34:28 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH] provide hrtimer exports for module use [Was: Exportsfor hrtimer APIs]
Date: Tue, 14 Mar 2006 14:34:19 -0800
Message-ID: <CBDB88BFD06F7F408399DBCF8776B3DC06A92C2B@scsmsx403.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] provide hrtimer exports for module use [Was: Exportsfor hrtimer APIs]
Thread-Index: AcZHtUuMDojGePQMR9CPzPbQks4k4wAAHoww
From: "Stone, Joshua I" <joshua.i.stone@intel.com>
To: <tglx@linutronix.de>
Cc: "Andrew Morton" <akpm@osdl.org>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 14 Mar 2006 22:34:18.0815 (UTC) FILETIME=[6EAE6CF0:01C647B7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Gleixner wrote:
> What means "more for defining intervals" ? Which intervals  (period in
> ms)? What are the timers used for ?

The user can write a block of code that they would like to be executed
repeatedly in fixed intervals.  A trivial example might look like this:
    probe timer.ms(10) { flush_data(); }

This would flush the data every 10ms.

A example of polling might be:
    probe timer.ms(1) { log(scheduler_queue_length()); }

I hope this answers your questions...


Josh
