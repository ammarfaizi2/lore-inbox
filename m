Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267888AbTBVMjo>; Sat, 22 Feb 2003 07:39:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267890AbTBVMjo>; Sat, 22 Feb 2003 07:39:44 -0500
Received: from yue.hongo.wide.ad.jp ([203.178.139.94]:58887 "EHLO
	yue.hongo.wide.ad.jp") by vger.kernel.org with ESMTP
	id <S267888AbTBVMjn>; Sat, 22 Feb 2003 07:39:43 -0500
Date: Sat, 22 Feb 2003 21:49:35 +0900 (JST)
Message-Id: <20030222.214935.134101784.yoshfuji@linux-ipv6.org>
To: davem@redhat.com
Cc: kazunori@miyazawa.org, kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com, usagi@linux-ipv6.org, kunihiro@ipinfusion.com
Subject: Re: [PATCH] IPv6 IPSEC support
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <20030222.031326.103246837.davem@redhat.com>
References: <20030222202623.38d41d8a.kazunori@miyazawa.org>
	<20030222.031326.103246837.davem@redhat.com>
Organization: USAGI Project
X-URL: http://www.yoshifuji.org/%7Ehideaki/
X-Fingerprint: 90 22 65 EB 1E CF 3A D1 0B DF 80 D8 48 07 F8 94 E0 62 0E EA
X-PGP-Key-URL: http://www.yoshifuji.org/%7Ehideaki/hideaki@yoshifuji.org.asc
X-Face: "5$Al-.M>NJ%a'@hhZdQm:."qn~PA^gq4o*>iCFToq*bAi#4FRtx}enhuQKz7fNqQz\BYU]
 $~O_5m-9'}MIs`XGwIEscw;e5b>n"B_?j/AkL~i/MEa<!5P`&C$@oP>ZBLP
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.1 (AOI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

In article <20030222.031326.103246837.davem@redhat.com> (at Sat, 22 Feb 2003 03:13:26 -0800 (PST)), "David S. Miller" <davem@redhat.com> says:

> Nothing in xfrm routines really need to reference ipv6 module
> functions, please eliminate this dependency.  Breaking ipv6 as module
> is ok for temporary development, but eventually it must be solved.

xfrm_policy.c:xfrm6_bundle_create() seems to depend on ip6_route_output()
as xfrm_bundle_create() depends on __ip_route_output_key().
How do we solve this dependency? inter-module?

-- 
Hideaki YOSHIFUJI @ USAGI Project <yoshfuji@linux-ipv6.org>
GPG FP: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
