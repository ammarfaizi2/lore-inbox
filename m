Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135491AbREEVnG>; Sat, 5 May 2001 17:43:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135463AbREEVmq>; Sat, 5 May 2001 17:42:46 -0400
Received: from [200.181.138.61] ([200.181.138.61]:35832 "HELO
	brinquedo.distro.conectiva") by vger.kernel.org with SMTP
	id <S135491AbREEVmm>; Sat, 5 May 2001 17:42:42 -0400
Date: Sat, 5 May 2001 00:46:48 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: davem@redhat.com
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: [PATCH] tcp.c: TCP_LINGER2 small bug
Message-ID: <20010505004648.C2859@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	davem@redhat.com, Alan Cox <alan@lxorguk.ukuu.org.uk>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

	Please apply.

- Arnaldo

--- linux-2.4.4-ac5/net/ipv4/tcp.c	Sat May  5 18:24:59 2001
+++ linux-2.4.4-ac5.acme/net/ipv4/tcp.c	Sat May  5 18:33:32 2001
@@ -2352,7 +2352,7 @@
 		break;
 	case TCP_LINGER2:
 		val = tp->linger2;
-		if (val > 0)
+		if (val >= 0)
 			val = (val ? : sysctl_tcp_fin_timeout)/HZ;
 		break;
 	case TCP_DEFER_ACCEPT:
