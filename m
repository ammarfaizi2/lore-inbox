Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752582AbWCQKiv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752582AbWCQKiv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 05:38:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752584AbWCQKiv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 05:38:51 -0500
Received: from hellhawk.shadowen.org ([80.68.90.175]:51723 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S1752582AbWCQKiu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 05:38:50 -0500
Message-ID: <441A91A5.3020607@shadowen.org>
Date: Fri, 17 Mar 2006 10:38:29 +0000
From: Andy Whitcroft <apw@shadowen.org>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Hansen <haveblue@us.ibm.com>
CC: linux-kernel@vger.kernel.org, akpm@osdl.org, ak@suse.de, gregkh@suse.de
Subject: Re: [PATCH] i386: run BIOS PCI detection before direct
References: <20060317000303.13252107@localhost.localdomain>
In-Reply-To: <20060317000303.13252107@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen wrote:
> from 2.6.16-rc3-mm1 through at least 2.6.16-rc6-mm1 a patch from
> Andi Kleen, titled
> 
>         x86_64-i386-pci-ordering.patch
> 
> which is now called:
> 
> 	gregkh-pci-pci-give-pci-config-access-initialization-a-defined-ordering.patch
> 
> has caused a 4-way PIII Xeon (non-NUMA) to stop detecting its SCSI
> card.  I believe this is also the issue keeping -mm from booting
> on "elm3b67" from http://test.kernel.org/. 
> 
> The following patch reverts the ordering of the PCI detection code
> to always run the BIOS initialization, first.  As far as I can
> tell, this was the original behavior, and it makes my machine boot
> again.
> 
> Signed-off-by: Dave Hansen <haveblue@us.ibm.com>

Ran this through the nightly regression suite on the affected machine
and it boots fine with this patch applied.

-apw
