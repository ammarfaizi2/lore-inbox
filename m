Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263209AbSJCIat>; Thu, 3 Oct 2002 04:30:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263210AbSJCIat>; Thu, 3 Oct 2002 04:30:49 -0400
Received: from pizda.ninka.net ([216.101.162.242]:52943 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S263209AbSJCIas>;
	Thu, 3 Oct 2002 04:30:48 -0400
Date: Thu, 03 Oct 2002 01:29:04 -0700 (PDT)
Message-Id: <20021003.012904.75241727.davem@redhat.com>
To: yoshfuji@linux-ipv6.org
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com, usagi@linux-ipv6.org
Subject: Re: [PATCH] IPv6: Allow Both IPv6 and IPv4 Sockets on the Same
 Port Number (IPV6_V6ONLY Support)
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20021003.121350.119660876.yoshfuji@linux-ipv6.org>
References: <20021003.121350.119660876.yoshfuji@linux-ipv6.org>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: YOSHIFUJI Hideaki / 吉藤英明 <yoshfuji@linux-ipv6.org>
   Date: Thu, 03 Oct 2002 12:13:50 +0900 (JST)

   Linux IPv6 stack provides the ability for IPv6 applications to
   interoperate with IPv4 applications.  Port space for TCP (or UDP) is
   shared by IPv6 and IPv4.  This conforms to RFC2553.
   However, some kind of applications may want to restrict their use of
   an IPv6 socket to IPv6 communication only.  IPV6_V6ONLY socket option is
   defined for such applications in RFC2553bis, which is successor of RFC2553.  

I really wish BSD socket features did not get standardized
in RFC's, we must live with their mistakes.

For example, this IPV6_V6ONLY socket option is flawed.  What we
really need is a generic socket option which says "my family only"

There is nothing ipv6 specific about such a socket attribute.

So please, create instead "SO_ONEFAMILY" or similar generic
socket option.

I still need to review the rest of the patch for functional
correctness.  This is probably the most complex area of the
socket identity code in TCP/UDP :-)
