Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261254AbRFHSme>; Fri, 8 Jun 2001 14:42:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262389AbRFHSmP>; Fri, 8 Jun 2001 14:42:15 -0400
Received: from xorn.math.fu-berlin.de ([160.45.45.167]:12160 "EHLO fefe.de")
	by vger.kernel.org with ESMTP id <S261254AbRFHSmI>;
	Fri, 8 Jun 2001 14:42:08 -0400
Date: Fri, 8 Jun 2001 20:42:07 +0200
From: Felix von Leitner <leitner@fefe.de>
To: linux-kernel@vger.kernel.org
Subject: diff for ipv6 RFC compatibility
Message-ID: <20010608204207.A8838@fefe.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="qMm9M+Fa2AknHoGS"
Content-Disposition: inline
User-Agent: Mutt/1.3.18i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I have been told that I should send a diff rather than complain and
expect others to make a diff.  Oops ,)

So attached is a diff.

Oh boy oh boy will I now become part of the Linux Changelog? ;)

Felix

--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=ldiff

--- linux/include/linux/in6.h	Sat May 19 02:45:08 2001
+++ linux.fefe/include/linux/in6.h	Fri Jun  8 20:37:13 2001
@@ -53,7 +53,7 @@
 	struct in6_addr ipv6mr_multiaddr;
 
 	/* local IPv6 address of interface */
-	int		ipv6mr_ifindex;
+	int		ipv6mr_interface;
 };
 
 struct in6_flowlabel_req
--- linux/net/ipv6/ipv6_sockglue.c	Mon Mar 26 04:14:25 2001
+++ linux.fefe/net/ipv6/ipv6_sockglue.c	Fri Jun  8 20:37:01 2001
@@ -346,9 +346,9 @@
 			break;
 
 		if (optname == IPV6_ADD_MEMBERSHIP)
-			retv = ipv6_sock_mc_join(sk, mreq.ipv6mr_ifindex, &mreq.ipv6mr_multiaddr);
+			retv = ipv6_sock_mc_join(sk, mreq.ipv6mr_interface, &mreq.ipv6mr_multiaddr);
 		else
-			retv = ipv6_sock_mc_drop(sk, mreq.ipv6mr_ifindex, &mreq.ipv6mr_multiaddr);
+			retv = ipv6_sock_mc_drop(sk, mreq.ipv6mr_interface, &mreq.ipv6mr_multiaddr);
 		break;
 	}
 	case IPV6_ROUTER_ALERT:

--qMm9M+Fa2AknHoGS--
