Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132228AbRAXVJs>; Wed, 24 Jan 2001 16:09:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132193AbRAXVJi>; Wed, 24 Jan 2001 16:09:38 -0500
Received: from ferret.lmh.ox.ac.uk ([163.1.138.204]:21011 "HELO
	ferret.lmh.ox.ac.uk") by vger.kernel.org with SMTP
	id <S131368AbRAXVJS>; Wed, 24 Jan 2001 16:09:18 -0500
Date: Wed, 24 Jan 2001 21:09:09 +0000 (GMT)
From: Chris Evans <chris@scary.beasts.org>
To: <linux-kernel@vger.kernel.org>
cc: <davem@redhat.com>
Subject: 2.2, 2.4 bug in sock_no_fcntl()/F_SETOWN?
Message-ID: <Pine.LNX.4.30.0101242107070.24525-100000@ferret.lmh.ox.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Looking at the code for sock_no_fcntl() in net/core.c, I cannot specify
"0" as a value for F_SETOWN, unless I'm the superuser. I believe this to
be a bug, it stops de-registering an interest in SIGURG signals. Let me
know if you want a patch.

Cheers
Chris

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
