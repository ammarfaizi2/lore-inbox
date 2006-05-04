Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751453AbWEDOzU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751453AbWEDOzU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 10:55:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751460AbWEDOzU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 10:55:20 -0400
Received: from dtp.xs4all.nl ([80.126.206.180]:15810 "HELO abra2.bitwizard.nl")
	by vger.kernel.org with SMTP id S1751453AbWEDOzT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 10:55:19 -0400
Date: Thu, 4 May 2006 16:55:17 +0200
From: Erik Mouw <erik@harddisk-recovery.com>
To: Yogesh Pahilwan <pahilwan.yogesh@spsoftindia.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Generic SATA driver which works with Marvell SATA
Message-ID: <20060504145517.GG16570@harddisk-recovery.com>
References: <20060504130822.GB16570@harddisk-recovery.com> <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAAvCUMqSY6jkeq1rIyy7sZ1cKAAAAQAAAAo6BlOIGRPESYDOrUYkqB1gEAAAAA@spsoftindia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAAvCUMqSY6jkeq1rIyy7sZ1cKAAAAQAAAAo6BlOIGRPESYDOrUYkqB1gEAAAAA@spsoftindia.com>
Organization: Harddisk-recovery.com
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

A: No.
Q: Should I leave quotations after my reply?

On Thu, May 04, 2006 at 07:33:45PM +0530, Yogesh Pahilwan wrote:
> Even I tried loading sd_mod scsi disk driver; I am not able to see any SATA
> disks.
> 
> When I cat /proc/scsi/scsi it shows:
>  
> Attached devices:
> 
> I believe there must be some low level driver for the SATA devices (eg:
> mv_sata for Marvel SATA) which allows sd_mod to expose them as a scsi
> devices?


Yes. Oh, you meant a Marvell SATA controller? That's quite different
from a SATA disk. Just use sata_mv.

> I need a generic SATA driver to be used as replace of (eg: mv_sata) driver.

There is no such thing. The only driver that comes close is the AHCI
driver, but that needs AHCI compatible hardware. In your case: use
sata_mv, it should work fine. If not, see below.

> Please suggest.

1) Upgrade to the latest kernel (2.6.16.13 or 2.6.17-git9)
2) Try to recreate your problem
3) If it persists, read REPORTING-BUGS in your kernel tree and send in
   a bug report to the appropriate mailing list (linux-ide will do).


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
