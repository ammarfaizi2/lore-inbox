Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266591AbUFWRgS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266591AbUFWRgS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 13:36:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266593AbUFWRgS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 13:36:18 -0400
Received: from sweetums.bluetronic.net ([24.199.150.42]:58499 "EHLO
	sweetums.bluetronic.net") by vger.kernel.org with ESMTP
	id S266591AbUFWRgR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 13:36:17 -0400
Date: Wed, 23 Jun 2004 13:30:12 -0400 (EDT)
From: Ricky Beam <jfbeam@bluetronic.net>
To: George Georgalis <george@galis.org>
cc: Linux Kernel Mail List <linux-kernel@vger.kernel.org>
Subject: Re: SIIMAGE sata fails with 2.6.7
In-Reply-To: <20040623163505.GA1068@trot.local>
Message-ID: <Pine.GSO.4.33.0406231327060.25702-100000@sweetums.bluetronic.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Jun 2004, George Georgalis wrote:
>Oooh, guess I needed to mount as a scsi dev now? but I don't see any
>scsi devices available... must I first not mount the hdc partitions?

Don't compile in the SIIMAGE driver.  The IDE drivers are probed before
SCSI, so it'll assume control of the chip and sata_sil will never get
a chance.

And you'll need a current bitkeeper snapshot (or -bk# tarball made after
6/22) to have the sata_sil Seagate drive fix.

--Ricky


