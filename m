Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265956AbTGDJ3V (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jul 2003 05:29:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265957AbTGDJ3V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jul 2003 05:29:21 -0400
Received: from sea2-f12.sea2.hotmail.com ([207.68.165.12]:54030 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S265956AbTGDJ3L
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jul 2003 05:29:11 -0400
X-Originating-IP: [194.7.240.2]
X-Originating-Email: [lode_leroy@hotmail.com]
From: "lode leroy" <lode_leroy@hotmail.com>
To: linux-kernel@vger.kernel.org
Cc: mj@atrey.karlin.mff.cuni.cz
Subject: [PATCH] 2.5.70 - display bootserver in /proc/net/pnp (net/ipv4/ipconfig.c)
Date: Fri, 04 Jul 2003 11:43:38 +0200
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <Sea2-F12IzpNcedZhot0000b4f8@hotmail.com>
X-OriginalArrivalTime: 04 Jul 2003 09:43:38.0342 (UTC) FILETIME=[BEBC3060:01C34210]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I would like to submit a trivial enhancement to display
the ip address of the bootserver in /proc/net/pnp

This aids me in developing a diskless linux root image
to know where it comes from...

please kindly apply this to the current linux 2.7.x tree

-- lode


# diff -u net/ipv4/ipconfig.{orig,c}
--- net/ipv4/ipconfig.orig      2003-05-27 03:00:21.000000000 +0200
+++ net/ipv4/ipconfig.c 2003-07-04 11:17:30.000000000 +0200
@@ -1115,6 +1115,9 @@
                                       "nameserver %u.%u.%u.%u\n",
                                       NIPQUAD(ic_nameservers[i]));
        }
+       len += sprintf(buffer + len,
+                      "bootserver %u.%u.%u.%u\n",
+                      NIPQUAD(ic_servaddr));

        if (offset > len)
                offset = len;

_________________________________________________________________
Receive your Hotmail & Messenger messages on your mobile phone with MSN 
Mobile http://www.msn.be/gsm/smsservices

