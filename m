Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265097AbTCEVzT>; Wed, 5 Mar 2003 16:55:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265567AbTCEVzT>; Wed, 5 Mar 2003 16:55:19 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:50410 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S265097AbTCEVzS>; Wed, 5 Mar 2003 16:55:18 -0500
Date: Wed, 5 Mar 2003 23:05:42 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: CaT <cat@zip.com.au>, laforge@netfilter.org
Cc: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Subject: [2.5 patch] remove EXPORT_NO_SYMBOLS from ip6tables code
Message-ID: <20030305220542.GM20423@fs.tum.de>
References: <20030305153259.GE2075@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030305153259.GE2075@zip.com.au>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 06, 2003 at 02:32:59AM +1100, CaT wrote:

>...
> net/ipv6/netfilter/ip6t_hbh.o(.bss+0x0): multiple definition of `EXPORT_NO_SYMBOLS'
> net/ipv6/netfilter/ip6t_rt.o(.bss+0x0): first defined here
>...

The patch that added new ip6tables matches in 2.5.64 added seven 
occurances of the obsolete EXPORT_NO_SYMBOLS. The patch below removes 
them.

cu
Adrian

--- linux-2.5.64-notfull/net/ipv6/netfilter/ip6t_ah.c.old	2003-03-05 22:57:24.000000000 +0100
+++ linux-2.5.64-notfull/net/ipv6/netfilter/ip6t_ah.c	2003-03-05 22:57:41.000000000 +0100
@@ -9,7 +9,6 @@
 #include <linux/netfilter_ipv6/ip6_tables.h>
 #include <linux/netfilter_ipv6/ip6t_ah.h>
 
-EXPORT_NO_SYMBOLS;
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("IPv6 AH match");
 MODULE_AUTHOR("Andras Kis-Szabo <kisza@sch.bme.hu>");
--- linux-2.5.64-notfull/net/ipv6/netfilter/ip6t_dst.c.old	2003-03-05 22:58:18.000000000 +0100
+++ linux-2.5.64-notfull/net/ipv6/netfilter/ip6t_dst.c	2003-03-05 22:58:31.000000000 +0100
@@ -15,7 +15,6 @@
 
 #define HOPBYHOP	0
 
-EXPORT_NO_SYMBOLS;
 MODULE_LICENSE("GPL");
 #if HOPBYHOP
 MODULE_DESCRIPTION("IPv6 HbH match");
--- linux-2.5.64-notfull/net/ipv6/netfilter/ip6t_esp.c.old	2003-03-05 22:59:57.000000000 +0100
+++ linux-2.5.64-notfull/net/ipv6/netfilter/ip6t_esp.c	2003-03-05 23:00:03.000000000 +0100
@@ -9,7 +9,6 @@
 #include <linux/netfilter_ipv6/ip6_tables.h>
 #include <linux/netfilter_ipv6/ip6t_esp.h>
 
-EXPORT_NO_SYMBOLS;
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("IPv6 ESP match");
 MODULE_AUTHOR("Andras Kis-Szabo <kisza@sch.bme.hu>");
--- linux-2.5.64-notfull/net/ipv6/netfilter/ip6t_frag.c.old	2003-03-05 23:00:04.000000000 +0100
+++ linux-2.5.64-notfull/net/ipv6/netfilter/ip6t_frag.c	2003-03-05 23:00:10.000000000 +0100
@@ -11,7 +11,6 @@
 #include <linux/netfilter_ipv6/ip6_tables.h>
 #include <linux/netfilter_ipv6/ip6t_frag.h>
 
-EXPORT_NO_SYMBOLS;
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("IPv6 FRAG match");
 MODULE_AUTHOR("Andras Kis-Szabo <kisza@sch.bme.hu>");
--- linux-2.5.64-notfull/net/ipv6/netfilter/ip6t_hbh.c.old	2003-03-05 23:00:11.000000000 +0100
+++ linux-2.5.64-notfull/net/ipv6/netfilter/ip6t_hbh.c	2003-03-05 23:00:17.000000000 +0100
@@ -15,7 +15,6 @@
 
 #define HOPBYHOP	1
 
-EXPORT_NO_SYMBOLS;
 MODULE_LICENSE("GPL");
 #if HOPBYHOP
 MODULE_DESCRIPTION("IPv6 HbH match");
--- linux-2.5.64-notfull/net/ipv6/netfilter/ip6t_ipv6header.c.old	2003-03-05 23:00:17.000000000 +0100
+++ linux-2.5.64-notfull/net/ipv6/netfilter/ip6t_ipv6header.c	2003-03-05 23:00:24.000000000 +0100
@@ -14,7 +14,6 @@
 #include <linux/netfilter_ipv6/ip6_tables.h>
 #include <linux/netfilter_ipv6/ip6t_ipv6header.h>
 
-EXPORT_NO_SYMBOLS;
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("IPv6 headers match");
 MODULE_AUTHOR("Andras Kis-Szabo <kisza@sch.bme.hu>");
--- linux-2.5.64-notfull/net/ipv6/netfilter/ip6t_rt.c.old	2003-03-05 23:00:24.000000000 +0100
+++ linux-2.5.64-notfull/net/ipv6/netfilter/ip6t_rt.c	2003-03-05 23:00:30.000000000 +0100
@@ -11,7 +11,6 @@
 #include <linux/netfilter_ipv6/ip6_tables.h>
 #include <linux/netfilter_ipv6/ip6t_rt.h>
 
-EXPORT_NO_SYMBOLS;
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("IPv6 RT match");
 MODULE_AUTHOR("Andras Kis-Szabo <kisza@sch.bme.hu>");
