Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129493AbRB0CZn>; Mon, 26 Feb 2001 21:25:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129491AbRB0CZd>; Mon, 26 Feb 2001 21:25:33 -0500
Received: from 2-113.cwb-adsl.telepar.net.br ([200.193.161.113]:21743 "HELO
	brinquedo.distro.conectiva") by vger.kernel.org with SMTP
	id <S129486AbRB0CZ0>; Mon, 26 Feb 2001 21:25:26 -0500
Date: Mon, 26 Feb 2001 21:46:20 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, Gergely Madarasz <gorgo@itc.hu>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] comx: update last_rx after netif_rx
Message-ID: <20010226214620.T8692@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Gergely Madarasz <gorgo@itc.hu>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.14i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

	Please consider applying.

- Arnaldo

--- linux-2.4.2/drivers/net/wan/comx.c	Thu Nov 16 20:08:25 2000
+++ linux-2.4.2.acme/drivers/net/wan/comx.c	Mon Feb 26 23:17:12 2001
@@ -380,6 +380,7 @@
 	}
 	if (skb) {
 		netif_rx(skb);
+		dev->last_rx = jiffies;
 	}
 	return 0;
 }
