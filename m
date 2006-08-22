Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751231AbWHVT1c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751231AbWHVT1c (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 15:27:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751206AbWHVT1b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 15:27:31 -0400
Received: from ns.suse.de ([195.135.220.2]:1974 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751242AbWHVT1a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 15:27:30 -0400
Date: Tue, 22 Aug 2006 12:27:28 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org, stable@kernel.org
Subject: Linux 2.6.17.10
Message-ID: <20060822192727.GA8579@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We (the -stable team) are announcing the release of the 2.6.17.10 kernel.

It contains three security fixes: one for SCTP, one for UDF filesystems,
and one that only can be triggered by a local root user.

I'll also be replying to this message with a copy of the patch between
2.6.17.9 and 2.6.17.10, as it is small enough to do so.

The updated 2.6.17.y git tree can be found at:
 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.17.y.git
and can be browsed at the normal kernel.org git web browser:
	www.kernel.org/git/

thanks,

greg k-h

--------

 Makefile                 |    2 -
 block/elevator.c         |    3 +-
 fs/udf/super.c           |    2 -
 fs/udf/truncate.c        |   64 ++++++++++++++++++++++++++++-------------------
 include/net/sctp/sctp.h  |   13 ---------
 include/net/sctp/sm.h    |    3 --
 net/sctp/sm_make_chunk.c |   30 ++++++----------------
 net/sctp/sm_statefuns.c  |   20 ++------------
 net/sctp/socket.c        |   10 ++++++-
 9 files changed, 66 insertions(+), 81 deletions(-)

Summary of changes from v2.6.17.9 to v2.6.17.10
===============================================

Greg Kroah-Hartman:
      Linux 2.6.17.10

Jan Kara:
      Fix possible UDF deadlock and memory corruption (CVE-2006-4145)

Oleg Nesterov:
      elv_unregister: fix possible crash on module unload

Sridhar Samudrala:
      Fix sctp privilege elevation (CVE-2006-3745)

