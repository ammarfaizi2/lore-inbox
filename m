Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264296AbTLBDVh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Dec 2003 22:21:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264290AbTLBDVh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Dec 2003 22:21:37 -0500
Received: from mtvcafw.SGI.COM ([192.48.171.6]:22618 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id S264270AbTLBDVf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Dec 2003 22:21:35 -0500
X-Mailer: exmh version 2.5 01/15/2001 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Matthew Bell <m.bell@bvrh.co.uk>
Cc: becker@scyld.com, linux-net@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][OBVIOUS] 3c515.c: Enable ISAPNP when built as a module. 
In-reply-to: Your message of "Tue, 02 Dec 2003 02:40:28 -0000."
             <20031202024028.49265a8f.m.bell@bvrh.co.uk> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 02 Dec 2003 14:20:15 +1100
Message-ID: <1778.1070335215@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Dec 2003 02:40:28 +0000, 
Matthew Bell <m.bell@bvrh.co.uk> wrote:
>--- linux-2.4.19.orig/drivers/net/3c515.c       2002-02-25 19:37:59.000000000
>+0000
>+++ linux-2.4.19/drivers/net/3c515.c    2002-08-03 18:24:05.000000000 +0100
>@@ -370,7 +370,7 @@
>        { "Default", 0, 0xFF, XCVR_10baseT, 10000},
> };
>                                                                                
>                                                             
>-#ifdef CONFIG_ISAPNP
>+#if defined(CONFIG_ISAPNP) || (defined (MODULE) && defined
>(CONFIG_ISAPNP_MODULE))

Your mailer wrapped the lines.

Only test CONFIG_ISAPNP || CONFIG_ISAPNP_MODULE, not MODULE.
CONFIG_foo_MODULE can only be defined when MODULE is defined.

#if defined(CONFIG_ISAPNP) || defined(CONFIG_ISAPNP_MODULE)

