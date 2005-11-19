Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750852AbVKSVev@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750852AbVKSVev (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Nov 2005 16:34:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750853AbVKSVeu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Nov 2005 16:34:50 -0500
Received: from mail-in-05.arcor-online.net ([151.189.21.45]:18582 "EHLO
	mail-in-05.arcor-online.net") by vger.kernel.org with ESMTP
	id S1750852AbVKSVeu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Nov 2005 16:34:50 -0500
Date: Sat, 19 Nov 2005 22:35:32 +0100 (CET)
From: Bodo Eggert <7eggert@gmx.de>
To: Christoph Hellwig <hch@lst.de>
cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] add ->getgeo block device method
In-Reply-To: <5aHOV-3Fq-17@gated-at.bofh.it>
Message-ID: <Pine.LNX.4.58.0511192226510.2321@be1.lrz>
References: <5aHOV-3Fq-17@gated-at.bofh.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: 7eggert@web.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 19 Nov 2005, Christoph Hellwig wrote:

> HDIO_GETGEO is implemented in most block drivers, and all of them have
> to duplicate the code to copy the structure to userspace, aswell as
> getting the start sector.  This patch moves that to common code [1]
> and adds a ->getgeo method to fill out the raw kernel hd_geometry
> structure.  For many drivers this means ->ioctl can go away now.
> 
> [1] the s390 block drivers are odd in this respect.  xpram sets ->start
>     to 4 always which seems more than odd, and the dasd driver shifts
>     the start offset around, probably because of it's non-standard
>     sector size.

Shouldn't there be a field for the sector size, or is the 512 bytes size 
too hardcoded to fix so this field wouldn't matter?

-- 
Top 100 things you don't want the sysadmin to say:
68. Hmmm, curious...
