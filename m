Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311824AbSCNWLN>; Thu, 14 Mar 2002 17:11:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311826AbSCNWLD>; Thu, 14 Mar 2002 17:11:03 -0500
Received: from adsl-64-175-255-50.dsl.sntc01.pacbell.net ([64.175.255.50]:38562
	"EHLO mail.soze.net") by vger.kernel.org with ESMTP
	id <S311824AbSCNWKt>; Thu, 14 Mar 2002 17:10:49 -0500
Date: Thu, 14 Mar 2002 22:10:44 +0000
From: Justin Guyett <justin@soze.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5.7-pre1 fix for api-caused ipmr.c compile failure
Message-ID: <20020314221044.GB17566@kobayashi.soze.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Organization: People for the Ethical Treatment of Email
X-Message-Flag: This message may contain privileged information
X-PGP-Fingerprint: 9AE2 9FC3 D98B 9AE2 EE83  15CC 9C7D 1925 4568 5243
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

missed in some api change...

--- linux-2.5.6/net/ipv4/ipmr.c.orig	Thu Mar 14 22:04:28 2002
+++ linux-2.5.6/net/ipv4/ipmr.c	Thu Mar 14 22:03:54 2002
@@ -855,7 +855,7 @@
 	switch(optname)
 	{
 		case MRT_INIT:
-			if(sk->type!=SOCK_RAW || sk->num!=IPPROTO_IGMP)
+			if(sk->type!=SOCK_RAW || inet_sk(sk)->num!=IPPROTO_IGMP)
 				return -EOPNOTSUPP;
 			if(optlen!=sizeof(int))
 				return -ENOPROTOOPT;

-- 
Nature has made up her mind that  |  None learned the art of archery
what cannot defend itself shall   |  from me who did not make me, in the
not be defended. --Ralph Emerson  |  end, the target.  --Saadi of Shiraz
