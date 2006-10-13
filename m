Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751785AbWJMSMk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751785AbWJMSMk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 14:12:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751790AbWJMSMj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 14:12:39 -0400
Received: from mail.trixing.net ([87.230.125.58]:13797 "EHLO mail.trixing.net")
	by vger.kernel.org with ESMTP id S1751785AbWJMSMi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 14:12:38 -0400
Message-ID: <452FD6F6.3090907@l4x.org>
Date: Fri, 13 Oct 2006 20:12:06 +0200
From: Jan Dittmer <jdi@l4x.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.5) Gecko/20060812 Thunderbird/1.5.0.5 Mnenhy/0.7.4.666
MIME-Version: 1.0
To: Joerg Roedel <joro-lkml@zlug.org>
CC: netdev@vger.kernel.org, David Miller <davem@davemloft.net>,
       linux-kernel@vger.kernel.org
References: <20061010153745.GA27455@zlug.org>
In-Reply-To: <20061010153745.GA27455@zlug.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 192.168.1.37
X-SA-Exim-Mail-From: jdi@l4x.org
Subject: Re: [PATCH 01/02 V3] net/ipv6: seperate sit driver to extra module
X-SA-Exim-Version: 4.2.1 (built Mon, 27 Mar 2006 13:42:28 +0200)
X-SA-Exim-Scanned: Yes (on mail.trixing.net)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is missing the MODULE_LICENSE statements and taints the kernel upon
loading. License is obvious from the beginning of the file.

Joerg Roedel wrote:
> --- linux-2.6.18-vanilla/net/ipv6/sit.c	2006-09-20 05:42:06.000000000 +0200
> +++ linux-2.6.18/net/ipv6/sit.c	2006-10-05 16:55:02.000000000 +0200
> @@ -850,3 +850,6 @@ int __init sit_init(void)
>  	inet_del_protocol(&sit_protocol, IPPROTO_IPV6);
>  	goto out;
>  }
> +
> +module_init(sit_init);
> +module_exit(sit_cleanup);

Signed-off-by: Jan Dittmer <jdi@l4x.org>

--- linux-2.6-amd64/net/ipv6/sit.c~	2006-10-13 17:39:45.000000000 +0200
+++ linux-2.6-amd64/net/ipv6/sit.c	2006-10-13 17:39:49.000000000 +0200
@@ -853,3 +853,4 @@ int __init sit_init(void)

 module_init(sit_init);
 module_exit(sit_cleanup);
+MODULE_LICENSE("GPL");
