Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268304AbUH2UuN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268304AbUH2UuN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 16:50:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268311AbUH2UuM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 16:50:12 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:38115 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S268304AbUH2Uto
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 16:49:44 -0400
Message-ID: <41324158.4020709@pobox.com>
Date: Sun, 29 Aug 2004 16:49:28 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Florian Schirmer <jolt@tuxbox.org>
CC: Pekka Pietikainen <pp@ee.oulu.fi>, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com
Subject: Re: [PATCH][1/4] b44: Ignore carrier lost errors
References: <200408292218.00756.jolt@tuxbox.org> <200408292233.03879.jolt@tuxbox.org>
In-Reply-To: <200408292233.03879.jolt@tuxbox.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Your mailer is mangling the patches.  Can you please resend without this?

The patches need to be apply-able without MIME massaging.

	Jeff



=2D-- linux/drivers/net/b44.c-old1 2004-08-29 16:29:08.000000000 +0200
+++ linux/drivers/net/b44.c 2004-08-29 16:27:00.000000000 +0200
@@ -1347,7 +1347,10 @@ static struct net_device_stats *b44_get_
         hwstat->rx_symbol_errs);
=20
   nstat->tx_aborted_errors =3D hwstat->tx_underruns;
+#if 0
+ /* Carrier lost counter seems to be broken for some devices */
   nstat->tx_carrier_errors =3D hwstat->tx_carrier_lost;
+#endif
=20
   return nstat;
  }



