Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130420AbQLURiv>; Thu, 21 Dec 2000 12:38:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130510AbQLURik>; Thu, 21 Dec 2000 12:38:40 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:17416 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S130420AbQLURib>; Thu, 21 Dec 2000 12:38:31 -0500
Date: Thu, 21 Dec 2000 18:07:58 +0100
From: Jan Kara <jack@suse.cz>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Quota patches for test12
Message-ID: <20001221180758.A2673@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>   I've ported my quota patches for 2.4.0-test12.
> You can download the patches from
> ftp://atrey.karlin.mff.cuni.cz/pub/local/jack/quota/v2.4/
> quota-fix-2.4.0-test12-1.diff.gz
> and
> quota-patch-2.4.0-test12-1.diff.gz
  Sorry to follow up myself. I had better tell what those patches do :-):

quota-fix patch fixes some bugs in quota code -
  fixes race between ext2 preallocation and chgrp (might be exploitable)
  fixes race in writing of message to console (some messages might be lost)
  make allocation of quota structures in memory fully dynamic (no more "No free dquots" messages)

quota-patch patch implements new quotafile format. It allows
  quota for 32-bit UID/GID
  root is no more special user
  allows counting of disk quota in bytes (used currently only in ReiserFS)

Note that to apply quota-patch you need to apply quota-fix first. Also you
need to download new version of quota utilities if you want to use new quotafile
format (ftp://atrey.karlin.mff.cuni.cz/pub/local/jack/quota/utils/quota-3.00-4.tar.gz).

If you apply quota-patch you will be able to use quota support in ReiserFS (you
need also to apply quota patch for ReiserFS which should be available for test12 at their ftp
soon).

									Honza
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
