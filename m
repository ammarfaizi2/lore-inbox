Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261748AbTISVSs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Sep 2003 17:18:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261753AbTISVSs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Sep 2003 17:18:48 -0400
Received: from fmr09.intel.com ([192.52.57.35]:62438 "EHLO hermes.hd.intel.com")
	by vger.kernel.org with ESMTP id S261748AbTISVSq convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Sep 2003 17:18:46 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: RE: [PATCH 2.6.x] additional kernel event notifications
Date: Fri, 19 Sep 2003 14:18:40 -0700
Message-ID: <7F740D512C7C1046AB53446D372001732DEC72@scsmsx402.sc.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 2.6.x] additional kernel event notifications
Thread-Index: AcN+58ecS+quXlMsTCO8IYQyfTfKZAABaa4g
From: "Villacis, Juan" <juan.villacis@intel.com>
To: "Andrew Morton" <akpm@osdl.org>
Cc: <jbarnes@sgi.com>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 19 Sep 2003 21:18:41.0156 (UTC) FILETIME=[995B5C40:01C37EF3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

"Andrew Morton" <akpm@osdl.org> wrote:
>
> That code seems to have a lot of infrastructure for buffering samples,
> transferring it to userspace, etc.

We are not trying to change the current profiling infrastructure.  We
are trying to enhance the existing event notification scheme to handle
more events.

> Have you looked into using the infrastructure in drivers/oprofile/ for
> this?  In other words: is it possible to augment the kernel's existing
> oprofile capabilities so they meet VTune requirements?

The current event notifications used by tools like Oprofile, while quite
useful, are not sufficient.  The additional event notifications we
propose can provide a more complete picture for performance tuning on
Linux, particularly for dynamically generated code (such as found in
Java).  
In addition to allowing for the enhancement of current performance
tools, it also enables creation of new tools to gather measurements that
were previously difficult to obtain (e.g., "image loads per second").

-juan

