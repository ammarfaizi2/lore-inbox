Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132976AbQLHVog>; Fri, 8 Dec 2000 16:44:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132978AbQLHVo0>; Fri, 8 Dec 2000 16:44:26 -0500
Received: from pizda.ninka.net ([216.101.162.242]:58753 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S132976AbQLHVoM>;
	Fri, 8 Dec 2000 16:44:12 -0500
Date: Fri, 8 Dec 2000 12:58:02 -0800
Message-Id: <200012082058.MAA11302@pizda.ninka.net>
From: "David S. Miller" <davem@redhat.com>
To: hahn@coffee.psychology.mcmaster.ca
CC: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.10.10012081534290.11892-100000@coffee.psychology.mcmaster.ca>
	(message from Mark Hahn on Fri, 8 Dec 2000 15:36:35 -0500 (EST))
Subject: Re: [PATCH] mm->rss is modified without page_table_lock held
In-Reply-To: <Pine.LNX.4.10.10012081534290.11892-100000@coffee.psychology.mcmaster.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Date: 	Fri, 8 Dec 2000 15:36:35 -0500 (EST)
   From: Mark Hahn <hahn@coffee.psychology.mcmaster.ca>

   can't we just change rss to count pages? 

This is what it does now.

   or are we worried about rss's over ~16 TB?

If we weren't, we could just use an atomic_t for this problem.
We can't.

This patch is the only currently available solution to this problem
which is in any way acceptable.

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
