Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751435AbWETA3F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751435AbWETA3F (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 May 2006 20:29:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751446AbWETA3F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 May 2006 20:29:05 -0400
Received: from ns2.g-housing.de ([81.169.133.75]:38600 "EHLO mail.g-house.de")
	by vger.kernel.org with ESMTP id S1751435AbWETA3E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 May 2006 20:29:04 -0400
Date: Sat, 20 May 2006 01:28:27 +0100 (BST)
From: Christian Kujau <evil@g-house.de>
X-X-Sender: dummy@vaio.testbed.de
To: Mel Gorman <mel@csn.ul.ie>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Andy Whitcroft <apw@shadowen.org>
Subject: Re: SCSI ABORT with 2.6.17-rc4-mm1
In-Reply-To: <20060519225746.GA11883@skynet.ie>
Message-ID: <Pine.NEB.4.64.0605200125140.4276@vaio.testbed.de>
References: <62331.192.18.1.5.1148071784.squirrel@housecafe.dyndns.org>
 <20060519141032.23de6eee.akpm@osdl.org> <20060519225746.GA11883@skynet.ie>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mel,

On Fri, 19 May 2006, Mel Gorman wrote:
> The warnings in this case is valid but I would think harmless.  ZONE_NORMAL
> on x86_64 begins at MAX_DMA32_PFN on the 4GiB boundary which is MAX_ORDER
> aligned. From the e820 map, I am guessing the machine has 1GiB of memory

yes, this (x86_64) box has 1GB of memory, non-ECC.

> I am struggling to see how the alignment patches or
> arch-independent-zone-sizing would clobber the mapping of the ACPI table :(

I'll try to disable ACPI in the next testing runs...

Thanks,
Christian.
-- 
"The combination of a number of things to make existence worthwhile."
"Yes, the philosophy of 'none,' meaning 'all.'"
 		-- Spock and Lincoln, "The Savage Curtain", stardate 5906.4
