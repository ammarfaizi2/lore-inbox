Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751099AbVJOKMI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751099AbVJOKMI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Oct 2005 06:12:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751104AbVJOKMI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Oct 2005 06:12:08 -0400
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:47544 "EHLO
	anf141.internetdsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S1751099AbVJOKMG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Oct 2005 06:12:06 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: 2.6.14-rc4-git3: compilation fix
Date: Sat, 15 Oct 2005 12:12:10 +0200
User-Agent: KMail/1.8.2
Cc: LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510151212.10839.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

2.6.14-rc4-git3 does not compile for me without the appended patch.

Greetings,
Rafael


Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

Index: linux-2.6.14-rc4-git3/net/ipv6/netfilter/ip6_tables.c
===================================================================
--- linux-2.6.14-rc4-git3.orig/net/ipv6/netfilter/ip6_tables.c	2005-10-15 11:29:54.000000000 +0200
+++ linux-2.6.14-rc4-git3/net/ipv6/netfilter/ip6_tables.c	2005-10-15 11:57:39.000000000 +0200
@@ -975,7 +975,6 @@
 		struct ip6t_entry *table_base;
 		unsigned int i;
 
-		for (i = 0; i < num_possible_cpus(); i++) {
 		for_each_cpu(i) {
 			table_base =
 				(void *)newinfo->entries
