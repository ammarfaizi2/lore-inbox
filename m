Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267314AbUIOTTk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267314AbUIOTTk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 15:19:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267325AbUIOTTk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 15:19:40 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:13791 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S267314AbUIOTTj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 15:19:39 -0400
Date: Wed, 15 Sep 2004 14:19:33 -0500
From: Robin Holt <holt@sgi.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] Fix some return value truncation problems on file writes.
Message-ID: <20040915191933.GA3275@lnx-holt.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


During some testing, it was noted that writing more than 2GB using
fwrite() to a file on tmpfs would continue to retry the write()
syscall until the entire filesystem was full.  I was then encouraged
to verify XFS, ext2, ext3, reiserfs, and pipe.  The only other
problem noted was from reiserfs with direct I/O.  I did not test
the direct I/O code change.

Thanks,
Robin Holt
