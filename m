Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131212AbRCGVbr>; Wed, 7 Mar 2001 16:31:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131210AbRCGVbi>; Wed, 7 Mar 2001 16:31:38 -0500
Received: from mail.t-intra.de ([62.156.146.210]:24513 "EHLO mail.t-intra.de")
	by vger.kernel.org with ESMTP id <S131194AbRCGVb1>;
	Wed, 7 Mar 2001 16:31:27 -0500
Message-Id: <200103072130.f27LU0B05886@gate2.private.net>
From: "Otto Meier" <gf435@gmx.net>
To: "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "Neil Brown" <neilb@cse.unsw.edu.au>
Date: Wed, 07 Mar 2001 22:30:39 +0100
Reply-To: "otto meier" <gf435@gmx.net>
X-Mailer: PMMail 2000 Professional (2.10.2010) For Windows 98 (4.10.2222)
In-Reply-To: <14955.19182.663691.194031@notabene.cse.unsw.edu.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Subject: Kernel crash during resync of raid5 on SMP
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I run a Dual prozessor SMP system on 2.4.2-ac12 for a while
in degraded mode. Today I put in a new disk to switch to
full raid5 mode. Shortly after the command raidhotadd  the 
system crashed with the message lost interrupt on cpu1.

This continued after reboot. I finaly managed to get it running again
by booting with kernel parameter maxcpus=1. In this one CPU mode
it finished resycing. 

During this process I was never able to resync with two CPU's.

After finishing rescyncing the system run now fine in SMP Dual mode again.

Perhaps there might be an issue with spinlocks during resyncing.

Bye Otto







