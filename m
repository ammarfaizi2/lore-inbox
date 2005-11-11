Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932243AbVKKIzf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932243AbVKKIzf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 03:55:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932299AbVKKIzf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 03:55:35 -0500
Received: from smtp.osdl.org ([65.172.181.4]:40892 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932243AbVKKIze (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 03:55:34 -0500
Date: Fri, 11 Nov 2005 00:55:13 -0800
From: Andrew Morton <akpm@osdl.org>
To: Reuben Farrelly <reuben-lkml@reub.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.14-mm2
Message-Id: <20051111005513.0dda25f3.akpm@osdl.org>
In-Reply-To: <43745633.1030802@reub.net>
References: <20051110203544.027e992c.akpm@osdl.org>
	<43743105.7030201@reub.net>
	<20051110220727.13b084f4.akpm@osdl.org>
	<43745633.1030802@reub.net>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Reuben Farrelly <reuben-lkml@reub.net> wrote:
>
> The 2.6.14 with your linus.patch works fine, so it looks like an -mm(1|2) 
> specific problem, which is common to both sky2 and e100 drivers (unlikely to 
> be e100 specific I guess).

That's getting us closer.

Would you be able to revert the git-netdev-all.patch changes in e100.c?  To
do that, take the drivers/net/e100.c from 2.6.14+linus.patch and simply
overwrite the e100.c in 2.6.14-mm2 with it.

Or, prepare a 2.6.14-mm2 tree and use
http://www.zip.com.au/~akpm/linux/patches/stuff/e100.c, which amounts to
the same thing.

Thanks.
