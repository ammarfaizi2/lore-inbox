Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264719AbUFLRS0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264719AbUFLRS0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jun 2004 13:18:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264877AbUFLRS0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jun 2004 13:18:26 -0400
Received: from fw.osdl.org ([65.172.181.6]:1192 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264719AbUFLRSY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jun 2004 13:18:24 -0400
Date: Sat, 12 Jun 2004 10:14:02 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Dave Clendenan <dave@dave.clendenan.ca>, akpm@osdl.org
Cc: support@stallion.oz.au, support@stallion.com, linux-kernel@vger.kernel.org
Subject: [PATCH] Re: error in linux kernel source file istallion.c
Message-Id: <20040612101402.74559edf.rddunlap@osdl.org>
In-Reply-To: <20040612164533.GA11125@dave.clendenan.ca>
References: <20040612164533.GA11125@dave.clendenan.ca>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.8a (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 12 Jun 2004 09:45:34 -0700 Dave Clendenan wrote:

| Very minor bug - printk with two '%d's and one int to print out.
| 
| Lines 853-854 of drivers/char/istallion.c (kernel 2.6.6)
| Code is an error message 'failed to un-register tty driver'


istallion: Remove duplicate "%d" in printk();

Signed-off-by: Randy Dunlap <rddunlap@osdl.org>


diffstat:=
 drivers/char/istallion.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -Naurp ./drivers/char/istallion.c~printk_fixup ./drivers/char/istallion.c
--- ./drivers/char/istallion.c~printk_fixup	2004-05-09 19:32:52.000000000 -0700
+++ ./drivers/char/istallion.c	2004-06-12 09:52:39.000000000 -0700
@@ -851,7 +851,7 @@ static void __exit istallion_module_exit
 	i = tty_unregister_driver(stli_serial);
 	if (i) {
 		printk("STALLION: failed to un-register tty driver, "
-			"errno=%d,%d\n", -i);
+			"errno=%d\n", -i);
 		restore_flags(flags);
 		return;
 	}
