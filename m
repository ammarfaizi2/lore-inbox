Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269450AbTGOSqy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 14:46:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269514AbTGOSqy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 14:46:54 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:6305 "EHLO
	mtvmime03.VERITAS.COM") by vger.kernel.org with ESMTP
	id S269450AbTGOSqA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 14:46:00 -0400
Date: Tue, 15 Jul 2003 20:02:17 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: "Brown, Len" <len.brown@intel.com>
cc: "Grover, Andrew" <andrew.grover@intel.com>,
       ACPI-Devel mailing list <acpi-devel@lists.sourceforge.net>,
       <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: RE: ACPI patches updated (20030714)
In-Reply-To: <A5974D8E5F98D511BB910002A50A66470B981250@hdsmsx103.hd.intel.com>
Message-ID: <Pine.LNX.4.44.0307151953560.1161-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Jul 2003, Brown, Len wrote:
> > What's the schedule for Len's rework to Marcelo?
> 
> I'm testing today and expect to push via Andy
> (http://linux-acpi.bkbits.net/to-andy-2.4)  when when I'm satisifed I
> haven't toasted anything -- probably Wednesday. 

Oh, thanks, that sounds very good, much the best if I don't interfere.
Three comments below.

> 		!ACPI && ACPI_HT_ONLY
> 			Minimal kernel to enable HT -- no ACPI
> 			acpi=cpu is the default behaviour here
> 			if somebody wants to disable ht, they can use "noht"
> 			This matches RHL's 2.4 distribution
> 
> 		ACPI && !ACPI_HT_ONLY
> 			Full ACPI w/o the acpi=cpu option
> 			Maybe OSD's will get here some day

Shouldn't this combination also support "noht", or is that too much to ask?

> acpismp=force
> 	TODO: Delete.

Hurrah!

> noht
> 	Keep
> 	TODO: fix
> 	Disable HT for benefit of systems which perform better with HT
> disabled, but
> 	have a BIOS incapable of disabling HT.
> 	currently broken in 2.5

And it's currently broken in 2.4 also.

Thanks,
Hugh

