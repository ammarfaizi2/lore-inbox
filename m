Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268051AbUJLX1Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268051AbUJLX1Q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 19:27:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268079AbUJLX1Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 19:27:16 -0400
Received: from mail07.syd.optusnet.com.au ([211.29.132.188]:57239 "EHLO
	mail07.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S268051AbUJLX1N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 19:27:13 -0400
References: <416BC26B.6090603@kolivas.org> <20041012180949.GW5414@waste.org> <416C5122.9040001@kolivas.org> <20041012215732.GV31237@waste.org>
Message-ID: <cone.1097623606.213849.12364.502@pc.kolivas.org>
X-Mailer: http://www.courier-mta.org/cone/
From: Con Kolivas <kernel@kolivas.org>
To: Matt Mackall <mpm@selenic.com>
Cc: Con Kolivas <kernel@kolivas.org>, netdev@oss.sgi.com,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       davem@redhat.com, Jeff Garzik <jgarzik@pobox.com>
Subject: [PATCH]b44poll - whitespace
Date: Wed, 13 Oct 2004 09:26:46 +1000
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_pc.kolivas.org-1097623606-0000"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_pc.kolivas.org-1097623606-0000
Content-Type: text/plain; format=flowed; charset="US-ASCII"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

>> >+       disable_irq(dev->irq);
>> >+       b44_interrupt (dev->irq, dev, NULL);
>> >+       enable_irq(dev->irq);
>> >
> Stray space between b44_interrupt and args. 

Must have had my eyes closed. Trivial cleanup patch attached, thanks.

Con


--=_pc.kolivas.org-1097623606-0000
Content-Description: b44poll-ws.diff
Content-Disposition: inline;
  FILENAME="b44poll-ws.diff"
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

Index: linux-2.6.9-rc4-ck1/drivers/net/b44.c
===================================================================
--- linux-2.6.9-rc4-ck1.orig/drivers/net/b44.c	2004-10-12 21:28:12.000000000 +1000
+++ linux-2.6.9-rc4-ck1/drivers/net/b44.c	2004-10-13 09:24:46.064825491 +1000
@@ -1309,7 +1309,7 @@ err_out_free:
 static void b44_poll_controller(struct net_device *dev)
 {
 	disable_irq(dev->irq);
-	b44_interrupt (dev->irq, dev, NULL);
+	b44_interrupt(dev->irq, dev, NULL);
 	enable_irq(dev->irq);
 }
 #endif

--=_pc.kolivas.org-1097623606-0000--
