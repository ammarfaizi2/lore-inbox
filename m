Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267808AbTBROTQ>; Tue, 18 Feb 2003 09:19:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267821AbTBROTQ>; Tue, 18 Feb 2003 09:19:16 -0500
Received: from tag.witbe.net ([81.88.96.48]:34063 "EHLO tag.witbe.net")
	by vger.kernel.org with ESMTP id <S267808AbTBROTP>;
	Tue, 18 Feb 2003 09:19:15 -0500
From: "Paul Rolland" <rol@as2917.net>
To: <linux-kernel@vger.kernel.org>
Subject: Recovering .config from vmlinuz and System.map
Date: Tue, 18 Feb 2003 15:29:16 +0100
Message-ID: <012a01c2d75a$1d7b8d20$3f00a8c0@witbe>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3416
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I've a box running a linux 2.4.18-14 (RH stuff), for which I've lost
the .config file...

I've gone through a long .config recovery process by looking at the
entries in System.map, changing the configuration, building the kernel,
diffing the new System.map with the reference one, again and again.

The diff process was done only on the symbol names and the last diff
states :
diff -urN System.map-9 System.map-2.4.18-sound | less
--- System.map-9        Tue Feb 18 13:36:33 2003
+++ System.map-2.4.18-sound     Tue Feb 18 09:47:47 2003
@@ -10776,6 +10776,7 @@
 d __setup_str_console_setup
 d __setup_str_reserve_setup
 d startup.0
+d configs
 d zone_balance_ratio
 d zone_balance_min
 d zone_balance_max

Could someone direct me to where is located this "configs" stuff
that I can't find ?

Second question : the addresses in front of the symbols don't match
(except for the first ones)... I'm using the same kernel tree, the
same compiler... Any idea ? First diff is :
--- /usr/src/linux/System.map   Tue Feb 18 14:12:14 2003
+++ /boot/System.map-2.4.18-sound       Wed Nov 20 17:52:19 2002
@@ -441,244 +441,244 @@
 c010d380 T sys_modify_ldt
 c010d3de t .text.lock.ldt
 c010d400 t show_cpuinfo
-c010d5f0 t c_start
-c010d620 t c_next
-c010d640 t c_stop
...
+c010d5e0 t c_start
+c010d610 t c_next
+c010d630 t c_stop
...

Thanks in advance,

Paul


