Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266980AbRGMVOj>; Fri, 13 Jul 2001 17:14:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267544AbRGMVOb>; Fri, 13 Jul 2001 17:14:31 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:42503 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S266982AbRGMVOW>; Fri, 13 Jul 2001 17:14:22 -0400
Subject: Re: [PATCH] 64 bit scsi read/write
To: adilger@turbolinux.com (Andreas Dilger)
Date: Fri, 13 Jul 2001 22:14:19 +0100 (BST)
Cc: acahalan@cs.uml.edu (Albert D. Cahalan), bcrl@redhat.com (Ben LaHaise),
        kernel@ragnark.vestdata.no (Ragnar Kjxrstad),
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mike@bigstorage.com, kevin@bigstorage.com, linux-lvm@sistina.com
In-Reply-To: <200107132041.f6DKfqM8013404@webber.adilger.int> from "Andreas Dilger" at Jul 13, 2001 02:41:52 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15LAGR-0000HX-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> RAID 5 throws a wrench into this by not guaranteeing that all of the
> blocks in a stripe are consistent (you don't know which blocks and/or
> parity were written and which not).  Ideally, you want a multi-stage
> commit for RAID as well, so that you write the data first, and the
> parity afterwards (so on reboot you trust the data first, and not the
> parity).  You have a problem if there is a bad disk and you crash.

Well to be honest so does most disk firmware. IDE especially. For one thing
the logical sector size the drives writes need not match the illusions
provided upstream, and the write flush commands are frequently not implemented
because they damage benchmarketing numbers from folks like Zdnet..


