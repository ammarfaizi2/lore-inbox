Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316861AbSFQJc6>; Mon, 17 Jun 2002 05:32:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316863AbSFQJc5>; Mon, 17 Jun 2002 05:32:57 -0400
Received: from pa91.banino.sdi.tpnet.pl ([213.76.211.91]:62981 "EHLO
	alf.amelek.gda.pl") by vger.kernel.org with ESMTP
	id <S316861AbSFQJc5>; Mon, 17 Jun 2002 05:32:57 -0400
Subject: "laptop mode" for floppies too?
To: akpm@zip.com.au
Date: Mon, 17 Jun 2002 11:32:48 +0200 (CEST)
CC: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL95 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Message-Id: <E17JssS-0006aL-00@alf.amelek.gda.pl>
From: Marek Michalkiewicz <marekm@amelek.gda.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've just read (in Kernel Traffic - don't have enough time to follow
linux-kernel directly...) about your proposed "laptop mode" patch
(basically writing all dirty blocks to disk after it spins up - looks
like a good idea to me).  Similar problem exists with floppies (also
in desktop PCs) - it takes a while to spin up, so I think it would
make sense to write all dirty blocks just before spinning down, so
that the drive is less likely to spin up again soon.

So it would be nice to have more general support for this feature in
the block device layer (not limited to IDE devices).  Is anyone working
on something like that (for 2.5)?

As a nice side effect, removing a floppy while mounted but not spinning
would be a little less dangerous (still a bad idea of course, but might
happen by accident...) - the filesystem is more likely to be in some
consistent state, not in the middle of a write operation...

Thanks,
Marek

