Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129529AbRB0C4t>; Mon, 26 Feb 2001 21:56:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129535AbRB0C4d>; Mon, 26 Feb 2001 21:56:33 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:51344 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S129529AbRB0C4R>;
	Mon, 26 Feb 2001 21:56:17 -0500
Message-ID: <3A9B174D.6B9A3C9C@mandrakesoft.com>
Date: Mon, 26 Feb 2001 21:56:13 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Mike McLagan <mike.mclagan@linux.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dlci: update last_rx after netif_rx
In-Reply-To: <20010226221151.X8692@conectiva.com.br>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arnaldo Carvalho de Melo wrote:
> --- linux-2.4.2/drivers/net/wan/dlci.c  Tue Feb 13 19:15:05 2001
> +++ linux-2.4.2.acme/drivers/net/wan/dlci.c     Mon Feb 26 23:43:25 2001
> @@ -229,6 +229,7 @@
>                 skb_pull(skb, header);
>                 netif_rx(skb);
>                 dlp->stats.rx_packets++;
> +               dev->last_rx = jiffies;

You need to update dlp->stats.rx_bytes too.

-- 
Jeff Garzik       | "You see, in this world there's two kinds of
Building 1024     |  people, my friend: Those with loaded guns
MandrakeSoft      |  and those who dig. You dig."  --Blondie
