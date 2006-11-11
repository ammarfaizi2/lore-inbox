Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424433AbWKKQXD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424433AbWKKQXD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Nov 2006 11:23:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424582AbWKKQXB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Nov 2006 11:23:01 -0500
Received: from ensim03.ffm.m2soft.com ([195.38.20.12]:52444 "EHLO
	ensim03.ffm.m2soft.com") by vger.kernel.org with ESMTP
	id S1424433AbWKKQXA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Nov 2006 11:23:00 -0500
X-ClientAddr: 85.127.135.120
Date: Sat, 11 Nov 2006 17:21:12 +0100
From: Nicolas Kaiser <nikai@nikai.net>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: linux-ide@vger.kernel.org, trivial@kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH][TRIVIAL] drivers/ide: stray bracket
Message-ID: <20061111172112.7e1aba49@lucky.kitzblitz>
In-Reply-To: <20061111131612.GA4974@martell.zuzino.mipt.ru>
References: <20061111014756.3467d7ee@lucky.kitzblitz>
	<20061111131612.GA4974@martell.zuzino.mipt.ru>
Organization: -
X-Face: "fF&[w2"Nws:JNH4'g|:gVhgGKLhj|X}}&w&V?]0=,7n`jy8D6e[Jh=7+ca|4~t5e[ItpL5
 N'y~Mvi-vJm`"1T5fi1^b!&EG]6nW~C!FN},=$G?^U2t~n[3;u\"5-|~H{-5]IQ2
X-Mailer: Sylpheed-claws (Linux)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-M2Soft-MailScanner-Information: Please contact the ISP for more information
X-M2Soft-MailScanner: Not scanned: please contact your Internet E-Mail Service Provider for details
X-MailScanner-From: nikai@nikai.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Alexey Dobriyan <adobriyan@gmail.com>:
> On Sat, Nov 11, 2006 at 01:47:56AM +0100, Nicolas Kaiser wrote:
> > Stray bracket in debug code.

> Just remove whole printk. It was broken for a looong time.

If you prefer it that way, here we go:
Remove debug code that was broken for long time.

Signed-off-by: Nicolas Kaiser <nikai@nikai.net>
---

 drivers/ide/legacy/hd.c |    5 -----
 1 file changed, 5 deletions(-)

diff -uprN a/drivers/ide/legacy/hd.c b/drivers/ide/legacy/hd.c
--- a/drivers/ide/legacy/hd.c	2006-09-20 05:42:06.000000000 +0200
+++ b/drivers/ide/legacy/hd.c	2006-11-11 17:11:28.000000000 +0100
@@ -456,11 +456,6 @@ ok_to_read:
 	req->errors = 0;
 	i = --req->nr_sectors;
 	--req->current_nr_sectors;
-#ifdef DEBUG
-	printk("%s: read: sector %ld, remaining = %ld, buffer=%p\n",
-		req->rq_disk->disk_name, req->sector, req->nr_sectors,
-		req->buffer+512));
-#endif
 	if (req->current_nr_sectors <= 0)
 		end_request(req, 1);
 	if (i > 0) {
