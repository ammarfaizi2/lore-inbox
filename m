Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261693AbUDNUnv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 16:43:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261689AbUDNUnv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 16:43:51 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:11143 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S261672AbUDNUno
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 16:43:44 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Meelis Roos <mroos@linux.ee>
Subject: Re: [2.4 IDE PATCH] SanDisk is flash (fwd)
Date: Wed, 14 Apr 2004 22:43:02 +0200
User-Agent: KMail/1.5.3
Cc: Adrian Bunk <bunk@fs.tum.de>, <linux-kernel@vger.kernel.org>,
       <linux-ide@vger.kernel.org>
References: <Pine.GSO.4.44.0404141115010.28974-100000@math.ut.ee>
In-Reply-To: <Pine.GSO.4.44.0404141115010.28974-100000@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200404142243.02599.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 14 of April 2004 10:31, Meelis Roos wrote:
> > Does this mean that CF test fail or that SunDisk is SanDisk now?
>
> Just that SunDisk is now SanDisk. The patch was developed in 2.4 to
> quieten flash disk detection messages. The important part was about host
> protected area detection that is already different in 2.6 (*). In
> addition, the name change was noticed and fixed. It resulted in
> different display (not ATA but CFA) and told the ide layer that the disk
> does not have door locking but I don't know whether it actually changes
> some important behaviour.

Ok, so this patch is indeed needed.

> (*) The host protected area fix for 2.4 was to do
> idedisk_read_native_max_address(drive) only when
> idedisk_supports_host_protected_area(drive) was true. By my quick look
> it seemed that 2.6 already does this check in init_idedisk_capacity()
> and 2.6 does not need the other patch - am I right here?

Yes.

Cheers,
Bartlomiej

