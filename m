Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265324AbSJXFty>; Thu, 24 Oct 2002 01:49:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265325AbSJXFty>; Thu, 24 Oct 2002 01:49:54 -0400
Received: from yue.hongo.wide.ad.jp ([203.178.139.94]:23564 "EHLO
	yue.hongo.wide.ad.jp") by vger.kernel.org with ESMTP
	id <S265324AbSJXFtx>; Thu, 24 Oct 2002 01:49:53 -0400
Date: Thu, 24 Oct 2002 14:55:51 +0900 (JST)
Message-Id: <20021024.145551.130454003.yoshfuji@linux-ipv6.org>
To: usagi@linux-ipv6.org, pekkas@netcore.fi
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [PATCH] IPv6: Sysctl for ICMPv6 Rate Limitation
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <Pine.LNX.4.44.0210240847280.8872-100000@netcore.fi>
References: <20021024.135055.10632889.yoshfuji@linux-ipv6.org>
	<Pine.LNX.4.44.0210240847280.8872-100000@netcore.fi>
Organization: USAGI Project
X-URL: http://www.yoshifuji.org/%7Ehideaki/
X-Fingerprint: 90 22 65 EB 1E CF 3A D1 0B DF 80 D8 48 07 F8 94 E0 62 0E EA
X-PGP-Key-URL: http://www.yoshifuji.org/%7Ehideaki/hideaki@yoshifuji.org.asc
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.1 (AOI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.44.0210240847280.8872-100000@netcore.fi> (at Thu, 24 Oct 2002 08:50:25 +0300 (EEST)), Pekka Savola <pekkas@netcore.fi> says:

> > +icmp/*:
> > +ratelimit - INTEGER
> > +	Limit the maximal rates for sending ICMPv6 packets.
> > +	0 to disable any limiting, otherwise the maximal rate in jiffies(1)
> > +	Default: 100
> > +
> 
> Does this rate-limit all ICMPv6 packets or just ICMPv6 error messages (as 
> specified in ICMPv6 specifications).
> 
> If all, I believe the default of rate-limiting everything is unacceptable.

This patch just adds sysctl.  It is my documentation error...
is s/ICMPv6 packets/ICMPv6 error packets/ ok?

(I need to do s/100/HZ/, too; This also lives in ICMP(v4)).

--yoshfuji
