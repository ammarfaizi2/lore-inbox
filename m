Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266352AbUFQBUh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266352AbUFQBUh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 21:20:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266353AbUFQBUc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 21:20:32 -0400
Received: from havoc.gtf.org ([216.162.42.101]:56546 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S266352AbUFQBUR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 21:20:17 -0400
Date: Wed, 16 Jun 2004 21:20:10 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Andrew Chew <achew@nvidia.com>, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org
Subject: Re: [PATCH 2.6.7] new NVIDIA libata SATA driver
Message-ID: <20040617012009.GA10879@havoc.gtf.org>
References: <DCB9B7AA2CAB7F418919D7B59EE45BAF043984B1@mail-sc-6-bk.nvidia.com> <200406170312.42324.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200406170312.42324.bzolnier@elka.pw.edu.pl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 17, 2004 at 03:12:42AM +0200, Bartlomiej Zolnierkiewicz wrote:
> Removing IDs from amd74xx.c is a bad idea,
> it breaks boot on systems already using these IDs.

(FWIW for Andrew)

I'm going to apply Andrew's patch, but without the PCI id removals.

Then, I'll apply a patch that adds Kconfig questions

	Include hardware that conflicts with libata SATA driver?
	(in drivers/ide)
and
	Include hardware that conflicts with IDE driver?
	(in libata, drivers/scsi)

and apply the associated ifdefs to the low-level drivers.

This is necessary to both enable conflict prevention, and also make sure
we don't break existing setups in the move to libata for SATA stuff.

	Jeff



