Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131650AbRCUSNK>; Wed, 21 Mar 2001 13:13:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131669AbRCUSNB>; Wed, 21 Mar 2001 13:13:01 -0500
Received: from www.wen-online.de ([212.223.88.39]:21508 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S131650AbRCUSMx>;
	Wed, 21 Mar 2001 13:12:53 -0500
Date: Wed, 21 Mar 2001 19:11:51 +0100 (CET)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: linux-kernel <linux-kernel@vger.kernel.org>
cc: Rik van Riel <riel@conectiva.com.br>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: kswapd deadlock 2.4.3-pre6
Message-ID: <Pine.LNX.4.33.0103211853420.2398-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a repeatable deadlock when SMP is enabled on my UP box.

>>EIP; c021e29a <stext_lock+1556/677b>   <=====
Trace; c012dc58 <swap_out+b0/c8>
Trace; c012ebe2 <refill_inactive+72/98>
Trace; c012ec51 <do_try_to_free_pages+49/7c>
Trace; c012eceb <kswapd+67/f4>
Trace; c01074c4 <kernel_thread+28/38>

Will try to chase it down.

ac20+2.4.2-ac20-rwmmap_sem3 does not deadlock doing the same
churn/burn via make -j30 bzImage.

(I get darn funny looking time numbers though..
real    9m45.641s
user    14m55.710s
sys     1m25.010s)

	-Mike

