Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129478AbRB0CUv>; Mon, 26 Feb 2001 21:20:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129491AbRB0CUb>; Mon, 26 Feb 2001 21:20:31 -0500
Received: from 2-113.cwb-adsl.telepar.net.br ([200.193.161.113]:19439 "HELO
	brinquedo.distro.conectiva") by vger.kernel.org with SMTP
	id <S129464AbRB0CU2>; Mon, 26 Feb 2001 21:20:28 -0500
Date: Mon, 26 Feb 2001 21:41:20 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, Jochen Friedrich <jochen@scram.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] tms380tr: update last_rx after netif_rx
Message-ID: <20010226214120.S8692@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Jochen Friedrich <jochen@scram.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20010226211403.N8692@conectiva.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.14i
In-Reply-To: <20010226211403.N8692@conectiva.com.br>; from acme@conectiva.com.br on Mon, Feb 26, 2001 at 09:14:03PM -0300
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

	Please consider applying.

- Arnaldo

--- linux-2.4.2/drivers/net/tokenring/tms380tr.c	Fri Feb 16 22:02:36 2001
+++ linux-2.4.2.acme/drivers/net/tokenring/tms380tr.c	Mon Feb 26 23:11:51 2001
@@ -2203,6 +2203,7 @@
 				skb_trim(skb,Length);
 				skb->protocol = tr_type_trans(skb,dev);
 				netif_rx(skb);
+				dev->last_rx = jiffies;
 			}
 		}
 		else	/* Invalid frame */
