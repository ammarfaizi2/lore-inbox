Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130380AbQKUNP1>; Tue, 21 Nov 2000 08:15:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130569AbQKUNPR>; Tue, 21 Nov 2000 08:15:17 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:33288 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S130380AbQKUNPH>; Tue, 21 Nov 2000 08:15:07 -0500
Date: Tue, 21 Nov 2000 13:44:59 +0100
From: Jan Kara <jack@suse.cz>
To: viro@math.psu.edu
Cc: linux-kernel@vger.kernel.org
Subject: Umount & quotas
Message-ID: <20001121134459.E2457@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hello.

  After rewrite of umount checks some time ago (just now reading your mail
I realized I never asked) filesystem doesn't umount when quotas are
turned on on it - it fails on check (atomic_read(&mnt->mnt_count) > 2)
in do_umount().
  Is this intended behaviour? If so, we can remove later DQUOT_OFF() call
and maybe make somewhere a note about changed behaviour otherwise we should fix
it...
later failed.
  Maybe we can ask quota (or get it from its structures) how many files it's
using and change the test to reflect this number... Do you agree with this?

					Bye
						Honza
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
