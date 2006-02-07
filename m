Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964923AbWBGBgD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964923AbWBGBgD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 20:36:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932438AbWBGBgD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 20:36:03 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:14721 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S932441AbWBGBgA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 20:36:00 -0500
Date: Mon, 6 Feb 2006 17:42:41 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: torvalds@osdl.org
Subject: Re: Linux 2.6.15.3
Message-ID: <20060207014241.GD4483@sorel.sous-sol.org>
References: <20060207014122.GC4483@sorel.sous-sol.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060207014122.GC4483@sorel.sous-sol.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff --git a/Makefile b/Makefile
index 76a00d4..a88ae43 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 VERSION = 2
 PATCHLEVEL = 6
 SUBLEVEL = 15
-EXTRAVERSION = .2
+EXTRAVERSION = .3
 NAME=Sliding Snow Leopard
 
 # *DOCUMENTATION*
diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
index 92e23b2..84de934 100644
--- a/net/ipv4/icmp.c
+++ b/net/ipv4/icmp.c
@@ -524,7 +524,7 @@ void icmp_send(struct sk_buff *skb_in, i
 					  iph->tos;
 
 	if (ip_options_echo(&icmp_param.replyopts, skb_in))
-		goto ende;
+		goto out_unlock;
 
 
 	/*
