Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131637AbQLYQn6>; Mon, 25 Dec 2000 11:43:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131644AbQLYQns>; Mon, 25 Dec 2000 11:43:48 -0500
Received: from cicero0.cybercity.dk ([212.242.40.52]:61202 "HELO
	cicero0.cybercity.dk") by vger.kernel.org with SMTP
	id <S131637AbQLYQne>; Mon, 25 Dec 2000 11:43:34 -0500
Date: Mon, 25 Dec 2000 17:13:05 +0100
From: Jens Axboe <axboe@suse.de>
To: "Mohammad A. Haque" <mhaque@haque.net>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: test13-pre4... udf problem with dvd access vs test12
Message-ID: <20001225171305.G303@suse.de>
In-Reply-To: <3A47212D.F9F119C3@xmission.com> <3A476C7D.1952EDB4@haque.net> <3A477014.CE908BFC@haque.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3A477014.CE908BFC@haque.net>; from mhaque@haque.net on Mon, Dec 25, 2000 at 11:04:36AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 25 2000, Mohammad A. Haque wrote:
> Jens, I made sure to reverse the udf patch I mentioned in another thread
> (all it really is merging changes from linux-udf cvs into the current
> kernel). So this is from a clean test13-pre4 w/ some netfilter fixes.

Ok, looks unrelated however.

> >>EIP; c019c017 <cdrom_log_sense+f/68>   <=====

Yes I know about this one, I've attached the patch here again. Linus,
could you apply?

--- drivers/ide/ide-cd.c~	Sat Dec 23 23:59:52 2000
+++ drivers/ide/ide-cd.c	Sun Dec 24 00:03:38 2000
@@ -333,7 +333,7 @@
 {
 	int log = 0;
 
-	if (sense == NULL || pc->quiet)
+	if (sense == NULL || pc == NULL || pc->quiet)
 		return 0;
 
 	switch (sense->sense_key) {

-- 
* Jens Axboe <axboe@suse.de>
* SuSE Labs
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
