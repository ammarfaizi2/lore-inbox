Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130800AbQKQIqv>; Fri, 17 Nov 2000 03:46:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131014AbQKQIql>; Fri, 17 Nov 2000 03:46:41 -0500
Received: from ausmtp02.au.ibm.COM ([202.135.136.105]:59922 "EHLO
	ausmtp02.au.ibm.com") by vger.kernel.org with ESMTP
	id <S130800AbQKQIqc>; Fri, 17 Nov 2000 03:46:32 -0500
From: aprasad@in.ibm.com
X-Lotus-FromDomain: IBMIN@IBMAU
To: Richard Jerrell <jerrell@missioncriticallinux.com>
cc: linux-kernel@vger.kernel.org
Message-ID: <CA25699A.002D5E5D.00@d73mta05.au.ibm.com>
Date: Fri, 17 Nov 2000 13:39:27 +0530
Subject: Re: Bug in 2.4.0-test9 and test10 with sys_shmat()
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>Sending -1 as the shmid to shmat will cause an oops.  2.2.16 caught this
>with simple boundry checking, so replace the lines

>if (!shm_sb || (shmid % SEQ_MULTIPLIER) == zero_id)
                return -EINVAL;

>with

>if (!shm_sb || shmid < 0 || (shmid % SEQ_MULTIPLIER) == zero_id)
                return -EINVAL;

-1 shmid is causing oops only when used with superuser privileges,
otherwise it returns -EINVAL.
regards
Anil


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
