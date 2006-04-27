Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965070AbWD0T0x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965070AbWD0T0x (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 15:26:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965072AbWD0T0x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 15:26:53 -0400
Received: from usea-naimss3.unisys.com ([192.61.61.105]:3332 "EHLO
	usea-naimss3.unisys.com") by vger.kernel.org with ESMTP
	id S965060AbWD0T0w convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 15:26:52 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [(repost) git Patch 1/1] avoid IRQ0 ioapic pin collision
Date: Thu, 27 Apr 2006 14:26:47 -0500
Message-ID: <19D0D50E9B1D0A40A9F0323DBFA04ACC023B0BA0@USRV-EXCH4.na.uis.unisys.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [(repost) git Patch 1/1] avoid IRQ0 ioapic pin collision
Thread-Index: AcZqLrPZ8liuU3IFQUy6mho67jNQ9QAADEBQ
From: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>
To: "Andi Kleen" <ak@suse.de>
Cc: "Brown, Len" <len.brown@intel.com>, <sergio@sergiomb.no-ip.org>,
       "Kimball Murray" <kimball.murray@gmail.com>,
       <linux-kernel@vger.kernel.org>, <akpm@digeo.com>, <kmurray@redhat.com>,
       <linux-acpi@vger.kernel.org>
X-OriginalArrivalTime: 27 Apr 2006 19:26:48.0400 (UTC) FILETIME=[87165500:01C66A30]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Len, maybe it sounds dramatic and/or extreme, but how about getting 
> > rid of IRQs and just having GSI-vector pair.
> > I intuitively think that would be possible (not that I have all the 
> > details lined up :) And this would probably take away confusing IRQ 
> > abstraction out once and for all? I think something like 
> that is done 
> > in ia64.
> 
> x86 users are attached to their interrupt numbers I think 
> back from the bad old days with only 16 interrupts and 
> interrupt sharing didn't work. We might have a revolt in the 
> user base if /proc/interrupts didn't display them anymore @)
> 
> But I guess using GSI/vector internally only would be fine.
> 
Oh I completely agree there are probably few strings attached that have
to be mimicked and kept (especially those 16), but I think that can be
done.
It feels like not a small change to me, but would probably be
worthwhile. It is such a boring thing trying to fit new chipsets and
system dimensions into old inflexible format...

--Natalie
