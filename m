Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278555AbRJ1QPw>; Sun, 28 Oct 2001 11:15:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278556AbRJ1QPm>; Sun, 28 Oct 2001 11:15:42 -0500
Received: from vti01.vertis.nl ([145.66.4.26]:32522 "EHLO vti01.vertis.nl")
	by vger.kernel.org with ESMTP id <S278555AbRJ1QPb>;
	Sun, 28 Oct 2001 11:15:31 -0500
Content-Type: text/plain; charset=US-ASCII
From: Rolf Fokkens <fokkensr@linux06.vertis.nl>
To: linux-kernel@vger.kernel.org
Subject: iptables and tcpdump
Date: Sun, 28 Oct 2001 17:10:41 -0800
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01102817104101.01788@home01>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I've been "tcpdumping" traffic that passes through a NAT box based on
netfilter. Everything works wonderful, but tcpdump presents confusing data.
With the help of google I found out that tcpdump sees the data right after
the NF_IP_PRE_ROUTING and the NF_IP_POST_ROUTING hooks. This explains it all,
but results in a new question: why does tcpdump "see" the data after the
NF_IP_PRE_ROUTING hook instead of before, which more accurately reflects the
data that's on the wire?

I can imagine this has been explained before, but I haven't found the full
explanation. Could someone enlighten me?

Another thing is /proc/net/ip_conntrack. It shows also some confusing
information like this:

icmp 1 29 src=145.66.17.200 dst=10.13.92.231 ... [UNREPLIED]
src=130.130.92.231 dst=145.66.17.200 ...

One half shows an unNATted dst, the second half shows the NATted src.
Logically speaking they should match but now they don't.

So everything works fine, but it's presented in a confusing way (tcpdump,
ip_conntrack). This may be intentionally but it seems a little accidentally
to me.

Rolf

-------------------------------------------------------
