Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268335AbSIRUqv>; Wed, 18 Sep 2002 16:46:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268344AbSIRUqu>; Wed, 18 Sep 2002 16:46:50 -0400
Received: from mailout05.sul.t-online.com ([194.25.134.82]:53963 "EHLO
	mailout05.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S268335AbSIRUqu> convert rfc822-to-8bit; Wed, 18 Sep 2002 16:46:50 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: WOLK - Working Overloaded Linux Kernel
To: linux-kernel@vger.kernel.org
Subject: 2.5.36 - "Dead loop on virtual device lo, fix it urgently!"
Date: Wed, 18 Sep 2002 22:51:34 +0200
X-Mailer: KMail [version 1.4]
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200209182237.35054.m.c.p@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

from: net/core/dev.c

....
} else {
       /* Recursion is detected! It is possible,
        * unfortunately */
       if (net_ratelimit())
               printk(KERN_DEBUG "Dead loop on virtual device "
                      "%s, fix it urgently!\n", dev->name);
       }
....

hehe, "It is possible, unfortunately" and I hit it :)

just having lo, eth0 and eth0:2, nothing special, no tunnels etc. :)

appears, reproducable, with "apt-get update" or any other kind of some
high network load. NIC is an Intel EtherExpress PRO/100 card using the
"original Becker driver".

-- 
Kind regards
        Marc-Christian Petersen

http://sourceforge.net/projects/wolk

PGP/GnuPG Key: 1024D/569DE2E3DB441A16
Fingerprint: 3469 0CF8 CA7E 0042 7824 080A 569D E2E3 DB44 1A16
Key available at www.keyserver.net. Encrypted e-mail preferred.


