Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270765AbTHJXYX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 19:24:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270767AbTHJXYX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 19:24:23 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:56787 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S270765AbTHJXYV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 19:24:21 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Andre Hedrick <andre@linux-ide.org>
Subject: Re: [PATCH] kill HDIO_GETGEO_BIG_RAW ioctl
Date: Mon, 11 Aug 2003 01:24:48 +0200
User-Agent: KMail/1.5
References: <Pine.LNX.4.10.10308101327590.12816-100000@master.linux-ide.org>
In-Reply-To: <Pine.LNX.4.10.10308101327590.12816-100000@master.linux-ide.org>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308110124.48723.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 10 of August 2003 22:29, you wrote:
> Besure to force all devices to LBA only because wrapping the cylinder
> count tends to make a mess.
>
> Cheers,
>
> --a

Ahhh... you mean not doing set_geometry() for LBA disks (we currently don't
do it only for LBA-48 disks) because for large disks the cylinder count wraps
and its not a nice thing, right?

cheers,

--bartlomiej

