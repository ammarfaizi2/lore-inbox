Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264526AbTK0OVb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Nov 2003 09:21:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264527AbTK0OVb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Nov 2003 09:21:31 -0500
Received: from pool-151-203-223-5.bos.east.verizon.net ([151.203.223.5]:5208
	"EHLO droundy.dyndns.org") by vger.kernel.org with ESMTP
	id S264526AbTK0OVa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Nov 2003 09:21:30 -0500
Date: Thu, 27 Nov 2003 09:21:26 -0500
From: David Roundy <droundy@abridgegame.org>
To: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.6]: IPv4: strcpy -> strlcpy
Message-ID: <20031127142125.GG8276@jdj5.mit.edu>
Mail-Followup-To: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
References: <1069941882.1680.2.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1069941882.1680.2.camel@teapot.felipe-alfaro.com>
X-Uptime: 06:05:38 up 9 days, 10:46, 12 users,  load average: 2.14, 0.90, 0.56
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 27, 2003 at 03:04:42PM +0100, Felipe Alfaro Solana wrote:
> diff -uNr linux-2.6.0-test11.orig/net/core/dev.c linux-2.6.0-test11/net/core/dev.c
> +++ linux-2.6.0-test11/net/core/dev.c	2003-11-27 13:21:12.791315993 +0100
> @@ -335,7 +335,7 @@
>  	for (i = 0; i < NETDEV_BOOT_SETUP_MAX; i++) {
>  		if (s[i].name[0] == '\0' || s[i].name[0] == ' ') {
>  			memset(s[i].name, 0, sizeof(s[i].name));
> -			strcpy(s[i].name, name);
> +			strlcpy(s[i].name, name, sizeof(s[i].map));
                                                             ^^^
I believe this should be name.
-- 
David Roundy
http://www.abridgegame.org
