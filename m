Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264366AbTLETNA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 14:13:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264367AbTLETNA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 14:13:00 -0500
Received: from hqemgate00.nvidia.com ([216.228.112.144]:48133 "EHLO
	hqemgate00.nvidia.com") by vger.kernel.org with ESMTP
	id S264366AbTLETM6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 14:12:58 -0500
Message-ID: <DCB9B7AA2CAB7F418919D7B59EE45BAF49F877@mail-sc-6.nvidia.com>
From: Allen Martin <AMartin@nvidia.com>
To: "'Mikael Pettersson'" <mikpe@csd.uu.se>,
       Josh McKinney <forming@charter.net>
Cc: linux-kernel@vger.kernel.org
Subject: RE: Catching NForce2 lockup with NMI watchdog
Date: Fri, 5 Dec 2003 11:11:39 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Mikael Pettersson [mailto:mikpe@csd.uu.se] 
> Sent: Friday, December 05, 2003 4:15 AM
>
>  > So does this confirm that the lockups with nforce2 
> chipsets and apic
>  > is actually a hardware problem after all? 
> 
> Confirm with very high probability. There may be quirks in nVidia's
> chipset that we (unlike their Windoze drivers) don't know about.
> 
> Ask nVidia for detailed chipset documentation. Then maybe we 
> can fix this.

NVIDIA doesn't provide a windows driver to setup APIC interrupts.  APIC
functionality is exported through the ACPI methods and MP table in the
system BIOS which the motherboard vendors supply.

Likely the root of the problem has to do with the way the Linux kernel is
using the ACPI methods to setup the interrupts which is different from win
9x/2k/XP.  I can help track this down, unfortunately so far I've been unable
to reproduce the hangs on any of the boards I have.

-Allen
