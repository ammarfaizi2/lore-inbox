Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289026AbSAFU0j>; Sun, 6 Jan 2002 15:26:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289027AbSAFU02>; Sun, 6 Jan 2002 15:26:28 -0500
Received: from [216.218.222.115] ([216.218.222.115]:60055 "EHLO zarzycki.org")
	by vger.kernel.org with ESMTP id <S289026AbSAFU0O>;
	Sun, 6 Jan 2002 15:26:14 -0500
Date: Sun, 6 Jan 2002 12:23:50 -0800 (PST)
From: Dave Zarzycki <dave@zarzycki.org>
To: <linux-kernel@vger.kernel.org>
Subject: In kernel routing table vs. /sbin/ip vs. /sbin/route
Message-ID: <Pine.LNX.4.33.0201061211050.2619-100000@tidus.zarzycki.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Using /sbin/route, I can add multiple default routes like so:

/sbin/route add -net default gw 192.168.0.1
/sbin/route add -net default gw 192.168.0.2

But I cannot do the same with /sbin/ip:

/sbin/ip route add default via 192.168.0.1
/sbin/ip route add default via 192.168.0.2
RTNETLINK answers: File exists

Given that /sbin/ip is the more powerful and modern tool, I'm lead to
believe that /sbin/route might be leaving the in kernel routing table in a 
weird state.

My two simple questions are as follows:

1) Which tool is more correct?

2) What is the behavior of the kernel when multiple default routes are 
defined?

Thanks,

davez

-- 
Dave Zarzycki
http://zarzycki.org/~dave/

