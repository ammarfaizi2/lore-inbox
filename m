Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757641AbWKXJkP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757641AbWKXJkP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Nov 2006 04:40:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757631AbWKXJkP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Nov 2006 04:40:15 -0500
Received: from mx1.redhat.com ([66.187.233.31]:24283 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1757630AbWKXJkM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Nov 2006 04:40:12 -0500
Subject: [GFS2 & DLM] Pull request
From: Steven Whitehouse <swhiteho@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, cluster-devel@redhat.com
Content-Type: text/plain
Organization: Red Hat (UK) Ltd
Date: Fri, 24 Nov 2006 09:42:56 +0000
Message-Id: <1164361376.3392.148.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Please consider pulling the following GFS2 & DLM bug fixes. The DLM fixes have
all been very well tested and in addition have been in -mm for some time. The
GFS2 fixes are both trivial "one liners" and have also been in -mm for a little
while,

Steve.

The following changes since commit 1abbfb412b1610ec3a7ec0164108cee01191d9f5:
  Mel Gorman:
        x86_64: fix bad page state in process 'swapper'

are found in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/steve/gfs2-2.6-fixes.git

David Teigland:
      [DLM] res_recover_locks_count not reset when recover_locks is aborted
      [DLM] status messages ping-pong between unmounted nodes
      [DLM] fix requestqueue race
      [DLM] fix aborted recovery during node removal
      [DLM] fix stopping unstarted recovery
      [DLM] do full recover_locks barrier
      [DLM] clear sbflags on lock master

Steven Whitehouse:
      [GFS2] Fix Kconfig wrt CRC32
      [GFS2] Fix memory allocation in glock.c

 fs/dlm/lock.c         |   16 ++++++++++++----
 fs/dlm/member.c       |    8 ++++++++
 fs/dlm/rcom.c         |    7 ++++---
 fs/dlm/recover.c      |    1 +
 fs/dlm/recoverd.c     |   20 +++++++++++++++++++-
 fs/dlm/requestqueue.c |   21 +++++++++++++++++----
 fs/dlm/requestqueue.h |    2 +-
 fs/gfs2/Kconfig       |    1 +
 fs/gfs2/glock.c       |    2 +-
 9 files changed, 64 insertions(+), 14 deletions(-)


