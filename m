Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317392AbSINRsa>; Sat, 14 Sep 2002 13:48:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317393AbSINRs3>; Sat, 14 Sep 2002 13:48:29 -0400
Received: from s2.org ([195.197.64.39]:21670 "EHLO kalahari.s2.org")
	by vger.kernel.org with ESMTP id <S317392AbSINRs3>;
	Sat, 14 Sep 2002 13:48:29 -0400
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2.4.20-pre7] net/ipv4/netfilter/ip_conntrack_ftp and _irc to export objs
From: Jarno Paananen <jpaana@s2.org>
Date: 14 Sep 2002 20:53:22 +0300
Message-ID: <m3vg58qwz1.fsf@kalahari.s2.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Honest Recruiter)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

the two modules mentioned export symbols but are not mentioned in
export-objs in Makefile and thus give errors. Patch attached.

// Jarno

--- net/ipv4/netfilter/Makefile.bak	2002-09-14 19:50:38.000000000 +0300
+++ net/ipv4/netfilter/Makefile	2002-09-14 19:51:28.000000000 +0300
@@ -9,7 +9,7 @@
 
 O_TARGET := netfilter.o
 
-export-objs = ip_conntrack_standalone.o ip_fw_compat.o ip_nat_standalone.o ip_tables.o arp_tables.o
+export-objs = ip_conntrack_standalone.o ip_fw_compat.o ip_nat_standalone.o ip_tables.o arp_tables.o ip_conntrack_ftp.o ip_conntrack_irc.o
 
 # Multipart objects.
 list-multi		:= ip_conntrack.o iptable_nat.o ipfwadm.o ipchains.o
