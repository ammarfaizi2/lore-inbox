Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262469AbSJOLtY>; Tue, 15 Oct 2002 07:49:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262474AbSJOLtY>; Tue, 15 Oct 2002 07:49:24 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.18.111]:47372 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S262469AbSJOLtX>; Tue, 15 Oct 2002 07:49:23 -0400
Date: Tue, 15 Oct 2002 13:55:17 +0200
From: Michal Kara <lemming@atrey.karlin.mff.cuni.cz>
To: linux-kernel@vger.kernel.org
Subject: Better fork() (and possbly others) failure diagnostics
Message-ID: <20021015115517.GA2514@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hello!

  Several times I had real problems with batch jobs failing with EAGAIN,
printed as "Resource temporarily unavailable". Not with the failure, but to
determine the real cause is really a pain. Usually, the problem is in
resource limits (rlimit, set by ulimit), but the returned error code is
misleading.

  There are two ways. One is to print something to syslog, when some rlimit
is reached. This is already done when limit of open files in system is
reached.

  The second is more subtle - define error code for reaching the rlimit
(possibly one errorcode for each rlimit) and slightly change the code to
return correct error code.

  What do you think about this subject?

								Michal Kara

-- 
PING 111.111.111.111 (111.111.111.111): 56 data bytes
...
---- Waiting for outstanding packets ----
No outstanding packets received, just two ordinary.

