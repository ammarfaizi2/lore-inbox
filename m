Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264769AbTFLGqm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 02:46:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264765AbTFLGpp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 02:45:45 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:18640 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264766AbTFLGpL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 02:45:11 -0400
Date: Thu, 12 Jun 2003 12:35:10 +0530
From: Ravikiran G Thirumalai <kiran@in.ibm.com>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patchset] Fix sign handling bugs in 2.5 -- 1/5; Decnet
Message-ID: <20030612070508.GB1146@llm08.in.ibm.com>
References: <20030612070330.GA1146@llm08.in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030612070330.GA1146@llm08.in.ibm.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- linux-2.5.70/net/decnet/af_decnet.c	2003-05-27 06:30:40.000000000 +0530
+++ signfixes-2.5.70/net/decnet/af_decnet.c	2003-06-10 23:27:45.000000000 +0530
@@ -1227,7 +1227,7 @@
 	struct sock *sk = sock->sk;
 	struct dn_scp *scp = DN_SK(sk);
 	int err = -EOPNOTSUPP;
-	unsigned long amount = 0;
+	long amount = 0;
 	struct sk_buff *skb;
 	int val;
 
