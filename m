Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262200AbTCRHhn>; Tue, 18 Mar 2003 02:37:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262204AbTCRHhn>; Tue, 18 Mar 2003 02:37:43 -0500
Received: from chello212017098056.surfer.at ([212.17.98.56]:32517 "EHLO
	hofr.at") by vger.kernel.org with ESMTP id <S262200AbTCRHhm>;
	Tue, 18 Mar 2003 02:37:42 -0500
From: Der Herr Hofrat <der.herr@hofr.at>
Message-Id: <200303180751.h2I7pIT11537@hofr.at>
Subject: bug in kernel/sysctl.c (SYSIPC) ?
To: linux-kernel@vger.kernel.org
Date: Tue, 18 Mar 2003 08:51:17 +0100 (CET)
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


HI !

 atleast in kernel 2.4.19 and 2.4.20 in kernel/sysctl.c shmmax and shmall use
 the proc_dointvec_minmax callback without passing a min/max value - is there
 a reson for this or is this a simple bug ?

linux/kenrel/sysctl.c (line 221 for 2.4.19/20)

#ifdef CONFIG_SYSVIPC
	{KERN_SHMMAX, "shmmax", &shm_ctlmax, sizeof (size_t),
	 0644, NULL, &proc_doulongvec_minmax},
	{KERN_SHMALL, "shmall", &shm_ctlall, sizeof (size_t),
	 0644, NULL, &proc_doulongvec_minmax},
	...
#endif

hofrat
