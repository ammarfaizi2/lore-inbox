Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264781AbUGZB0O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264781AbUGZB0O (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jul 2004 21:26:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264782AbUGZB0O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jul 2004 21:26:14 -0400
Received: from fw.osdl.org ([65.172.181.6]:5280 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264781AbUGZB0N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jul 2004 21:26:13 -0400
Date: Sun, 25 Jul 2004 18:24:45 -0700
From: Andrew Morton <akpm@osdl.org>
To: Rogier Wolff <R.E.Wolff@BitWizard.nl>
Cc: ahu@ds9a.nl, shesha@inostor.com, linux-kernel@vger.kernel.org,
       kernelnewbies@nl.linux.org
Subject: Re: O_DIRECT
Message-Id: <20040725182445.5b49449f.akpm@osdl.org>
In-Reply-To: <20040724095629.GA9434@bitwizard.nl>
References: <40FD561D.1010404@inostor.com>
	<20040720184824.GA30090@outpost.ds9a.nl>
	<20040724095629.GA9434@bitwizard.nl>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rogier Wolff <R.E.Wolff@BitWizard.nl> wrote:
>
> The code
>  we use is: 
> 
>    p = malloc (blocksize + PAGE_SIZE);
>    buf = (void *) ((  ((long)p) + PAGE_SIZE -1 ) & ~(PAGE_SIZE-1));

memalign() and posix_memalign() will do this for you.
