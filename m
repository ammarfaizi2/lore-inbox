Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262286AbUBXPua (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 10:50:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262289AbUBXPua
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 10:50:30 -0500
Received: from amdext.amd.com ([139.95.251.1]:5538 "EHLO amdext.amd.com")
	by vger.kernel.org with ESMTP id S262286AbUBXPuU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 10:50:20 -0500
Message-ID: <99F2150714F93F448942F9A9F112634C0FD384E3@txexmtae.amd.com>
From: richard.brunner@amd.com
To: linux-kernel@vger.kernel.org
Subject: RE: IOMMUs was Re: Intel vs AMD x86-64
Date: Tue, 24 Feb 2004 09:50:02 -0600
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
X-WSS-ID: 6C25AD134583306-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> -----Original Message-----
> From: Andi Kleen [mailto:ak@suse.de] 

 
> On Opteron the IOMMU code (ab)uses the built in AGPv3 GART in 
> the CPU, which 
> was originally intended for AGP. AMD converted it to be able 
> to remap PCI especially for Linux, which I think deserves applause.
> 
> It works surprisingly well even though it was not designed as 
> a real IOMMU. Of course one of the main advantages of a real 
> IOMMU - preventing arbitary memory corruption from broken 
> devices - is lost because the remapping table is just a hole 
> in the memory. I'm 
> secretly hoping that when there is more support for Linux at 
> chipset vendors they will someday add a bit to isolate all 
> traffic that doesn't go through the GART from the main 
> memory. This way you could get a much more reliable system 
> that can tolerate broken PCI devices at a moderate 
> performance penalty.

Andi is being modest. It was he and Andrea Arcangeli who convinced 
me we had a problem. We found a way to trick the AGP
GART hardware into helping, and then they turned it into a 
"real" solution and helped us work the warts out of the BIOS 
to enable it.

