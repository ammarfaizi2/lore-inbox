Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750934AbWD0TKg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750934AbWD0TKg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 15:10:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751389AbWD0TKg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 15:10:36 -0400
Received: from usea-naimss1.unisys.com ([192.61.61.103]:26640 "EHLO
	usea-naimss1.unisys.com") by vger.kernel.org with ESMTP
	id S1750933AbWD0TKf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 15:10:35 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [(repost) git Patch 1/1] avoid IRQ0 ioapic pin collision
Date: Thu, 27 Apr 2006 14:10:30 -0500
Message-ID: <19D0D50E9B1D0A40A9F0323DBFA04ACC023B0B9F@USRV-EXCH4.na.uis.unisys.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [(repost) git Patch 1/1] avoid IRQ0 ioapic pin collision
Thread-Index: AcZpMSEVs1tnMAkRRMKEWo8DYGUTlwACHdnAADruSwAAAgyb4A==
From: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>
To: "Brown, Len" <len.brown@intel.com>, <sergio@sergiomb.no-ip.org>
Cc: "Kimball Murray" <kimball.murray@gmail.com>,
       <linux-kernel@vger.kernel.org>, <akpm@digeo.com>, <ak@suse.de>,
       <kmurray@redhat.com>, <linux-acpi@vger.kernel.org>
X-OriginalArrivalTime: 27 Apr 2006 19:10:31.0631 (UTC) FILETIME=[40E335F0:01C66A2E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> >There are probably better ways to control 224 possible IRQs by their 
> >total number instead of their range, and per-cpu IDTs are the better 
> >answer to the IRQ shortage altogether. But just going back 
> to the way 
> >it was wouldn't be right I think.
> >We were able to run 2 generations of
> >systems only because we had this compression, other big systems 
> >benefited from it as well.
> 
> I don't propose reverting the IRQ re-name patch and breaking 
> the big iron without replacing it with something else that works.

Len, maybe it sounds dramatic and/or extreme, but how about getting rid
of IRQs and just having GSI-vector pair.
I intuitively think that would be possible (not that I have all the
details lined up :)
And this would probably take away confusing IRQ abstraction out once and
for all? I think something like that is done in ia64.

--Natalie 
> 
> My point is that the re-name patch has added unnecessary 
> maintenance complexity to the 99.9% of systems that it runs 
> on.  We pay that price in several ways, including 
> mis-understandings about what devices are on what irqs, and 
> mis-understandings about how the code is supposed to work.
> 
> -Len
> 
