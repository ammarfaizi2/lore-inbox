Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261352AbTFHKGf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jun 2003 06:06:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261324AbTFHKGf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jun 2003 06:06:35 -0400
Received: from bart.one-2-one.net ([217.115.142.76]:55556 "EHLO
	bart.webpack.hosteurope.de") by vger.kernel.org with ESMTP
	id S261323AbTFHKGd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jun 2003 06:06:33 -0400
Date: Sun, 8 Jun 2003 11:40:56 +0200 (CEST)
From: Martin Diehl <lists@mdiehl.de>
X-X-Sender: martin@notebook.home.mdiehl.de
To: Adrian Bunk <bunk@fs.tum.de>
cc: Jean Tourrilhes <jt@bougret.hpl.hp.com>, <linux-net@vger.kernel.org>,
       <linux-kernel@vger.kernel.org>, <trivial@rustcorp.com.au>
Subject: Re: [patch] fix vlsi_ir.c compile if !CONFIG_PROC_FS
In-Reply-To: <20030607152434.GQ15311@fs.tum.de>
Message-ID: <Pine.LNX.4.44.0306081100560.1643-100000@notebook.home.mdiehl.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 7 Jun 2003, Adrian Bunk wrote:

> drivers/net/irda/vlsi_ir.c: In function `vlsi_mod_exit':
> drivers/net/irda/vlsi_ir.c:2047: `PROC_DIR' undeclared (first use in this function)

Thank you for finding this! Actually, I had something similar to your 
patch

> +#ifdef CONFIG_PROC_FS
>  	remove_proc_entry(PROC_DIR, 0);
> +#endif

already pending here, but the proc-stuff in vlsi_ir needs some more 
fixing. Patch will follow.

Martin

