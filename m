Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129051AbRBUNJr>; Wed, 21 Feb 2001 08:09:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129108AbRBUNJh>; Wed, 21 Feb 2001 08:09:37 -0500
Received: from nmh.informatik.uni-bremen.de ([134.102.224.3]:15084 "EHLO
	nmh.informatik.uni-bremen.de") by vger.kernel.org with ESMTP
	id <S129051AbRBUNJ1>; Wed, 21 Feb 2001 08:09:27 -0500
To: linux-kernel@vger.kernel.org
Subject: Problem with 2.2.19pre9 (Connection closed.)
From: Markus Germeier <mager@tzi.de>
Date: 21 Feb 2001 14:09:22 +0100
Message-ID: <94ae7g9o8t.fsf@religion.informatik.uni-bremen.de>
User-Agent: Gnus/5.0802 (Gnus v5.8.2) Emacs/20.6
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

after upgrading to 2.2.19pre9 (+ 2 NFS-patches, IPv6 enabled) idle
connections tend to shut down without a visible reason:

client->ssh server
Last login: Mon Feb 19 2001 18:01:12 from client.domain
Sun Microsystems Inc.   SunOS 5.8       Generic February 2000
You have mail.
server->Disconnected; connection lost (Connection closed.).
Connection to server closed.
client->uname -a
Linux client 2.2.19pre9 #6 Thu Feb 15 09:26:46 MET 2001 i686 unknown

Here is the relevant part of a tcpdump from this session: (The whole
dump can be found here: http://www.tzi.de/~mager/linux.tcpdump )

        [...]
10:15:17.336759 eth0 < server.domain.ssh > client.domain.afbackup: P 2242:2294(52) ack 1790 win 24616 <nop,nop,timestamp 232542776 43462051> (DF)
10:15:17.350719 eth0 > client.domain.afbackup > server.domain.ssh: . 1790:1790(0) ack 2294 win 31856 <nop,nop,timestamp 43462055 232542776> (DF)
        [...]
12:15:17.158963 eth0 < server.domain.ssh > client.domain.afbackup: P 2293:2294(1) ack 1790 win 24616 <nop,nop,timestamp 233262778 43462055> (DF)
12:15:18.506350 eth0 < server.domain.ssh > client.domain.afbackup: P 2293:2294(1) ack 1790 win 24616 <nop,nop,timestamp 233262913 43462055> (DF)
12:15:21.216267 eth0 < server.domain.ssh > client.domain.afbackup: P 2293:2294(1) ack 1790 win 24616 <nop,nop,timestamp 233263184 43462055> (DF)
12:15:26.636121 eth0 < server.domain.ssh > client.domain.afbackup: P 2293:2294(1) ack 1790 win 24616 <nop,nop,timestamp 233263726 43462055> (DF)
12:15:37.475848 eth0 < server.domain.ssh > client.domain.afbackup: P 2293:2294(1) ack 1790 win 24616 <nop,nop,timestamp 233264810 43462055> (DF)
12:15:59.155272 eth0 < server.domain.ssh > client.domain.afbackup: P 2293:2294(1) ack 1790 win 24616 <nop,nop,timestamp 233266978 43462055> (DF)
12:16:42.514137 eth0 < server.domain.ssh > client.domain.afbackup: P 2293:2294(1) ack 1790 win 24616 <nop,nop,timestamp 233271314 43462055> (DF)
12:17:42.512562 eth0 < server.domain.ssh > client.domain.afbackup: P 2293:2294(1) ack 1790 win 24616 <nop,nop,timestamp 233277314 43462055> (DF)
12:18:42.511239 eth0 < server.domain.ssh > client.domain.afbackup: P 2293:2294(1) ack 1790 win 24616 <nop,nop,timestamp 233283314 43462055> (DF)
12:19:42.509606 eth0 < server.domain.ssh > client.domain.afbackup: P 2293:2294(1) ack 1790 win 24616 <nop,nop,timestamp 233289314 43462055> (DF)
12:20:42.508124 eth0 < server.domain.ssh > client.domain.afbackup: P 2293:2294(1) ack 1790 win 24616 <nop,nop,timestamp 233295314 43462055> (DF)
12:21:42.506655 eth0 < server.domain.ssh > client.domain.afbackup: P 2293:2294(1) ack 1790 win 24616 <nop,nop,timestamp 233301314 43462055> (DF)
12:22:42.505090 eth0 < server.domain.ssh > client.domain.afbackup: P 2293:2294(1) ack 1790 win 24616 <nop,nop,timestamp 233307314 43462055> (DF)
        [...]
14:23:10.527642 eth0 > client.domain.afbackup > server.domain.ssh: . 1789:1789(0) ack 2294 win 31856 <nop,nop,timestamp 44949377 233307314> (DF)
14:23:10.528676 eth0 < server.domain.ssh > client.domain.afbackup: R 2292303093:2292303093(0) win 0 (DF)
        [...]

Any ideas?

Thanks a lot for your help!!

Regards
        Markus

-- 
Markus Germeier
mager@tzi.de
