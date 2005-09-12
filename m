Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932244AbVILVIb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932244AbVILVIb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 17:08:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932249AbVILVIb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 17:08:31 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:59506
	"EHLO opteron.random") by vger.kernel.org with ESMTP
	id S932244AbVILVIa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 17:08:30 -0400
Date: Mon, 12 Sep 2005 23:08:36 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: dtor_core@ameritech.net
Cc: linux-kernel@vger.kernel.org, klive@cpushare.com
Subject: git tag in localversion
Message-ID: <20050912210836.GL13439@opteron.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

The patch that adds the git tag in the localversion is screwing klive a
bit, see the 2.6.13-g* entries in
http://klive.cpushare.com/?branch=unknown

Those are supposed to go in the homepage but they're not recognized
anymore due the git tag and so they go in the unknown page.

So either we add a branch name in /proc/branch (for mainline that will
be "2.6.13 mainline", that tells the release number and the branch, or I
shall do a bit more of regexp on the localversion). The branch tag has
the advantage of being able to more reliably recognize non-mainline
kernels as well, klive was made for mainline, I didn't expect so many
users with vendor kernels, but that's ok as long as the regexp on uname
-r works ;). The regexp is already falling apart with distro like
debian, so the sort of /proc/branch was suggested by them infact.

Yet another way would be to remove the git tag from the localversion ;),
but I doubt that it would be ok with you since it'd pratically backout
the feature. I don't think it would be enough for you to have the git
tag in /proc, the way I understand it you want it in the uts_release to
avoid overwriting system.map.

Suggestions welcome thanks.
