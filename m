Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131461AbQLKBHO>; Sun, 10 Dec 2000 20:07:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131265AbQLKBGy>; Sun, 10 Dec 2000 20:06:54 -0500
Received: from asterix.hrz.tu-chemnitz.de ([134.109.132.84]:57026 "EHLO
	asterix.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S130766AbQLKBGs>; Sun, 10 Dec 2000 20:06:48 -0500
Date: Mon, 11 Dec 2000 02:36:05 +0100
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: "Mohammad A. Haque" <mhaque@haque.net>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] test12-pre8 task queue fix batch
Message-ID: <20001211023605.K7554@nightmaster.csn.tu-chemnitz.de>
In-Reply-To: <3A341DE8.B996D54B@haque.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <3A341DE8.B996D54B@haque.net>; from mhaque@haque.net on Sun, Dec 10, 2000 at 07:20:56PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 10, 2000 at 07:20:56PM -0500, Mohammad A. Haque wrote:
> Lets see if this is the gist of them...
 
At least one more to fix:

diff -ru linux-2.4.0-test12-pre8/drivers/isdn/hisax/config.c linux/drivers/isdn/hisax/config.c
--- linux-2.4.0-test12-pre8/drivers/isdn/hisax/config.c Sun Dec 10 20:38:55 2000+++ linux/drivers/isdn/hisax/config.c      Mon Dec 11 01:04:16 2000
@@ -1180,7 +1180,7 @@
        cs->tx_skb = NULL;
        cs->tx_cnt = 0;
        cs->event = 0;
-       cs->tqueue.next = 0;
+       INIT_LIST_HEAD(&cs->tqueue.list);
        cs->tqueue.sync = 0;
        cs->tqueue.data = cs;



Regards 

Ingo Oeser
-- 
10.+11.03.2001 - 3. Chemnitzer LinuxTag <http://www.tu-chemnitz.de/linux/tag>
         <<<<<<<<<<<<       come and join the fun       >>>>>>>>>>>>
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
