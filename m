Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263129AbTJaJ0w (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Oct 2003 04:26:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263135AbTJaJ0v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Oct 2003 04:26:51 -0500
Received: from fw.osdl.org ([65.172.181.6]:12259 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263129AbTJaJ0u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Oct 2003 04:26:50 -0500
Date: Fri, 31 Oct 2003 01:28:46 -0800
From: Andrew Morton <akpm@osdl.org>
To: age <ahuisman@cistron.nl>
Cc: linux-kernel@vger.kernel.org, nuno.silva@vgertech.com
Subject: Re: READAHEAD
Message-Id: <20031031012846.48fa233c.akpm@osdl.org>
In-Reply-To: <3FA25377.3050207@cistron.nl>
References: <bnrdqi$uho$1@news.cistron.nl>
	<20031030134407.0c97c86e.akpm@osdl.org>
	<3FA25377.3050207@cistron.nl>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

age <ahuisman@cistron.nl> wrote:
>
> > Lots of people have been reporting this.  It's rather weird.
>   >
>   > Is the same effect observable when reading a large file, or is it only
>   > observable via `hdparm -t'?
>   >
> 
>  Hi Andrew,
> 
>  Here are some tests with bonnie++.

Like so many of these things, bonnie++ is generally far, far too complex
for kernel performance tuning.

Please, just use time, cat, dd, etc.

	mount /dev/xxx /mnt/yyy
	dd if=/dev/zero of=/mnt/yyy/x bs=1M count=1024
	umount /dev/xxx
	mount /dev/xxx /mnt/yyy
	time cat /mnt/yyy/x > /dev/null

nice'n'easy.

