Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263107AbUAEJKc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 04:10:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265905AbUAEJKc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 04:10:32 -0500
Received: from fw.osdl.org ([65.172.181.6]:63191 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263107AbUAEJKa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 04:10:30 -0500
Date: Mon, 5 Jan 2004 01:10:30 -0800
From: Andrew Morton <akpm@osdl.org>
To: Dax Kelson <dax@gurulabs.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       Wim Van Sebroeck <wim@iguana.be>
Subject: Re: 2.6.1-rc1-mm2
Message-Id: <20040105011030.4383b5b0.akpm@osdl.org>
In-Reply-To: <1073294151.10221.792.camel@mentor.gurulabs.com>
References: <20040105002056.43f423b1.akpm@osdl.org>
	<1073294151.10221.792.camel@mentor.gurulabs.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dax Kelson <dax@gurulabs.com> wrote:
>
> 
> build error:
> 
>   CC [M]  drivers/char/watchdog/amd7xx_tco.o
> drivers/char/watchdog/amd7xx_tco.c: In function `amdtco_fop_write':
> drivers/char/watchdog/amd7xx_tco.c:257: error: syntax error before "i"

Sorry.  This pooter, she be too slow for allyesconfig.


diff -puN drivers/char/watchdog/amd7xx_tco.c~amd7xx_tco-fix drivers/char/watchdog/amd7xx_tco.c
--- 25/drivers/char/watchdog/amd7xx_tco.c~amd7xx_tco-fix	2004-01-05 01:07:57.000000000 -0800
+++ 25-akpm/drivers/char/watchdog/amd7xx_tco.c	2004-01-05 01:08:24.000000000 -0800
@@ -253,7 +253,7 @@ static ssize_t amdtco_fop_write(struct f
 		return -ESPIPE;
 
 	if (len) {
-		if (!nowayout)
+		if (!nowayout) {
 			size_t i;
 			char c;
 			expect_close = 0;

_

