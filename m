Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284305AbRLBUXx>; Sun, 2 Dec 2001 15:23:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282922AbRLBUXn>; Sun, 2 Dec 2001 15:23:43 -0500
Received: from [203.168.249.103] ([203.168.249.103]:25985 "EHLO
	cm203-168-249-103.hkcable.com.hk") by vger.kernel.org with ESMTP
	id <S282920AbRLBUXe>; Sun, 2 Dec 2001 15:23:34 -0500
Subject: rw==WRITE in rw_swap_page_base()
From: David Chow <davidchow@rcn.com.hk>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.2 (Preview Release)
Date: 03 Dec 2001 04:18:49 +0800
Message-Id: <1007324329.1914.0.camel@cm203-168-249-103.hkcable.com.hk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear all,

In mm/page_io.c the function rw_swap_page_base() , since 2.4.14 the
rw==WRITE case is missing. Does that mean rw_swap_page_base will never
be called with rw==WRITE? That is rw_swap_page_base will never used to
write a swap page? Then where does the swap write goes? Also the auto 
int "zone_used" is never used twice and it seems useless, it is sitting
there and wasting for memory. The 2.4.16 still keep the traditon int
"zone_used" which is totally usless.

regards,

David Chow
