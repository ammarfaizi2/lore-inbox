Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262268AbTJNJIP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 05:08:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262273AbTJNJIP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 05:08:15 -0400
Received: from dirac.phys.uwm.edu ([129.89.57.19]:36265 "EHLO
	dirac.phys.uwm.edu") by vger.kernel.org with ESMTP id S262268AbTJNJIM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 05:08:12 -0400
Date: Tue, 14 Oct 2003 04:08:09 -0500 (CDT)
From: Bruce Allen <ballen@gravity.phys.uwm.edu>
To: zipa24@suomi24.fi
cc: Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: SiI 3112 SATA problem with nForce2
In-Reply-To: <3F78555B0000EE1A@webmail-fi2.sol.no1.asap-asp.net>
Message-ID: <Pine.GSO.4.21.0310140402000.3234-100000@dirac.phys.uwm.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Has anyone tried to use SiI 3112 SATA controller (as in Asus A7N8X
> board) with Maxtor discs?
> 
> I'm using it with Maxtor 6Y160M0 and recent kernel (mostly 2.6.0-test5-mm4
> but I did try 2.6.0-test7, too) but I have problem if I torture with high
> I/O load the whole computer hangs. Sometimes it is as little has running
> "hdparm -t" on the disc but once I copied >50GB from /dev/zero to it
> without problems.

===cut

> smartctl output (the weird Error log entries happened during some of the
> hangs)

===cut

> 199 UDMA_CRC_Error_Count    0x0008   199   198   000    Old_age   Offline
>      -       3

This can be caused by cabling problems (CRC errors)

> When the command that caused the error occurred, the device was in an unknown
> state.
> 
>   After command completion occurred, registers were:
>   ER ST SC SN CL CH DH
>   -- -- -- -- -- -- --
>   84 51 00 dc ed 95 e0
===cut
 
>   Commands leading to the command that caused the error were:
>   CR FR SC SN CL CH DH DC   Timestamp  Command/Feature_Name
>   -- -- -- -- -- -- -- --   ---------  --------------------
>   25 00 08 dc ed 95 e0 00  120262.720  READ DMA EXT

The Error Register (ER) values 0x84=10000100 indicates a UDMA CRC error
and command abort.  Again, this *could* be a cabling problem.

Bruce

PS: please don't include kernel config files -- see lkml FAQ.

