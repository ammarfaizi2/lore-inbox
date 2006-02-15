Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751118AbWBORu5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751118AbWBORu5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 12:50:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751173AbWBORu5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 12:50:57 -0500
Received: from [202.149.212.34] ([202.149.212.34]:61510 "EHLO cmie.com")
	by vger.kernel.org with ESMTP id S1751118AbWBORu4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 12:50:56 -0500
Date: Wed, 15 Feb 2006 23:20:49 +0530 (IST)
From: Nohez <nohez@cmie.com>
X-X-Sender: <nohez@mars.cmie.ernet.in>
To: Mark Fasheh <mark.fasheh@oracle.com>
cc: Claudio Martins <ctpm@rnl.ist.utl.pt>, <linux-kernel@vger.kernel.org>
Subject: Re: OCFS2 Filesystem inconsistency across nodes
In-Reply-To: <20060214201946.GD20175@ca-server1.us.oracle.com>
Message-ID: <Pine.LNX.4.33.0602152244050.3591-100000@mars.cmie.ernet.in>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Applied both the patches - jbd-undo.patch and the dlm.patch
from mm1 kernel to the recently released OpenSuSE kernel
(kernel-smp-2.6.16_rc3-2). Recreated the filesystem using mkfs.ocfs2.
Tried the two tests that I had reported in my previous email. Both of
them run ok now.

Now started bonnie++ on one node while the same volume on the other node
is mounted and is in quiescent stage. Its been more than 5 hours now
and both the nodes are up & running. Seeing some very high load of >8 at
times on the node running bonnie++. Test node has 4GB RAM and bonnie++
is creating files of 8GB to test IO performance. Will start bonnie++
on both the nodes concurrently later.

