Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269057AbUJUMcb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269057AbUJUMcb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 08:32:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268436AbUJTQ1P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 12:27:15 -0400
Received: from fire.osdl.org ([65.172.181.4]:41606 "EHLO fire-1.osdl.org")
	by vger.kernel.org with ESMTP id S268534AbUJTQR4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 12:17:56 -0400
Date: Wed, 20 Oct 2004 09:18:46 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: Jeff Chua <jeffchua@silk.corp.fedex.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, netdev@oss.sgi.com,
       linux-net@vger.kernel.org, LARTC@mailman.ds9a.nl
Subject: Re: [ANNOUNCE] iproute2 2.6.9-041019
Message-Id: <20041020091846.5151604e@zqx3.pdx.osdl.net>
In-Reply-To: <Pine.LNX.4.61.0410200805110.8475@boston.corp.fedex.com>
References: <41758014.4080502@osdl.org>
	<Pine.LNX.4.61.0410200805110.8475@boston.corp.fedex.com>
Organization: Open Source Development Lab
X-Mailer: Sylpheed version 0.9.10claws (GTK+ 1.2.10; i686-suse-linux)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Similar problem to ss in iptunnel. It was including asm/byteorder.h
a kernel header that it didn't need to.

diff -Nru a/ip/iptunnel.c b/ip/iptunnel.c
--- a/ip/iptunnel.c	2004-10-20 09:18:36 -07:00
+++ b/ip/iptunnel.c	2004-10-20 09:18:36 -07:00
@@ -26,7 +26,6 @@
 #include <netinet/in.h>
 #include <arpa/inet.h>
 #include <sys/ioctl.h>
-#include <asm/byteorder.h>
 #include <linux/if.h>
 #include <linux/if_arp.h>
 #include <linux/ip.h>
