Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266124AbUFEBF5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266124AbUFEBF5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 21:05:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264484AbUFEBF5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 21:05:57 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:35008 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S264482AbUFEBFy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 21:05:54 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: davidm@hpl.hp.com, David Mosberger <davidm@napali.hpl.hp.com>,
       Michael_E_Brown@dell.com
Subject: Re: EFI-support for SMBIOS driver
Date: Sat, 5 Jun 2004 03:09:36 +0200
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
References: <16577.6469.833064.763671@napali.hpl.hp.com>
In-Reply-To: <16577.6469.833064.763671@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200406050309.36397.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


It seems SMBIOS driver is gone.

http://linus.bkbits.net:8080/linux-2.5/cset@40b6702axansvQIxOVjTSIp7_DVoHA

On Saturday 05 of June 2004 02:52, David Mosberger wrote:
> Michael,
>
> The patch below adds EFI support to the SMBIOS driver.  Since EFI
> already knows the address of the SMBIOS, this avoids having to scan
> for the table.  It also enables use of the driver on ia64 machines.
> The patch also adds code to handle the case where the SMBIOS table
> resides in memory, which is the case at least for HP's zx1-based ia64
> machines.  If CONFIG_EFI is off, the resulting code should be
> unchanged (except for replacing a readb() loop into a
> memcpy_fromio()).
>
> One observation: I believe find_table_max_address() is missing some
> readb() calls (it's dereferencing ioremap'pped addresses directly).  I
> didn't try to fix that since I wasn't sure why it wasn't done in the
> first place.
>
> Do you have a test-program that's using /sys/firmware/smbios?
>
> If the patch looks OK, please apply.
>
> Thanks,
>
> 	--david

