Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751277AbWFNJDm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751277AbWFNJDm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 05:03:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751278AbWFNJDm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 05:03:42 -0400
Received: from mail.gmx.net ([213.165.64.21]:11156 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751277AbWFNJDl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 05:03:41 -0400
X-Authenticated: #20022210
Message-ID: <448FD0EB.8010401@gmx.net>
Date: Wed, 14 Jun 2006 11:03:39 +0200
From: Marc Sowen <marc.sowen@gmx.net>
User-Agent: Thunderbird 1.5.0.4 (Windows/20060516)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] com20020_cs, kernel 2.6.17-rc6, 2nd try
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everybody,

this patch enables the com20020_cs arcnet driver to see the SoHard (now Mercury Computer Systems Inc.) SH ARC-PCMCIA card. I haven't tested it 
thoroughly yet, though. I hope this email format is better now. This is my first patch, so I don't know if I'm doing it right. If not, please send me 
an email about it.

Regards,
  Marc


--- a/linux-2.6.17-rc6/drivers/net/pcmcia/com20020_cs.c 2006-06-06 02:57:02.000000000 +0200
+++ b/linux-2.6.17-rc6/drivers/net/pcmcia/com20020_cs.c 2006-06-13 17:10:03.000000000 +0200
@@ -388,6 +388,7 @@

  static struct pcmcia_device_id com20020_ids[] = {
         PCMCIA_DEVICE_PROD_ID12("Contemporary Control Systems, Inc.", "PCM20 Arcnet Adapter", 0x59991666, 0x95dfffaf),
+       PCMCIA_DEVICE_PROD_ID12("SoHard AG", "SH ARC PCMCIA", 0xf8991729, 0x69dff0c7),
         PCMCIA_DEVICE_NULL
  };
  MODULE_DEVICE_TABLE(pcmcia, com20020_ids);
