Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129030AbQKEB2Z>; Sat, 4 Nov 2000 20:28:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129247AbQKEB2P>; Sat, 4 Nov 2000 20:28:15 -0500
Received: from mail01.cts.ne.jp ([210.169.170.135]:16002 "HELO
	mail01.cts.ne.jp") by vger.kernel.org with SMTP id <S129030AbQKEB2K>;
	Sat, 4 Nov 2000 20:28:10 -0500
Date: Sun, 5 Nov 2000 10:25:39 +0900
From: Akira YOSHIYAMA <yosshy@cts.ne.jp>
To: linux-kernel@vger.kernel.org
Subject: APM related hardware locking
Message-Id: <20001105102539.54a21da6.yosshy@cts.ne.jp>
X-Mailer: Sylpheed version 0.4.3 (GTK+ 1.2.8; Linux 2.4.0-test9; i686)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I found that Linux 2.4.x got locking with apm.o and yenta_socket.o
since yenta driver was there. But, someone has reported another apm.o
related locking. I don't know about why this problem causes and who
works for this. 

So, I want more infomations, i.e. situation, position, timing and so on.
Tell me these if you know.

I know a locking situation:
* apm.o and yenta_socket.o are loaded and scan devices.
* `cat /proc/apm` or something that causes calling apm_bios_call().
-> hardware locking. Nothing except turn off with the power switch.

Any infos welcome. Thanks.

	A.Yoshiyama <yosshy@debian.or.jp>
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
