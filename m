Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266221AbUALSAl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 13:00:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266229AbUALSAk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 13:00:40 -0500
Received: from fmr06.intel.com ([134.134.136.7]:21718 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S266221AbUALSAi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 13:00:38 -0500
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: Re: /proc/kcore size
Date: Mon, 12 Jan 2004 10:00:19 -0800
Message-ID: <B8E391BBE9FE384DAA4C5C003888BE6F4FB05C@scsmsx401.sc.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Re: /proc/kcore size
Thread-Index: AcPZNfDNvDQ1gx/vR9WYiBbmR3V2bQ==
From: "Luck, Tony" <tony.luck@intel.com>
To: <linux-kernel@vger.kernel.org>
Cc: <jamagallon@able.es>
X-OriginalArrivalTime: 12 Jan 2004 18:00:30.0807 (UTC) FILETIME=[F7A95670:01C3D935]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Problem: it detects the memory amount in the box by stat'ing /proc/kcore.
> Thats not the problem, but that the box has 1Gb of memory, and kcore is just
> 896Mb big.

It may not be the specific problem that you have now, but it is a
problem in general.  The size of /proc/kcore may be a good
approximation for the amount of memory on machines that have
contiguous physical memory starting at a base physical address
of 0x0, but on an increasing number of machines it may give
a grossly inflated value (perhaps an SGI Altix user will post
the output from "ls -l /proc/kcore").

-Tony Luck  

