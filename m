Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284578AbRLETEQ>; Wed, 5 Dec 2001 14:04:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284574AbRLETEH>; Wed, 5 Dec 2001 14:04:07 -0500
Received: from z.thunderworx.net ([217.27.32.64]:27921 "EHLO francoudi.com")
	by vger.kernel.org with ESMTP id <S284594AbRLETDq>;
	Wed, 5 Dec 2001 14:03:46 -0500
Message-ID: <3C0E6F8B.A6C85AB6@francoudi.com>
Date: Wed, 05 Dec 2001 21:03:40 +0200
From: Vladimir Ivaschenko <hazard@francoudi.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.16-3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: sendmsg() leaves Identification field in IP header empty
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

I've been struggling to understand why an application which worked fine
on 2.2.X stopped working on 2.4.7 (RH72) and found out that sendmsg()
always leaves Identification field in IP header set to 0 (at least for
UDP sockets). This confuses Cisco devices when you're doing
WCCP negotiations with them. The application is "Oops!" proxy server -
http://zipper.paco.net/~igor/oops.eng/

Sorry if I'm wrong but I think this is a kernel problem because
sendmsg() is a system call. On RH6.2 with 2.2.19 this doesn't happen,
and Identification field in IP header is set to non-zero values. Let me
know if you need any other information, as I do not have any experience
in debugging these sort of problems.

Please CC your replies, if any, to my e-mail as I'm not subscribed to
the list.

--
Best Regards
Vladimir Ivaschenko
Certified Linux Engineer (RHCE)



