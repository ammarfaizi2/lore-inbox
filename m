Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263016AbSJBJOc>; Wed, 2 Oct 2002 05:14:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263019AbSJBJOc>; Wed, 2 Oct 2002 05:14:32 -0400
Received: from yue.hongo.wide.ad.jp ([203.178.139.94]:11539 "EHLO
	yue.hongo.wide.ad.jp") by vger.kernel.org with ESMTP
	id <S263016AbSJBJOb>; Wed, 2 Oct 2002 05:14:31 -0400
Date: Wed, 02 Oct 2002 18:20:06 +0900 (JST)
Message-Id: <20021002.182006.1021932192.yoshfuji@wide.ad.jp>
To: linux_4ever@yahoo.com
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.18+IPv6+IPV6_ADDRFORM
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@wide.ad.jp>
In-Reply-To: <20021001163221.73061.qmail@web9607.mail.yahoo.com>
References: <20021001163221.73061.qmail@web9607.mail.yahoo.com>
X-URL: http://www.yoshifuji.org/%7Ehideaki/
X-Fingerprint: 90 22 65 EB 1E CF 3A D1 0B DF 80 D8 48 07 F8 94 E0 62 0E EA
X-PGP-Key-URL: http://www.yoshifuji.org/%7Ehideaki/hideaki@yoshifuji.org.asc
X-Mailer: Mew version 2.2 on XEmacs 21.4.6 (Common Lisp)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20021001163221.73061.qmail@web9607.mail.yahoo.com> (at Tue, 1 Oct 2002 09:32:21 -0700 (PDT)), Steve G <linux_4ever@yahoo.com> says:

> According to it, calling getsockopt() with level
> IPPROTO_IPV6 and option IPV6_ADDRFORM should get the
> option value. However, I get a socket error. I changed
> the level to IPPROTO_IP and the call goes through, but
> Richard Stevens' book states that AF_INET or AF_INET6
> should be returned rather than 0 or 1.
> 
> 1) should the level really be IPPROTO_IPV6?
> 2) do other platforms use IPPROTO_IP to retrieve this
> option or said another way, is the behavior observed
> in Linux portable?
> 3) should the returned value be 0 & 1 or AF_INET &
> AF_INET6?
> 4) Is this a deprecated option and likely to be
> dropped?

IPV6_ADDRFORM is deprecated.
I believe that it should be removed.


> Also, the Sus v3, states there is a socket option:
> level IPPROTO_IPV6, option IPV6_V6ONLY...will this be
> supported in 2.4 or 2.6? A grep -r doesn't get any
> hits from /usr/include.

We, USAGI Project, have implementation for it,
and we are about to contribute it here.

-- 
Hideaki YOSHIFUJI @ USAGI Project <yoshfuji@linux-ipv6.org>
GPG FP: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
