Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262238AbUEKImh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262238AbUEKImh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 04:42:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262422AbUEKImh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 04:42:37 -0400
Received: from fw.osdl.org ([65.172.181.6]:9709 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262238AbUEKImg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 04:42:36 -0400
Date: Tue, 11 May 2004 01:42:32 -0700
From: Chris Wright <chrisw@osdl.org>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, torvalds@osdl.org, marcelo.tosatti@cyclades.com
Subject: [PATCH 0/11] rlimits for both queued signals and POSIX mqueues
Message-ID: <20040511014232.Y21045@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patches introduce per user rlimits for both queued
signals and POSIX message queues.  The changes touch all the arches
resource.h files as well as init_task.c to get the rlimit defaults setup.
Both require caching the user_struct to avoid problems with setuid().
The signal changes makes some small changes to send_signal() to pass
along the task being signalled to get proper accounting for signals
initiated in interrupt.  Patches are relative to 2.6.6-bk.  Thanks to
Marcelo for getting this one going.

thanks,
-chris
