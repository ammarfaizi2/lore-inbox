Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265061AbUBOPxO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Feb 2004 10:53:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265062AbUBOPxO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Feb 2004 10:53:14 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:25841 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S265061AbUBOPxD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Feb 2004 10:53:03 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: chip@pobox.com (Chip Salzenberg)
Subject: Re: Linux 2.6.3-rc3 - missing IDE hunk from bk4; good or bad?
Date: Sun, 15 Feb 2004 16:58:57 +0100
User-Agent: KMail/1.5.3
References: <E1AsO6X-0003hW-1u@tytlal>
In-Reply-To: <E1AsO6X-0003hW-1u@tytlal>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402151658.57710.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Bad.

On Sunday 15 of February 2004 16:22, Chip Salzenberg wrote:
> Linus writes:
> >More merges, although most of them are architecture updates. IA64,
> >ppc32/64, SuperH and ARM.
>
> One non-arch difference between rc3 and bk4 seems to involve IDE DMA.

There are no IDE DMA related changes (except build fix) between rc3 and bk4.

> When I ran briefly ran bk4 I got a few IDE DMA errors (ThinkPad A30,
> TOSHIBA MK8025GAS).  Makes one wonder.  Thus:

Please send dmesg command output and your config kernel config
if you want anybody to look at IDE problems...

> Is the IDE patch in bk4 (that's missing from rc3) going to be in
> 2.6.3?  Does it only come into play with SCSI, as it seems to, or
> does it affect a non-SCSI setup?

This was in SATA libata driver and was reverted because caused problems.
[ libata is independent of IDE drivers from linux/drivers/ide/ ]

If you don't use libata this chunk shouldn't affect you.

Cheers,
--bart

