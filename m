Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273818AbRIRDKZ>; Mon, 17 Sep 2001 23:10:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273817AbRIRDKO>; Mon, 17 Sep 2001 23:10:14 -0400
Received: from [208.129.208.52] ([208.129.208.52]:7690 "EHLO xmailserver.org")
	by vger.kernel.org with ESMTP id <S273816AbRIRDKB>;
	Mon, 17 Sep 2001 23:10:01 -0400
Message-ID: <XFMail.20010917201333.davidel@xmailserver.org>
X-Mailer: XFMail 1.5.0 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
Date: Mon, 17 Sep 2001 20:13:33 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
To: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] /dev/epoll update ( bugfix ) ...
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


There's a simple but important fix in net/ipv4/tcp.c:tcp_write_space
where the call to sock_wake_async has been changed to sk_wake_async.
Since sock_wake_async does not contain the call to the event dispatch code,
it's easier to flush the Alan's patch queue than to receive POLLOUTs.
I fixed it at the end of July but I think I screwed up thing in my /patch folder.
The new patch is here :

http://www.xmailserver.org/linux-patches/nio-improve.html



- Davide

