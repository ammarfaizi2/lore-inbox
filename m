Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274255AbRIXXvB>; Mon, 24 Sep 2001 19:51:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274254AbRIXXuv>; Mon, 24 Sep 2001 19:50:51 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:60934 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S274255AbRIXXud>; Mon, 24 Sep 2001 19:50:33 -0400
Date: Mon, 24 Sep 2001 19:27:32 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Andrea Arcangeli <andrea@suse.de>, lkml <linux-kernel@vger.kernel.org>
Subject: 2.4.10 VM: what avoids from having lots of unwriteable inactive
 pages
Message-ID: <Pine.LNX.4.21.0109241924470.1207-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

What avoids us from having a lot of unfreeable (eg mapped by ptes) pages
on the inactive list ? 

Since we don't move those pages to the active list at shrink_cache(), I
see that we rely on swap_out() to deactivate pte's and make pages on the
inactive list freeable.

Is that right ? 

