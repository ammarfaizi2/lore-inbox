Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314381AbSEBMeB>; Thu, 2 May 2002 08:34:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314383AbSEBMeA>; Thu, 2 May 2002 08:34:00 -0400
Received: from boden.synopsys.com ([204.176.20.19]:45234 "HELO
	boden.synopsys.com") by vger.kernel.org with SMTP
	id <S314381AbSEBMeA>; Thu, 2 May 2002 08:34:00 -0400
Date: Thu, 2 May 2002 14:33:35 +0200
From: Alex Riesen <Alexander.Riesen@synopsys.com>
To: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
Cc: linux-kernel@vger.kernel.org
Subject: 2.5.12(bk): IPv6 over IPv4 tunnel device initialization
Message-ID: <20020502143335.A9241@riesen-pc.gr05.synopsys.com>
Reply-To: Alexander.Riesen@synopsys.com
Mail-Followup-To: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
just came across a suspicious warning:

...
  CC net/ipv6/ip6_input.o
  CC net/ipv6/addrconf.o
  CC net/ipv6/sit.o
.../net/ipv6/sit.c:67: warning: initialization makes integer from pointer without a cast
...


It looks like the order of fields in net_device has changed,
as the net_device::init is not initialized now with
ipip6_fb_tunnel_init, but with a 0.
Using field labels in the initialization would be a good thing, imho.

-alex

