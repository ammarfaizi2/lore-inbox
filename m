Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261365AbVFZQJN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261365AbVFZQJN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Jun 2005 12:09:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261350AbVFZQHs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Jun 2005 12:07:48 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:15118 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261369AbVFZQFt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Jun 2005 12:05:49 -0400
Date: Sun, 26 Jun 2005 18:05:46 +0200
From: Adrian Bunk <bunk@stusta.de>
To: linux-net@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] let TCP_CONG_ADVANCED default to n
Message-ID: <20050626160546.GJ3629@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It doesn't seem to make much sense to let an "If unsure, say N." option 
default to y.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.12-mm2-full/net/ipv4/Kconfig.old	2005-06-26 14:40:17.000000000 +0200
+++ linux-2.6.12-mm2-full/net/ipv4/Kconfig	2005-06-26 14:40:43.000000000 +0200
@@ -442,19 +442,18 @@
 	  
 	  If unsure, say Y.
 
 config IP_TCPDIAG_IPV6
 	def_bool (IP_TCPDIAG=y && IPV6=y) || (IP_TCPDIAG=m && IPV6)
 
 config TCP_CONG_ADVANCED
 	bool "TCP: advanced congestion control"
 	depends on INET
-	default y
 	---help---
 	  Support for selection of various TCP congestion control
 	  modules.
 
 	  Nearly all users can safely say no here, and a safe default
 	  selection will be made (BIC-TCP with new Reno as a fallback).
 
 	  If unsure, say N.
 

