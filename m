Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135609AbRDSJrM>; Thu, 19 Apr 2001 05:47:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135610AbRDSJrB>; Thu, 19 Apr 2001 05:47:01 -0400
Received: from passat.ndh.net ([195.94.90.26]:51141 "EHLO passat.ndh.net")
	by vger.kernel.org with ESMTP id <S135609AbRDSJqt>;
	Thu, 19 Apr 2001 05:46:49 -0400
Date: Thu, 19 Apr 2001 11:46:46 +0200
From: Alex Riesen <a.riesen@traian.de>
To: LKML <linux-kernel@vger.kernel.org>
Subject: missing poll(2) for semaphores
Message-ID: <20010419114646.B798@traian.de>
Mail-Followup-To: LKML <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, all
i am missing a good (i think) feature of unix descriptors
in SysV semaphores - to be poll(2)-able.
Have someone an idea to somehow achieve the goal ? 


something like this:

int sem = create_our_pollable_semaphore();
...
...
pollfd fds[xxx];

for(i=0; i < countof(fds); fds[i++].events = POLLIN|POLLOUT);
fds[0].fd = sem;
fds[1].fd = server_sock1;
fds[2].fd = cmd_sock2;

while ( poll(fds, countof(fds), -1) >= 0 )
 ...

Thank you in advance

Alex Riesen


