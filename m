Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262982AbTIAQB5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 12:01:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262987AbTIAQB5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 12:01:57 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:41382 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262982AbTIAQBe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 12:01:34 -0400
Message-ID: <3F536D52.3030204@pobox.com>
Date: Mon, 01 Sep 2003 12:01:22 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Paolo Ornati <javaman@katamail.com>
CC: marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.4.22][RESEND] small config fix for ISDN
References: <200309011554.00720.javaman@katamail.com>
In-Reply-To: <200309011554.00720.javaman@katamail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paolo Ornati wrote:
> Hi,
> 
> trying to install modules in 2.4.22 I get this error:
> depmod: *** Unresolved symbols in /lib/modules/2.4.22/kernel/drivers/isdn/isdn.o
> depmod: 	sk_run_filter
> depmod: 	sk_chk_filter
> 
> this is the fix for drivers/isdn/Config.in, please apply:
> 
> --- drivers/isdn/Config.in.orig	2003-08-31 13:23:25.000000000 +0200
> +++ drivers/isdn/Config.in	2003-08-31 13:29:31.000000000 +0200
> @@ -8,7 +8,7 @@
>  if [ "$CONFIG_INET" != "n" ]; then
>     bool '  Support synchronous PPP' CONFIG_ISDN_PPP
>     if [ "$CONFIG_ISDN_PPP" != "n" ]; then
> -      bool         '    PPP filtering for ISDN' CONFIG_IPPP_FILTER $CONFIG_FILTER
> +      dep_bool     '    PPP filtering for ISDN' CONFIG_IPPP_FILTER $CONFIG_FILTER
>        bool         '    Use VJ-compression with synchronous PPP' CONFIG_ISDN_PPP_VJ
>        bool         '    Support generic MP (RFC 1717)' CONFIG_ISDN_MPP
>        dep_tristate '    Support BSD compression' CONFIG_ISDN_PPP_BSDCOMP $CONFIG_ISDN


agreed, looks good.

