Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261459AbVEXJMP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261459AbVEXJMP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 05:12:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261510AbVEXJMO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 05:12:14 -0400
Received: from smtp.nexlab.net ([213.173.188.110]:41654 "EHLO smtp.nexlab.net")
	by vger.kernel.org with ESMTP id S261459AbVEXJK3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 05:10:29 -0400
X-Postfix-Filter: PDFilter By Nexlab, Version 0.1 on mail01.nexlab.net
X-Virus-Checker-Version: clamassassin 1.2.1 with ClamAV 0.83/893/Tue May 24
	08:27:20 2005 signatures 31.893
Message-Id: <20050524091025.C96F6FA29@smtp.nexlab.net>
Date: Tue, 24 May 2005 11:10:25 +0200 (CEST)
From: root@smtp.nexlab.net
To: undisclosed-recipients:;
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	by smtp.nexlab.net (Postfix) with ESMTP id 0E929FB77

	for <chiakotay@nexlab.it>; Tue, 24 May 2005 10:01:48 +0200 (CEST)

Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand

	id S261331AbVEXGbe (ORCPT <rfc822;chiakotay@nexlab.it>);

	Tue, 24 May 2005 02:31:34 -0400

Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261321AbVEXGbe

	(ORCPT <rfc822;linux-kernel-outgoing>);

	Tue, 24 May 2005 02:31:34 -0400

Received: from sccrmhc14.comcast.net ([204.127.202.59]:54738 "EHLO

	sccrmhc14.comcast.net") by vger.kernel.org with ESMTP

	id S261331AbVEXGbY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);

	Tue, 24 May 2005 02:31:24 -0400

Received: from [192.168.111.3] (c-24-6-245-209.hsd1.ca.comcast.net[24.6.245.209])

          by comcast.net (sccrmhc14) with SMTP

          id <2005052406281001400i8unfe>; Tue, 24 May 2005 06:31:24 +0000

Subject: Re: promise sx8 sata driver

From: Kallol Biswas <kallol@nucleodyne.com>
Reply-To: kallol@nucleodyne.com
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Chris Haumesser <chris@mail-test.us>,
	linux-kernel@vger.kernel.org
In-Reply-To: <42925F7F.2000809@pobox.com>

References: <42924E38.7070003@mail-test.us>  <42925F7F.2000809@pobox.com>

Content-Type: text/plain

Organization: NucleoDyne Systems Inc.

Message-Id: <1116909972.15027.3.camel@driver>

Mime-Version: 1.0

X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 

Date:	23 May 2005 23:16:03 -0700

Content-Transfer-Encoding: 7bit

Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk

X-Mailing-List:	linux-kernel@vger.kernel.org



How good is 2.6.6 carmel.c driver for sx8 adapters? Does it support
the promise adapter? Why have you developed sx8.c?
 

On Mon, 2005-05-23 at 15:55, Jeff Garzik wrote:
> Chris Haumesser wrote:
> > The sx8 driver does not use libata, and it is a separate block device,
> > outside of the scsi and ata hierarchies.  If I compile the driver into
> > my kernel, I end up with /dev/sx8/0 and /dev/sx8/0p1, etc.  However, no
> > scsi disk devices are created, and grub does not recognize that
> > /dev/sx8/ devices are disks.  There's no indication in /proc/scsi/ that
> > they are being registered with the scsi subsystem; this is clearly
> > different from every other sata controller I've used.  I've been
> > googling this for days, with no real luck.  I have found changelogs for
> > grub that suggest that my version (0.95) should support booting from the
> > sx8.
> 
> sx8 is a separate block driver, and has nothing whatsoever to do with scsi.
> 
> 
> > So my question is, how does one use this driver for sata disks?  Is my
> > problem a grub problem, or does it have something to do with the fact
> 
> a grub problem
> 
> 
> > What is the relationship between the promise driver and the one included
> > in the kernel?  Why does one work differently from the other?  Is there
> 
> Promise SX8 provides neither an ATA nor SCSI interface to the developer, 
> so its not written as an ATA or SCSI driver.
> 
> 	Jeff
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

