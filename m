Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263949AbTFDTIB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 15:08:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263957AbTFDTIA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 15:08:00 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:19218 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S263949AbTFDTH5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 15:07:57 -0400
Date: Wed, 4 Jun 2003 12:20:52 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Hua Zhong <hzhong@cisco.com>
cc: "'Christoph Hellwig'" <hch@infradead.org>,
       "'P. Benie'" <pjb1008@eng.cam.ac.uk>,
       "'Kernel Mailing List'" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] [2.5] Non-blocking write can block
In-Reply-To: <01b601c32ac9$52f002c0$ca41cb3f@amer.cisco.com>
Message-ID: <Pine.LNX.4.44.0306041220140.14904-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 4 Jun 2003, Hua Zhong wrote:
>  
> That said, the main problem was somebody could be stuck in waiting for
> tty *forever* and thus everyone who tries to write also hangs.
> 
> This particular patch is in 2.4.20 already. There is another patch in
> 2.4.20 (?) which seems to fix the "main problem" (the n_tty_write_wakeup
> function in n_tty.c), but I didn't verify it.

Do y ou have that other patch handy? It sounds like that is the real cause 
of the problem, and the patch quoted originally in this thread was a 
(broken) work-around..

		Linus

