Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129459AbQKHGxm>; Wed, 8 Nov 2000 01:53:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129617AbQKHGxd>; Wed, 8 Nov 2000 01:53:33 -0500
Received: from [207.1.200.39] ([207.1.200.39]:14605 "EHLO
	ded-tscs.innovsoftd.com") by vger.kernel.org with ESMTP
	id <S129459AbQKHGxS>; Wed, 8 Nov 2000 01:53:18 -0500
Date: Wed, 8 Nov 2000 00:54:06 -0600 (CST)
From: "Gregory S. Youngblood" <greg@tcscs.com>
Reply-To: greg@tcscs.com
To: linux-kernel@vger.kernel.org
Subject: problems with grow_inodes: inode-max limit reached
Message-ID: <Pine.LNX.4.21.0011080046520.9666-100000@ded-tscs.innovsoftd.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've got a problem with inodes which spans three kernels when used
as a gateway/firewall.

The problem occurs with Mandrake 7.0 and 7.1 with kernels 2.2.14, 2.2.16,
and 2.2.17. These are the secure kernels that Mandrake provides.

The catch is, it only affects one machine - the machine I set up as a
gateway which is using rp-pppoe and acting as a gateway/firewall for a
windows and linux machine in a small network. As well as using ipmasqadm
for port forwarding.

The system works flawlessly, for about 24 to 72 hours. Then I start
getting:

grow_inodes: inode-max limit reached

repeatedly

Once this happens, I can't log in or reboot the system or access any files
on the system. The network connections appear to still work, as I don't
lose connecitivity with anything I'm currently connected to.

By default, the inode-max is 4096 on this sytem (a compaq deskpro 5133, 32
meg RAM). I've upped it to 131072 to try and buy some time.

The problem does NOT appear on either of my other linux workstations, one
of which has been up for 119 days with a login since Jul 11, 2000, and the
other which has been up for 30+ days at a time. The workstations run a
variety of items, including X, MySQL, PostgreSQL, httpd, sshd, and a
variety of other daemons. The gateway/firewall ONLY has sshd and other
minimal daemons, nothing more. (these other systems are also mandrake 7
using the same secure kernels 2.2.14 and 2.2.16).

I've done several searches for information on this problem, and so far the
only useful information I've found was someone suggesting resetting the
indoe-max value, which I've done. But, that still doesn't answer the
original problem.

Does anyone have any ideas on what is causing these problems? Or how to
fix it once and for all?

Greg

PS: The machine in question is configured:

Compaq Deskpro 5133, P-133, 32 meg RAM, 1.2 gig IDE hard drive, Intel
etherexpress pro 10/100, smc eznet 10/100 running Mandrake 7.1 with kernel
2.2.17 (Mandrake 2.2.17-21mdksecure).

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
