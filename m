Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129994AbRAFFBY>; Sat, 6 Jan 2001 00:01:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131510AbRAFFBF>; Sat, 6 Jan 2001 00:01:05 -0500
Received: from moutvdom00.kundenserver.de ([195.20.224.149]:13152 "EHLO
	moutvdom00.kundenserver.de") by vger.kernel.org with ESMTP
	id <S129886AbRAFFAw>; Sat, 6 Jan 2001 00:00:52 -0500
Date: Sat, 6 Jan 2001 00:25:31 +0100
From: Christian Ullrich <chris@chrullrich.de>
To: linux-kernel@vger.kernel.org
Subject: Even slower NFS mounting with 2.4.0
Message-ID: <20010106002531.A490@christian.chrullrich.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
X-M$-Free-System: since 1999-11-28
X-Current-Uptime: 0 d, 00:02:04 h
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

About three weeks ago, I complained loudly about very slow NFS mounts
involving a 2.2.17 server and a 2.2.18 client.

Today, I complain loudly about *extremely* slow NFS mounts
with the very same server and the same client now running 2.4.0.

Using 2.2.18, every mount took about 15 seconds, now, using 2.4.0,
every mount takes exactly five minutes, which is way too long.

According to syslog, the server begins and completes its operations
related to the mount in under one second, so it seems to me that
mount on the client just takes a nap in D state.
Although the messages in the client's syslog look critical to me,
once the fs is mounted, it works fine.

Syslog on client:

Jan  6 00:18:06 c kernel: portmap: server localhost not responding, timed out
Jan  6 00:19:46 c kernel: portmap: server localhost not responding, timed out
Jan  6 00:19:46 c kernel: lockd_up: makesock failed, error=-5
Jan  6 00:21:26 c kernel: portmap: server localhost not responding, timed out

I called the mount command five minutes before the final message above.

I tried NFS with and without NFSv3 code, with no change at all.

Please help me.

-- 
Christian Ullrich		     Registrierter Linux-User #125183

"Sie können nach R'ed'mond fliegen -- aber Sie werden sterben"
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
