Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129851AbRB0Ui0>; Tue, 27 Feb 2001 15:38:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129848AbRB0UiL>; Tue, 27 Feb 2001 15:38:11 -0500
Received: from pat.uio.no ([129.240.130.16]:26018 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S129851AbRB0UhE>;
	Tue, 27 Feb 2001 15:37:04 -0500
To: "Zdravko Spoljar" <flirek@hotmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: nfs_refresh_inode ?
In-Reply-To: <LAW2-F2101vraQ4yvco00012ad0@hotmail.com>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Content-Type: text/plain; charset=US-ASCII
Date: 27 Feb 2001 21:36:59 +0100
In-Reply-To: "Zdravko Spoljar"'s message of "Tue, 27 Feb 2001 18:34:24 -0000"
Message-ID: <shsy9urhnh0.fsf@charged.uio.no>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Zdravko Spoljar <flirek@hotmail.com> writes:

     > Hi i'm running 2.2.19pre14+RAID+ide and get this message from
     > kernel:

     > nfs_refresh_inode: inode number mismatch expected
     > (0x0ffffffff/0x0ffffffff), got (0x0002b0001/0x00005605)
     >                                                            ^^^^

Could you get a tcpdump of a the traffic when this happens? I suspect
a server bug.

     > marked numbers vary from message to message. i can triger this
     > by doing "make test;chmod 777 test" on some nfs mounted file
     > sistem some times repeated chmod generate more messages,
     > sometimes are executed ok. i have feeling it happend more often
     > when there is some cpu and net load.


     > linux nfs client is dual pentium II (266) on P2B-DS with 2
     > promise IDE cards, net card is smc (using realtek 8139 driver),
     > ide and scsi disks are in RAID 5 setup.

     > nfs server is Apple Network server running AIX4.1.5 net conn is
     > 100MB over Cisco switch

     > ah, there is one more thing. on boot when nfs get mounted i
     > find in dmesg: "nfs warning: mount version older than kernel"
     > WTF? :)

It means that your 'mount' program is too old, and so you won't be
able to mount NFSv3 partitions.

Cheers,
  Trond
