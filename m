Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261902AbULGUJA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261902AbULGUJA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 15:09:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261906AbULGUJA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 15:09:00 -0500
Received: from fw.osdl.org ([65.172.181.6]:23986 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261902AbULGUHL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 15:07:11 -0500
Date: Tue, 7 Dec 2004 12:07:10 -0800
From: Chris Wright <chrisw@osdl.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] binfmt_script.c: make struct script_format static (fwd)
Message-ID: <20041207120710.B469@build.pdx.osdl.net>
References: <20041207193518.GB7250@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20041207193518.GB7250@stusta.de>; from bunk@stusta.de on Tue, Dec 07, 2004 at 08:35:18PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Adrian Bunk (bunk@stusta.de) wrote:
> The patch forwarded below still applies and compiles against 
> 2.6.10-rc2-mm4.
> 
> Please apply.

Yup, also binfmt_em86.c (are there any users of it?).

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net


Make em86_format static.

Signed-off-by: Chris Wright <chrisw@osdl.org>

===== fs/binfmt_em86.c 1.8 vs edited =====
--- 1.8/fs/binfmt_em86.c	2004-05-10 04:25:55 -07:00
+++ edited/fs/binfmt_em86.c	2004-12-07 12:06:00 -08:00
@@ -95,7 +95,7 @@ static int load_em86(struct linux_binprm
 	return search_binary_handler(bprm, regs);
 }
 
-struct linux_binfmt em86_format = {
+static struct linux_binfmt em86_format = {
 	.module		= THIS_MODULE,
 	.load_binary	= load_em86,
 };
