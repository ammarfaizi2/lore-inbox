Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261203AbTESPx3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 11:53:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261207AbTESPx3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 11:53:29 -0400
Received: from ajax.cs.uga.edu ([128.192.251.3]:3054 "EHLO ajax.cs.uga.edu")
	by vger.kernel.org with ESMTP id S261203AbTESPx2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 11:53:28 -0400
To: linux-kernel@vger.kernel.org
Subject: comment for forget_pte
References: <87n0hm7esy.fsf@uga.edu>
From: Ed L Cashin <ecashin@uga.edu>
Date: Mon, 19 May 2003 12:06:25 -0400
Message-ID: <87he7qhqf2.fsf@cs.uga.edu>
User-Agent: Gnus/5.090014 (Oort Gnus v0.14) Emacs/21.2
 (i386-debian-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.  The kernelnewbies list didn't answer, so I'm asking here.  It's
not a big deal, but it might be a little documentation bug.
---------------

What is the meaning of the comment above forget_pte?  It's a void
function, so there's no value returned.  


/*
 * Return indicates whether a page was freed so caller can adjust rss
 */
static inline void forget_pte(pte_t page)
{
	if (!pte_none(page)) {
		printk("forget_pte: old mapping existed!\n");
		BUG();
	}
}


-- 
--Ed L Cashin     PGP public key: http://noserose.net/e/pgp/

