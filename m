Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264844AbTGBIuJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 04:50:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264861AbTGBIuJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 04:50:09 -0400
Received: from a089197.adsl.hansenet.de ([213.191.89.197]:40883 "EHLO
	sfhq.hn.org") by vger.kernel.org with ESMTP id S264860AbTGBIuC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 04:50:02 -0400
Message-ID: <3F02A019.3040504@tu-harburg.de>
Date: Wed, 02 Jul 2003 11:04:25 +0200
From: Jan Dittmer <jan.dittmer@tu-harburg.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030524 Debian/1.3.1-1.he-1
X-Accept-Language: en
MIME-Version: 1.0
To: linux-net@vger.kernel.org
CC: linux-kernel@vger.kernel.org
Subject: pppoe, fix old protocol handler
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm using 2.5(.73-mm3, but this also applies to earlier versions) and 
I'm getting tons (~6000/min) of "fix old protocol handler <pppoed>!" in 
my syslog on a quite loaded adsl line. For the time being I just 
commented out the annoying code fragment  and I didn't find any 
regressions yet (uptime ~20days).
So what's the correct way of getting rid of this message? I tried 
recompiling pppd and pppoe, but that doesn't solve it. Is there a 
patched version somewhere.

Thanks,

Jan

pppd version 2.4.2b3
Roaring Penguin PPPoE Version 3.5

--- a/net/core/dev.c    Sun Jun 15 19:11:37 2003
+++ b/net/core/dev.c    Sun Jun 15 19:11:53 2003
@@ -1370,8 +1370,8 @@
  #ifdef CONFIG_SMP
         /* Old protocols did not depened on BHs different of NET_BH and
            TIMER_BH - they need to be fixed for the new assumptions.
-        */
         print_symbol("fix old protocol handler %s!\n", (unsigned 
long)pt->func);
+        */
  #endif
         ret = pt->func(skb, skb->dev, pt);
  out:

