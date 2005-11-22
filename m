Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965213AbVKVVLV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965213AbVKVVLV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 16:11:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965203AbVKVVKn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 16:10:43 -0500
Received: from smtp.osdl.org ([65.172.181.4]:55199 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965198AbVKVVKU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 16:10:20 -0500
Date: Tue, 22 Nov 2005 13:08:28 -0800
From: Chris Wright <chrisw@osdl.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>,
       Ville Nuorvala <vnuorval@tcs.hut.fi>
Subject: [patch 17/23] [PATCH] [IPV6]: Fix calculation of AH length during filling ancillary data.
Message-ID: <20051122210828.GR28140@shell0.pdx.osdl.net>
References: <20051122205223.099537000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="fix-calculation-of-ah-length-during.patch"
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

---
 net/ipv6/datagram.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.14.2.orig/net/ipv6/datagram.c
+++ linux-2.6.14.2/net/ipv6/datagram.c
@@ -437,7 +437,7 @@ int datagram_recv_ctl(struct sock *sk, s
 				break;
 			case IPPROTO_AH:
 				nexthdr = ptr[0];
-				len = (ptr[1] + 1) << 2;
+				len = (ptr[1] + 2) << 2;
 				break;
 			default:
 				nexthdr = ptr[0];

--
