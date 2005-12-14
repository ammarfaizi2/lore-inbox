Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030376AbVLNA0A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030376AbVLNA0A (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 19:26:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932629AbVLNA0A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 19:26:00 -0500
Received: from fmr24.intel.com ([143.183.121.16]:15026 "EHLO
	scsfmr004.sc.intel.com") by vger.kernel.org with ESMTP
	id S932625AbVLNAZ7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 19:25:59 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: [patch 2/2] /dev/mem validate mmap requests
Date: Tue, 13 Dec 2005 16:25:50 -0800
Message-ID: <B8E391BBE9FE384DAA4C5C003888BE6F0531E4BB@scsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [patch 2/2] /dev/mem validate mmap requests
Thread-Index: AcYAQNnERyPXZsBBQyuMJYH+MOqxKQAAkXtQ
From: "Luck, Tony" <tony.luck@intel.com>
To: "Bjorn Helgaas" <bjorn.helgaas@hp.com>, <linux-kernel@vger.kernel.org>,
       "Andrew Morton" <akpm@osdl.org>
Cc: <linux-ia64@vger.kernel.org>
X-OriginalArrivalTime: 14 Dec 2005 00:25:51.0565 (UTC) FILETIME=[F047C7D0:01C60044]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Tony, can you ack/nak this please?  It touches both ia64 and generic
> code.

So if someone tries to mmap a range that spans across more than
one EFI memory descriptor, the size will get trimmed back to an
EFI memory boundary.  Isn't that a problem since 1<<EFI_PAGE_SHIFT
is less than the default ia64 Linux page size?

I think you may need a more complex checker that does aggregation
of adjacent efi memory descriptors with the same attributes.

-Tony
