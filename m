Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750882AbWD0SOO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750882AbWD0SOO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 14:14:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965135AbWD0SOO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 14:14:14 -0400
Received: from mga02.intel.com ([134.134.136.20]:8367 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S1750882AbWD0SON convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 14:14:13 -0400
X-IronPort-AV: i="4.04,161,1144047600"; 
   d="scan'208"; a="28634225:sNHT53404939"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [(repost) git Patch 1/1] avoid IRQ0 ioapic pin collision
Date: Thu, 27 Apr 2006 14:13:59 -0400
Message-ID: <CFF307C98FEABE47A452B27C06B85BB64A3EAB@hdsmsx411.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [(repost) git Patch 1/1] avoid IRQ0 ioapic pin collision
Thread-Index: AcZpMSEVs1tnMAkRRMKEWo8DYGUTlwACHdnAADruSwA=
From: "Brown, Len" <len.brown@intel.com>
To: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>,
       <sergio@sergiomb.no-ip.org>
Cc: "Kimball Murray" <kimball.murray@gmail.com>,
       <linux-kernel@vger.kernel.org>, <akpm@digeo.com>, <ak@suse.de>,
       <kmurray@redhat.com>, <linux-acpi@vger.kernel.org>
X-OriginalArrivalTime: 27 Apr 2006 18:13:59.0180 (UTC) FILETIME=[5AD444C0:01C66A26]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>There are probably better ways to control 224 possible IRQs by their
>total number instead of their range, and per-cpu IDTs are the better
>answer to the IRQ shortage altogether. But just going back to 
>the way it was wouldn't be right I think.
>We were able to run 2 generations of
>systems only because we had this compression, other big systems
>benefited from it as well.

I don't propose reverting the IRQ re-name patch and breaking the
big iron without replacing it with something else that works.

My point is that the re-name patch has added unnecessary maintenance
complexity to the 99.9% of systems that it runs on.  We pay that price
in several ways, including mis-understandings about what devices
are on what irqs, and mis-understandings about how the code is
supposed to work.

-Len
