Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261733AbULGCYd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261733AbULGCYd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 21:24:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261734AbULGCYc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 21:24:32 -0500
Received: from smtp-relay.dca.net ([216.158.48.66]:36517 "EHLO
	smtp-relay.dca.net") by vger.kernel.org with ESMTP id S261733AbULGCYa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 21:24:30 -0500
Date: Mon, 6 Dec 2004 21:24:29 -0500
From: "Mark M. Hoffman" <mhoffman@lightlink.com>
To: LKML <linux-kernel@vger.kernel.org>
Subject: make -j4 gets stuck w/ ccache over NFS
Message-ID: <20041207022429.GA5295@jupiter.solarsys.private>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

I'm using ccache version 2.4 [1].  I just changed ~/.ccache to a symbolic
link to a directory which is NFS mounted [2].  The kernel source itself is
on a local FS.  With the ccache suitably primed, when I do a kernel compile
using 'make -j4' it seems to get stuck for seconds at a time.  When it gets
unstuck, it blows through a handful of files and then gets stuck again.

When it is stuck, both NFS client and server are almost totally idle.  The
network itself has almost no other traffic.  It doesn't seem to matter if I
mount NFS w/ udp or tcp (v3 in both cases).

If I move ~/.ccache to a local FS, it never gets stuck.  If I just use 'make'
or even 'make -j2', (I'm pretty sure but not 100%) it never gets stuck.

The NFS client is FC3 with kernel.org 2.6.10-rc3.  I also tried it with -rc1,
2.6.9, and 2.6.8.1 - same problem.

Weirdest part: when I boot the distro stock kernel (2.6.9-1.681_FC3smp) the
problem goes away.  Configs for all of the above are here [3].

Please CC me with replies - thanks!

[1] http://ccache.samba.org/

[2] The NFS server uses kernel 2.4.28-rc2.

[3] http://members.dca.net/mhoffman/lkml-20041213/

-- 
Mark M. Hoffman
mhoffman@lightlink.com

