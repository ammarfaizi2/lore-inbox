Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261717AbSJAQ1B>; Tue, 1 Oct 2002 12:27:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261700AbSJAQ1A>; Tue, 1 Oct 2002 12:27:00 -0400
Received: from web9607.mail.yahoo.com ([216.136.129.186]:32781 "HELO
	web9607.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S261717AbSJAQ05>; Tue, 1 Oct 2002 12:26:57 -0400
Message-ID: <20021001163221.73061.qmail@web9607.mail.yahoo.com>
Date: Tue, 1 Oct 2002 09:32:21 -0700 (PDT)
From: Steve G <linux_4ever@yahoo.com>
Subject: 2.4.18+IPv6+IPV6_ADDRFORM
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I am using a 2.4.18 kernel and ran across something I
thought was odd and need to understand better. I'm
writing a test suite to verify xinetd and I'm trying
to check a socket via getsockopt() to see if the
IPV6_ADDRFORM socket option has been set. I cannot
find IPV6_ADDRFORM in the Single Unix Standard or man
pages, so I am going by what is in Richard Steven's
book, Network Programming vol 1.

According to it, calling getsockopt() with level
IPPROTO_IPV6 and option IPV6_ADDRFORM should get the
option value. However, I get a socket error. I changed
the level to IPPROTO_IP and the call goes through, but
Richard Stevens' book states that AF_INET or AF_INET6
should be returned rather than 0 or 1.

1) should the level really be IPPROTO_IPV6?
2) do other platforms use IPPROTO_IP to retrieve this
option or said another way, is the behavior observed
in Linux portable?
3) should the returned value be 0 & 1 or AF_INET &
AF_INET6?
4) Is this a deprecated option and likely to be
dropped?

Also, the Sus v3, states there is a socket option:
level IPPROTO_IPV6, option IPV6_V6ONLY...will this be
supported in 2.4 or 2.6? A grep -r doesn't get any
hits from /usr/include.

Thanks,
Steve Grubb

__________________________________________________
Do you Yahoo!?
New DSL Internet Access from SBC & Yahoo!
http://sbc.yahoo.com
