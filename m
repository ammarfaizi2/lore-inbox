Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129267AbRAEMbV>; Fri, 5 Jan 2001 07:31:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129523AbRAEMbA>; Fri, 5 Jan 2001 07:31:00 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:21004 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S129267AbRAEMau>; Fri, 5 Jan 2001 07:30:50 -0500
Date: Fri, 5 Jan 2001 13:30:45 +0100
From: Jan Kara <jack@suse.cz>
To: linux-kernel@vger.kernel.org
Cc: flx@msu.ru, alan@redhat.com
Subject: Update of quota patches
Message-ID: <20010105133045.A30949@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hello.

  So I've updated my quota patches for 2.4.0-prerelease. I also
fixed one locking bug in implementation of new quotafile format
and added a few comments. I also fixed compilation problems
(when quota was disabled) - Alan, were there any problems
I didn't fix (I've seen you and someone else were fixing some
compilation problems with my patches in -ac but I've seen
no mail about it (maybe I just missed it))?

  The patches can be downloaded from:
ftp://atrey.karlin.mff.cuni.cz/pub/local/jack/quota/v2.4/

as quota-fix-2.4.0-pre-1.diff and quota-patch-2.4.0-pre-1.diff.

Contents of patches:

quota-fix: This patch mainly fixes bugs in current quota code:
  * races between preallocation and chgrp/chown fixed
  * cleaned up locking
  * quotas are dynamically allocated (so there are no more 'No free dquots' messages)

quota-patch: This patch implements new quotafile format. It allows:
  * accounting of quota in bytes
  * 32-bit UIDs/GIDs
  * root is no longer special user

Note that you will need new quota utilities for new quotafile format (you can
download them at ftp://atrey.karlin.mff.cuni.cz/pub/local/jack/quota/utils/quota-3.00-4.tar.gz).

Also note that quota-patch requires quota-fix to be already applied.

							Honza
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
