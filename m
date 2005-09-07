Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932106AbVIGKsJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932106AbVIGKsJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 06:48:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932108AbVIGKsJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 06:48:09 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:16547 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S932106AbVIGKsI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 06:48:08 -0400
Date: Wed, 7 Sep 2005 11:47:30 +0100 (IST)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [git pull] drm fixes tree
Message-ID: <Pine.LNX.4.58.0509071050320.8480@skynet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Linus,
	Can you pull the drm-fixes branch from

rsync://rsync.kernel.org/pub/scm/linux/kernel/git/airlied/drm-2.6.git

It's got some fixes and minor cleanups ... Andrew I'm bypassing -mm as
these are needed in mainline...

 drivers/char/drm/drm_bufs.c    |   66 ++++++++++++++++++++---------------------
 drivers/char/drm/drm_context.c |    2 -
 drivers/char/drm/drm_sysfs.c   |    1
 drivers/char/drm/mga_dma.c     |   14 ++++++--
 4 files changed, 46 insertions(+), 37 deletions(-)


commit 908f9c485042e516bb3749f4361129a94772fe26
Author: Dave Airlie <airlied@starflyer.(none)>
Date:   Mon Sep 5 21:51:30 2005 +1000

    drm: fix MGA on non AGP systems

    Al Viro noticed that MGA wouldn't build on non AGP systems.

    Signed-off-by: Dave Airlie <airlied@linux.ie>

commit f210973bb6d17aa220c797e8ea23d127d96859b7
Author: Dave Airlie <airlied@starflyer.(none)>
Date:   Mon Sep 5 21:33:44 2005 +1000

    drm: small cleanups

    This patch contains the following small cleanups:
    - make two needlessly global functions static
    - drm_sysfs.c: every file should #include the header with the prototypes
                  of the global functions it is offering

    Signed-off-by: Adrian Bunk <bunk@stusta.de>
    Signed-off-by: Dave Airlie <airlied@linux.ie>

commit 89625eb186b9b0b9454d44126f8b1bcc72ad93b7
Author: Dave Airlie <airlied@starflyer.(none)>
Date:   Mon Sep 5 21:23:23 2005 +1000

    drm: fix issue with handle lookup for a 0 handle

    On 32-bit PPC a 0 handle is valid for AGP space, the 32/64 lookup
    doesn't handle 0 correctly.

    From: Ben Herrenschmidt <benh@kernel.crashing.org> and Paul Mackerras <paulus@samba.org>
    Signed-off-by: Dave Airlie <airlied@linux.ie>


