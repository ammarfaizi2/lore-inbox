Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263066AbTDQFWt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 01:22:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263067AbTDQFWs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 01:22:48 -0400
Received: from k7g317-2.kam.afb.lu.se ([130.235.57.218]:45510 "EHLO
	cheetah.psv.nu") by vger.kernel.org with ESMTP id S263066AbTDQFWs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 01:22:48 -0400
Date: Thu, 17 Apr 2003 07:34:36 +0200 (CEST)
From: Peter Svensson <petersv@psv.nu>
To: Robert White <rwhite@casabyte.com>
cc: Brien <admin@brien.com>, <linux-kernel@vger.kernel.org>
Subject: RE: my dual channel DDR 400 RAM won't work on any linux distro
In-Reply-To: <PEEPIDHAKMCGHDBJLHKGCEMNCHAA.rwhite@casabyte.com>
Message-ID: <Pine.LNX.4.44.0304170727000.16313-100000@cheetah.psv.nu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Apr 2003, Robert White wrote:

> The BS layman's speak they gave me at the store was that they had seen a lot
> of cases where having "double sided SIMMs" (they were oh-so-usefully
> classifying the memory based on whether there were chips on just one side,
> or on both sides of the circuit card 8-) in the second and subsequent slots
> never worked.

This is actually a perfectly resonable thing to do. Twice the number of 
chips (and for double-sided modules with stacked chips four times) will 
load the address bus with twice (our four times) the capacitance. Thus the 
siganl flanks will become less and less well defined when adding more 
chips on the bus until some access patterns start to give bad results.

Some motherboards, mostly servers, specify registered memories that have a
buffer circuit to greatly reduce the load on the line drivers. More 
serious technical details from at least some motherboards will specify 
that only a maximum number of chip-loads are possible. Since there are 
only a few address bus driver chipsets the same limitations apply to most 
motherboards. The manefacturer can play some games with voltages and 
buffer strentghs but only so much. At high speeds and several stacked-chip 
modules you really need registered modules.

Peter
--
Peter Svensson      ! Pgp key available by finger, fingerprint:
<petersv@psv.nu>    ! 8A E9 20 98 C1 FF 43 E3  07 FD B9 0A 80 72 70 AF
------------------------------------------------------------------------
Remember, Luke, your source will be with you... always...


