Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129324AbQLDADk>; Sun, 3 Dec 2000 19:03:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129535AbQLDADa>; Sun, 3 Dec 2000 19:03:30 -0500
Received: from altrade.nijmegen.inter.nl.net ([193.67.237.6]:52900 "EHLO
	altrade.nijmegen.inter.nl.net") by vger.kernel.org with ESMTP
	id <S129324AbQLDADR>; Sun, 3 Dec 2000 19:03:17 -0500
Date: Sun, 3 Dec 2000 23:36:11 +0100
From: Frank van Maarseveen <F.vanMaarseveen@inter.NL.net>
To: linux-kernel@vger.kernel.org
Subject: 2.4.0-test11: kernel: waitpid(823) failed, -512
Message-ID: <20001203233611.A8410@iapetus.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While playing with routing (zebra) and PPP I regularly see this
message appearing. It always happens when pppd terminates a connection,
e.g:

Dec  3 23:09:08 mimas pppd[784]: Modem hangup
Dec  3 23:09:08 mimas pppd[784]: Connection terminated.
Dec  3 23:09:08 mimas pppd[784]: Connect time 2.0 minutes.
Dec  3 23:09:08 mimas pppd[784]: Sent 499 bytes, received 977 bytes.
Dec  3 23:09:08 mimas pppd[822]: Hangup (SIGHUP)
Dec  3 23:09:08 mimas kernel: waitpid(823) failed, -512
Dec  3 23:09:08 mimas pppd[784]: Hangup (SIGHUP)
Dec  3 23:09:08 mimas pppd[784]: Exit.

The (incoming) PPP connection is tunnelled through a telnet connection so
there are some other processes involved.

On the outgoing side (other system also running 2.4.0-test11) I sometimes
see the same message, e.g:

Nov 29 23:37:08 iapetus pppd[1777]: Connection terminated.
Nov 29 23:37:08 iapetus pppd[1777]: Connect time 2.5 minutes.
Nov 29 23:37:08 iapetus pppd[1777]: Sent 85 bytes, received 87 bytes.
Nov 29 23:37:08 iapetus pppd[1777]: Exit.
Nov 29 23:37:08 iapetus kernel: waitpid(1857) failed, -512


-- 
Frank
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
