Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263737AbUC3Pnk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 10:43:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263736AbUC3Pnk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 10:43:40 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:56298 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S263732AbUC3Pnd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 10:43:33 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Geert Uytterhoeven <geert@linux-m68k.org>,
       =?iso-8859-1?q?Andr=E9=20Hedrick?= <andre@linux-ide.org>
Subject: Re: [PATCH] Bogus LBA48 drives
Date: Tue, 30 Mar 2004 17:51:36 +0200
User-Agent: KMail/1.5.3
Cc: Lionel Bergeret <lbergeret@swing.be>, JunHyeok Heo <jhheo@idis.co.kr>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       linux-ide@vger.kernel.org
References: <Pine.GSO.4.58.0403301654300.9765@waterleaf.sonytel.be>
In-Reply-To: <Pine.GSO.4.58.0403301654300.9765@waterleaf.sonytel.be>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403301751.36892.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 30 of March 2004 17:22, Geert Uytterhoeven wrote:
> Apparently some IDE drives (e.g. a pile of 80 GB ST380020ACE drives I have
> access to) advertise to support LBA48, but don't, causing kernels that
> support LBA48 (i.e. anything newer than 2.4.18, including 2.4.25 and 2.6.4)
> to fail on them.  Older kernels (including 2.2.20 on the Debian woody CDs)
> work fine.
>
> One problem with those drives is that the lba_capacity_2 field in their
> drive identification is set to 0, making the IDE driver think the disk is 0
> bytes large. At first I tried modifying the driver to use lba_capacity if
> lba_capacity_2 is set to 0, but this caused disk errors. So it looks like
> those drives don't support the increased transfer size of LBA48 neither.

I think somebody should make Seagate aware of the issue.

> I added a workaround for these drives to both 2.4.25 and 2.6.4. I'll send
> patches in follow-up emails.

They look okay but some comment about this issue would be useful.

Thanks,
Bartlomiej

