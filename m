Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265981AbUHAO2K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265981AbUHAO2K (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Aug 2004 10:28:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265986AbUHAO2K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Aug 2004 10:28:10 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:34522 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S265981AbUHAO2F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Aug 2004 10:28:05 -0400
Date: Sun, 1 Aug 2004 16:27:59 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Stephen Hemminger <shemminger@osdl.org>
Cc: linux-kernel@vger.kernel.org, davem@redhat.com, netdev@oss.sgi.com
Subject: [2.4 patch] CONFIG_NET_SCH_NETEM Configure.help entry
Message-ID: <20040801142759.GQ2746@fs.tum.de>
References: <20040731142658.GA6497@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040731142658.GA6497@logos.cnet>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 31, 2004 at 11:26:59AM -0300, Marcelo Tosatti wrote:
>...
> Summary of changes from v2.4.27-rc3 to v2.4.27-rc4
> ============================================
>...
> Stephen Hemminger:
>   o [PKT_SCHED]: Update to network emulation QOS scheduler
>   o [PKT_SCHED]: One small netem fixes
>   o [BRIDGE]: Fix assertion failure in 2.4.27-rc3
>   o [PKT_SCHED]: netem update for 2.4
>...


The Configure.help entry was forgotten:


Signed-off-by: Adrian Bunk <bunk@fs.tum.de>

--- linux-2.4.27-rc4-full/Documentation/Configure.help.old	2004-08-01 16:20:15.000000000 +0200
+++ linux-2.4.27-rc4-full/Documentation/Configure.help	2004-08-01 16:22:23.000000000 +0200
@@ -10949,13 +10949,15 @@
   whenever you want). If you want to compile it as a module, say M
   here and read <file:Documentation/modules.txt>.
 
-Network delay simualtor  
-CONFIG_NET_SCH_DELAY
-  Say Y if you want to delay packets by a fixed amount of
-  time. This is often useful to simulate network delay when
+CONFIG_NET_SCH_NETEM
+  Say Y if you want to emulate network delay, loss, and packet
+  re-ordering. This is often useful to simulate networks when
   testing applications or protocols.
-  
-  This code is also available as a module called sch_delay.o
+
+  To compile this driver as a module, choose M here: the module
+  will be called sch_netem.
+
+  If unsure, say N.
 
 Ingress Qdisc
 CONFIG_NET_SCH_INGRESS

