Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264934AbUEYPo4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264934AbUEYPo4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 11:44:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264928AbUEYPoz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 11:44:55 -0400
Received: from rrcs-central-24-106-242-83.biz.rr.com ([24.106.242.83]:33438
	"EHLO viper.vortech.net") by vger.kernel.org with ESMTP
	id S264912AbUEYPop (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 11:44:45 -0400
From: Joshua Jackson <linux-kernel@vortech.net>
Reply-To: linux-kernel@vortech.net
Organization: Vortech Consulting
To: linux-kernel@vger.kernel.org
Subject: VLAN startup info patch
Date: Tue, 25 May 2004 11:44:44 -0400
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_sn2sAMykkrlfKcr"
Message-Id: <200405251144.44507.linux-kernel@vortech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_sn2sAMykkrlfKcr
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Attached is a patch against the 2.4.26 802.1q vlan support header 
(kernel/linux/net/8021q/vlan.h) to make the startup info obey the "quiet" 
kernel parameter.

Currently, it will dump its copyright information even if the quiet parameter 
is specified... including an "all bugs added by" "buggyright" message, which 
tends to confuse some people when it is the only thing displayed durring 
boot.

--
Joshua Jackson
Vortech Consulting, LLC
http://www.vortech.net

--Boundary-00=_sn2sAMykkrlfKcr
Content-Type: text/x-diff;
  charset="us-ascii";
  name="vlan.h.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="vlan.h.patch"

--- vlan.h.orig	2004-05-25 11:34:49.000000000 -0400
+++ vlan.h	2004-05-25 11:35:00.000000000 -0400
@@ -7,7 +7,7 @@
 /* #define VLAN_DEBUG */
 
 #define VLAN_ERR KERN_ERR
-#define VLAN_INF KERN_ALERT
+#define VLAN_INF KERN_INFO
 #define VLAN_DBG KERN_ALERT /* change these... to debug, having a hard time
                              * changing the log level at run-time..for some reason.
                              */

--Boundary-00=_sn2sAMykkrlfKcr--
