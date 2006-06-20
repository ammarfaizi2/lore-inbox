Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932589AbWFTKzs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932589AbWFTKzs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 06:55:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932561AbWFTKzs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 06:55:48 -0400
Received: from mkedef1.rockwellautomation.com ([208.22.104.18]:6760 "EHLO
	ranasmtp01.ra.rockwell.com") by vger.kernel.org with ESMTP
	id S932589AbWFTKzr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 06:55:47 -0400
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, Russell King <rmk@arm.linux.org.uk>
Subject: Re: [PATCH] no_pci_serial
MIME-Version: 1.0
X-Mailer: Lotus Notes Release 5.0.12   February 13, 2003
Message-ID: <OF89471B99.99278420-ONC1257193.00377326-C1257193.0038013B@ra.rockwell.com>
From: Milan Svoboda <msvoboda@ra.rockwell.com>
Date: Tue, 20 Jun 2006 12:11:03 +0200
X-MIMETrack: Serialize by Router on RANASMTP01/NorthAmerica/RA/Rockwell(Release 6.5.4FP1|June
 19, 2005) at 06/20/2006 05:56:34 AM,
	Serialize complete at 06/20/2006 05:56:34 AM
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you for your reply.

I have created these patches (no_pci_serial and no_pci_mem) because I got 
some errors (missing ixp4xx_pci_write/read)
when I tried to compile kernel for ixp4xx without pci bus support. Now, I 
tried it again and got clean build. I think I had to forget
to do make clean before...

Milan Svoboda






Russell King <rmk+lkml@arm.linux.org.uk>
Sent by: Russell King <rmk@arm.linux.org.uk>
06/16/2006 09:31 PM

 
        To:     Milan Svoboda <msvoboda@ra.rockwell.com>
        cc:     linux-kernel@vger.kernel.org
        Subject:        Re: [PATCH] no_pci_serial


On Fri, Jun 16, 2006 at 03:21:08PM +0000, Milan Svoboda wrote:
> This patch allows to compile 8250 driver on systems without pci bus.

inb/outb/readb/writeb methods have nothing to do with the presence of
a PCI bus or not, so the patch is wrong - and it actually breaks a lot
of machine implementations which use this.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core



