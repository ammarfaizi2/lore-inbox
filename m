Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282974AbRK0V5i>; Tue, 27 Nov 2001 16:57:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282978AbRK0V5a>; Tue, 27 Nov 2001 16:57:30 -0500
Received: from ns.conwaycorp.net ([24.144.1.3]:7618 "HELO mail.conwaycorp.net")
	by vger.kernel.org with SMTP id <S282974AbRK0V5U>;
	Tue, 27 Nov 2001 16:57:20 -0500
Date: Tue, 27 Nov 2001 15:57:13 -0600
From: Nathan Poznick <poznick@conwaycorp.net>
To: linux-kernel@vger.kernel.org
Subject: failed assertion in tcp.c
Message-ID: <20011127155713.A8525@conwaycorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

I've got a machine running 2.4.14+xfs, it's a dual-p3 with 4gb ram
(CONFIG_HIGHMEM4G=y), and it's using an onboard eepro100.  The machine
is relatively heavily loaded with people doing compiles, and running
network/memory/disk intensive tasks, and I often see messages such as
these in the syslog:

Nov 27 12:23:42 dpdred1 kernel: eth0: can't fill rx buffer (force 0)! 
Nov 27 12:23:54 dpdred1 last message repeated 19 times
Nov 27 12:23:54 dpdred1 kernel: eth0: can't fill rx buffer (force 1)! 
Nov 27 12:23:57 dpdred1 kernel: eth0: can't fill rx buffer (force 0)! 
Nov 27 12:24:01 dpdred1 last message repeated 7 times
Nov 27 12:24:01 dpdred1 kernel: eth0: card reports no resources. 
Nov 27 12:24:01 dpdred1 kernel: eth0: restart the receiver after a
 possible hang.

Normally, everything seems fine, despite the eth0 messages.  Today
however, it stopped responding over the network, and when I got over
to the console, I found this as well: 

Nov 27 13:15:56 dpdred1 kernel: KERNEL: assertion (flags&MSG_PEEK)
 failed at tcp.c(1463):tcp_recvmsg 
Nov 27 13:15:56 dpdred1 kernel: recvmsg bug: copied 6671AD12 seq 6671B2BA 
Nov 27 13:15:56 dpdred1 kernel: KERNEL: assertion (flags&MSG_PEEK)
 failed at tcp.c(1463):tcp_recvmsg 
Nov 27 13:15:56 dpdred1 kernel: recvmsg bug: copied 6671AD12 seq 6671B2BA

Since people needed to use the machine, I didn't spend any time right
then trying to get any further insight into the problem, I just
rebooted it.  Does anyone have any insight into what might cause this?
(and how I can avoid it in the future?)

-- 
Nathan Poznick <poznick@conwaycorp.net>
PGP Key: http://drunkmonkey.org/pgpkey.txt

In a fight between you and the world, bet on the world.
-- Franz Kafka
