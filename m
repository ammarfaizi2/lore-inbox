Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129555AbQK3SO5>; Thu, 30 Nov 2000 13:14:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129912AbQK3SOq>; Thu, 30 Nov 2000 13:14:46 -0500
Received: from [62.254.209.2] ([62.254.209.2]:64496 "EHLO cam-gw.zeus.co.uk")
        by vger.kernel.org with ESMTP id <S130777AbQK3SGI>;
        Thu, 30 Nov 2000 13:06:08 -0500
Date: Thu, 30 Nov 2000 17:35:41 +0000 (GMT)
From: Ben Mansell <ben@zeus.com>
To: <linux-kernel@vger.kernel.org>
Subject: TCP push missing with writev()
Message-ID: <Pine.LNX.4.30.0011301710020.8071-100000@artemis.cam.zeus.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(possibly treading on ground covered before:
 http://www.uwsg.iu.edu/hypermail/linux/kernel/9904.1/0304.html )

To be brief and to the point: Should there be any difference between the
following two ways of writing data to a TCP socket?

1) write( fd, buffer, length )
2) writev( fd, {buffer, length}, {NULL,0} )

The problem is that if data happens to be written via method (2), then
the PUSH flag is never set on any packets generated. This is a bug,
surely?

(Occurs on 2.2.5 and 2.4.0-test10. Doesn't occur in 2.0.36 and lots of
 other UNIX-alikes)


Ben

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
