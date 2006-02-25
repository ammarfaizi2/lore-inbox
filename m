Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030245AbWBYN1d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030245AbWBYN1d (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 08:27:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030247AbWBYN1c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 08:27:32 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:51461 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1030246AbWBYN1a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 08:27:30 -0500
Date: Sat, 25 Feb 2006 14:27:29 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, davem@davemloft.net, acme@conectiva.com.br
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [-mm patch] net/dccp/ipv4.c: make struct dccp_v4_prot static
Message-ID: <20060225132729.GP3674@stusta.de>
References: <20060224031002.0f7ff92a.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060224031002.0f7ff92a.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 24, 2006 at 03:10:02AM -0800, Andrew Morton wrote:
>...
> Changes since 2.6.16-rc4-mm1:
>...
>  git-net.patch
>...
>  git trees.
>...


There's no reason for struct dccp_v4_prot being global.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.16-rc4-mm2-full/net/dccp/ipv4.c.old	2006-02-25 04:32:45.000000000 +0100
+++ linux-2.6.16-rc4-mm2-full/net/dccp/ipv4.c	2006-02-25 04:32:53.000000000 +0100
@@ -1022,7 +1022,7 @@
 	.twsk_obj_size	= sizeof(struct inet_timewait_sock),
 };
 
-struct proto dccp_v4_prot = {
+static struct proto dccp_v4_prot = {
 	.name			= "DCCP",
 	.owner			= THIS_MODULE,
 	.close			= dccp_close,

