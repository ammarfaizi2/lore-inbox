Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262283AbTJTE70 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 00:59:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262285AbTJTE70
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 00:59:26 -0400
Received: from fw.osdl.org ([65.172.181.6]:25062 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262283AbTJTE7Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 00:59:25 -0400
Date: Sun, 19 Oct 2003 22:00:05 -0700
From: Andrew Morton <akpm@osdl.org>
To: Shantanu Goel <sgoel01@yahoo.com>
Cc: linux-kernel@vger.kernel.org, Marcelo Tosatti <marcelo@conectiva.com.br>,
       Andrea Arcangeli <andrea@suse.de>
Subject: Re: [PATCH] 2.4.23-pre7 vmscan.c typo
Message-Id: <20031019220005.129e5358.akpm@osdl.org>
In-Reply-To: <20031020014025.42111.qmail@web12812.mail.yahoo.com>
References: <20031020014025.42111.qmail@web12812.mail.yahoo.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shantanu Goel <sgoel01@yahoo.com> wrote:
>
> The following appears to be a typo in mm/vmscan.c
> 

It sure is.  Scary.

--- a/mm/vmscan.c	2003-10-19 21:36:26.000000000 -0400
+++ a/mm/vmscan.c	2003-10-19 21:37:17.000000000 -0400
@@ -596,7 +596,7 @@
 			continue;
 		}
 
-		nr_pages--;
+		ratio--;
 
 		del_page_from_active_list(page);
 		add_page_to_inactive_list(page);



I note that `ratio' here is the number of pages which we try to deactivate
rather than the number of pages which we scan.  Is this intentional?

