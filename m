Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932371AbWAZRYc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932371AbWAZRYc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 12:24:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932372AbWAZRYb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 12:24:31 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:42434 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932368AbWAZRYa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 12:24:30 -0500
Date: Thu, 26 Jan 2006 11:24:07 -0600
From: Mark Maule <maule@sgi.com>
To: "Miller, Mike (OS Dev)" <Mike.Miller@hp.com>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       linux-ia64@vger.kernel.org
Subject: Re: Problems with MSI-X on ia64
Message-ID: <20060126172407.GL17501@sgi.com>
References: <D4CFB69C345C394284E4B78B876C1CF10B848090@cceexc23.americas.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D4CFB69C345C394284E4B78B876C1CF10B848090@cceexc23.americas.cpqcorp.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I don't know what release added MSI to ia64, but as of 2.6.15 it was there.

I recently submitted a series of patches that abstract portions of the MSI
core so that it works on non-apic platforms, and did verify that MSI appeared
to be working on an hp zx1 system with the infiniband driver.

My patches have not made it to Linus yet, but they are present in the latest
gregkh trees, and I believe the latest 2.6.16 -mm tree.

Mark

On Thu, Jan 26, 2006 at 11:14:22AM -0600, Miller, Mike (OS Dev) wrote:
> Hello,
> Has anyone tested MSI-X on ia64 based platforms? We're using a 2.6.9
> variant and a cciss driver with MSI/MSI-X support. The kernel has MSI
> enabled. On ia64 the MSI-X table is all zeroes. On Intel x86_64
> platforms the table contains valid data and everything works as
> expected.
> 
> If I understand how this works the Linux kernel is supposed to program
> up the table based on the HW platform. I can't find anything in the ia64
> code that does this. For x86_64 and i386 it looks like the magic address
> is 
> 
> 	#define APIC_DEFAULT_BASE	0xfee00000
> 
> Anybody know why this isn't defined for ia64? Any answers, input, or
> flames are appreciated.
> 
> Thanks,
> mikem
> -
> To unsubscribe from this list: send the line "unsubscribe linux-ia64" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
