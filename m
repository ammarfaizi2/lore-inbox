Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261833AbTJAAB3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 20:01:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261839AbTJAAB2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 20:01:28 -0400
Received: from fw.osdl.org ([65.172.181.6]:23459 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261833AbTI3X7m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 19:59:42 -0400
Date: Tue, 30 Sep 2003 16:59:32 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Christopher Li <lkml@chrisli.org>
cc: Andries.Brouwer@cwi.nl, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fat sparse fixes
In-Reply-To: <20030930070556.GA2182@64m.dyndns.org>
Message-ID: <Pine.LNX.4.44.0309301655190.21089-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 30 Sep 2003, Christopher Li wrote:
> 
> The problem is in "*d2->d_name", the address space get
> lost at evaluate_dereference of "*"

Yes, but taking the address of it should still undo all the things.  
"evaluate_addressof()" does the right (fairly complex) magic, but
apparently the "degenerate()" function does not.

Ho humm.. degenerate() really should be 100% the same as 
"evaluate_addressof()", but I'm sure I had some reason for doing them 
separately.

Probably a very bad reason, brought on by terminal mental illness. But a
reason none-the-less..

		Linus

