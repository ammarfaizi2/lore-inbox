Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132251AbRCZAGk>; Sun, 25 Mar 2001 19:06:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132253AbRCZAGb>; Sun, 25 Mar 2001 19:06:31 -0500
Received: from mako.theneteffect.com ([63.97.58.10]:9491 "EHLO
	mako.theneteffect.com") by vger.kernel.org with ESMTP
	id <S132251AbRCZAGT>; Sun, 25 Mar 2001 19:06:19 -0500
From: Mitch Adair <mitch@theneteffect.com>
Message-Id: <200103260005.SAA30529@mako.theneteffect.com>
Subject: Re: NCR53c8xx driver and multiple controllers...(not new prob)
To: law@sgi.com (LA Walsh)
Date: Sun, 25 Mar 2001 18:05:14 -0600 (CST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3ABE71B9.9FAA232B@sgi.com> from "LA Walsh" at Mar 25, 2001 02:31:21 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Here is the 'alternate' output when the ncr53c8xx driver is
> compiled in:
> 
> SCSI subsystem driver Revision: 1.00
> scsi-ncr53c7,8xx: at PCI bus 0, device 8, function 0
> scsi-ncr53c7,8xx: warning : revision of 35 is greater than 2.
> scsi-ncr53c7,8xx: NCR53c810 at memory 0xfa101000, io 0x2000, irq 58
> scsi0: burst length 16
> scsi0: NCR code relocated to 0x37d6c610 (virt 0xf7d6c610)
> scsi0: test 1 started
> scsi0: NCR53c{7,8}xx (rel 17)
> request_module[block-major-8]: Root fs not mounted
> VFS: Cannot open root device "807" or 08:07
> Please append a correct "root=" boot option
> Kernel panic: VFS: Unable to mount root fs on 08:07
> -----

I don't believe that's the ncr53c8xx driver.  That looks like the
53c7,8xx driver.  I don't think it's really maintained any more, or
frankly that it could ever handle a 53c896 card, which could explain
it only seeing the 810a and not the 896 your boot disk is on.

You really want to use the sym53c8xx driver anyway - it is the one
being worked on in earnest now.  I believe it will pick up 810a
controllers as well.

(yes that's three ncr/symbios/lsi drivers in the kernel - "53c7,8xx",
"ncr53c8xx" and "sym53c8xx" ...)

	M
