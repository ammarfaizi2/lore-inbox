Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129688AbQKQRrD>; Fri, 17 Nov 2000 12:47:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129602AbQKQRqx>; Fri, 17 Nov 2000 12:46:53 -0500
Received: from duracef.shout.net ([204.253.184.12]:14862 "EHLO
	duracef.shout.net") by vger.kernel.org with ESMTP
	id <S129748AbQKQRql>; Fri, 17 Nov 2000 12:46:41 -0500
Date: Fri, 17 Nov 2000 11:17:17 -0600
From: Michael Elizabeth Chastain <mec@shout.net>
Message-Id: <200011171717.LAA22480@duracef.shout.net>
To: peter@cadcamlab.org, torvalds@transmeta.com
Subject: Re: [KBUILD] test11pre6: incorrect makefile change
Cc: linux-kbuild@torque.net, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

peter> This toplevel Makefile change in 11pre6 is wrong:
peter> 
peter> -	$(HOSTCC) $(HOSTCFLAGS) -o scripts/split-include scripts/split-include.c
peter> +	$(HOSTCC) $(HOSTCFLAGS) -I$(HPATH) -o scripts/split-include scripts/split-include.c

Peter is right.  $(HOSTCC) must compile and link C programs on
the host without reference to any kernel include files.

Michael Elizabeth Chastain
<mailto:mec@shout.net>
"love without fear"
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
