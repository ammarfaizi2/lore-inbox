Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030216AbWFTKP2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030216AbWFTKP2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 06:15:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030218AbWFTKP1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 06:15:27 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:54659 "EHLO
	sequoia.sous-sol.org") by vger.kernel.org with ESMTP
	id S1030216AbWFTKP1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 06:15:27 -0400
Date: Tue, 20 Jun 2006 03:14:27 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: torvalds@osdl.org
Subject: Re: Linux 2.6.17.1
Message-ID: <20060620101427.GF23467@sequoia.sous-sol.org>
References: <20060620101350.GE23467@sequoia.sous-sol.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060620101350.GE23467@sequoia.sous-sol.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff --git a/Makefile b/Makefile
index 1700d3f..8bafed1 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 VERSION = 2
 PATCHLEVEL = 6
 SUBLEVEL = 17
-EXTRAVERSION =
+EXTRAVERSION = .1
 NAME=Crazed Snow-Weasel
 
 # *DOCUMENTATION*
diff --git a/net/netfilter/xt_sctp.c b/net/netfilter/xt_sctp.c
index 34bd872..c29692c 100644
--- a/net/netfilter/xt_sctp.c
+++ b/net/netfilter/xt_sctp.c
@@ -62,7 +62,7 @@ #endif
 
 	do {
 		sch = skb_header_pointer(skb, offset, sizeof(_sch), &_sch);
-		if (sch == NULL) {
+		if (sch == NULL || sch->length == 0) {
 			duprintf("Dropping invalid SCTP packet.\n");
 			*hotdrop = 1;
 			return 0;
