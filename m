Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267201AbUBMUhW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 15:37:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267210AbUBMUhK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 15:37:10 -0500
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:10112 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S267201AbUBMUfc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 15:35:32 -0500
Date: Fri, 13 Feb 2004 20:44:45 GMT
From: John Bradford <john@grabjohn.com>
Message-Id: <200402132044.i1DKij8w000466@81-2-122-30.bradfords.org.uk>
To: Linus Torvalds <torvalds@osdl.org>,
       "Eric D. Mudama" <edmudama@mail.bounceswoosh.org>
Cc: Willy Tarreau <willy@w.ods.org>, Timothy Miller <miller@techsource.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0402131146040.2144@home.osdl.org>
References: <402C0D0F.6090203@techsource.com>
 <20040213055350.GG29363@alpha.home.local>
 <20040213193046.GA17790@bounceswoosh.org>
 <Pine.LNX.4.58.0402131146040.2144@home.osdl.org>
Subject: Re: File system performance, hardware performance, ext3, 3ware RAID1, etc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> And the software-visible 512-byte blocking factor just has to be
> _incredibly_ painful on a hardware level, and I'd be surprised if there
> aren't disks out there already where the actual real physical block-size
> is bigger. Which means that I would expect a lot of drives to internally
> do read-modify-write cycles for small writes.
> 
> And especially in a market where density is often more important than pure
> speed, I'd expect hw manufacturers to have a _huge_ bias towards big
> blocks on the platter, in order to avoid having to have lots of
> inter-sector gaps etc.

Since drives don't generally do defect re-allocation on read, only on
write, large blocks at the hardware level cause difficulties with
defect management, so hardware 512 byte sectors are still common :-(.

John.
