Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285264AbRLMXhJ>; Thu, 13 Dec 2001 18:37:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285263AbRLMXg7>; Thu, 13 Dec 2001 18:36:59 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:25865 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S285261AbRLMXgt>;
	Thu, 13 Dec 2001 18:36:49 -0500
Message-ID: <3C193B8E.94F769B5@mandrakesoft.com>
Date: Thu, 13 Dec 2001 18:36:46 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.17-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "really mason@soo.com" <lnx-kern@Sophia.soo.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.5.1-pre11 de2104X tulip driver problem
In-Reply-To: <20011213150346.A31843@Sophia.soo.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"really mason@soo.com" wrote:
> i'm one of those dinosaurs using a 10base2 network and really
> old DLink-530 21040 and 21041 based ethercards.
[...]
> kernel: de0: SROM-listed ports: TP

Thanks for the report.  If you are using 10base2 that's definitely a
bug.

Can you please change DE_DEF_MSG_ENABLE in de2104x.c as shown below, and
[privately] e-mail me /bin/dmesg and "lspci -vvv" output?

-#define DE_DEF_MSG_ENABLE       (NETIF_MSG_DRV          | \
-                                 NETIF_MSG_PROBE        | \
-                                 NETIF_MSG_LINK         | \
-                                 NETIF_MSG_TIMER        | \
-                                 NETIF_MSG_IFDOWN       | \
-                                 NETIF_MSG_IFUP         | \
-                                 NETIF_MSG_RX_ERR       | \
-                                 NETIF_MSG_TX_ERR)
+#define DE_DEF_MSG_ENABLE       0xffffffff

-- 
Jeff Garzik      | Only so many songs can be sung
Building 1024    | with two lips, two lungs, and one tongue.
MandrakeSoft     |         - nomeansno
