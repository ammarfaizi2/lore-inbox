Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263893AbTI2R0c (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 13:26:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263895AbTI2RZt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 13:25:49 -0400
Received: from fw.osdl.org ([65.172.181.6]:25747 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263893AbTI2RZg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 13:25:36 -0400
Date: Mon, 29 Sep 2003 10:25:31 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Rusty Russell <rusty@rustcorp.com.au>
cc: Tim Hockin <thockin@hockin.org>, <linux-kernel@vger.kernel.org>,
       <torvalds@transmeta.com>, <braam@clusterfs.com>,
       <neilb@cse.unsw.edu.au>
Subject: Re: [PATCH] Many groups patch.
In-Reply-To: <20030929072027.903AC2C07F@lists.samba.org>
Message-ID: <Pine.LNX.4.44.0309291024040.28114-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 29 Sep 2003, Rusty Russell wrote:
> 
> This version drops the internal groups array (it's so often shared
> that it's not worth it, and the logic becomes a bit neater), and does
> vmalloc fallback in case someone has massive number of groups.

Why?

kmalloc() works fine. Anybody who needs 200 groups may be sane, but 
anybody who needs more than fits in a kmalloc() is definitely so far out 
that there is no point. 

The vmalloc space is limited, and the code just gets uglier.

Have you been looking at glibc sources lately, or why do you believe that 
we should encourage insane usage?

		Linus

