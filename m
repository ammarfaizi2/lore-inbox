Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261351AbULNADb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261351AbULNADb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 19:03:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261352AbULNADb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 19:03:31 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:57869 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261351AbULNADZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 19:03:25 -0500
Date: Tue, 14 Dec 2004 01:03:23 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Chris Wright <chrisw@osdl.org>, linux-kernel@vger.kernel.org,
       rth@twiddle.net
Subject: Re: [2.6 patch] binfmt_script.c: make struct script_format static (fwd) (fwd)
Message-ID: <20041214000323.GN23151@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The trivial patch by Chris Wright <chrisw@osdl.org> forwarded below 
still applies against 2.6.10-rc3-mm1.

Please apply.


----- Forwarded message from Chris Wright <chrisw@osdl.org> -----

Date: Tue, 7 Dec 2004 12:07:10 -0800
From: Chris Wright <chrisw@osdl.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] binfmt_script.c: make struct script_format static (fwd)

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
Signed-off-by: Adrian Bunk <bunk@stusta.de>

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

----- End forwarded message -----

