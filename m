Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268285AbUIFQeN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268285AbUIFQeN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Sep 2004 12:34:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268292AbUIFQeN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Sep 2004 12:34:13 -0400
Received: from fw.osdl.org ([65.172.181.6]:24537 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268285AbUIFQeL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Sep 2004 12:34:11 -0400
Date: Mon, 6 Sep 2004 09:33:41 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Kirill Korotaev <dev@sw.ru>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] removes unnessary print of space
Message-Id: <20040906093341.5fff16da.rddunlap@osdl.org>
In-Reply-To: <413C211D.9010301@sw.ru>
References: <413C0CC5.4000807@sw.ru>
	<20040906000826.73157de6.akpm@osdl.org>
	<413C211D.9010301@sw.ru>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 06 Sep 2004 12:34:37 +0400 Kirill Korotaev wrote:

| >>This patch removes unnessary print of space in bust_spinlocks().
| >> printk("") wakeups klogd as well,
| > 
| > Until some smarty comes along and optimises printk() to skip empty strings.
| > 
| > An explicit wake_up_klogd() thing might make sense, rather than relying
| > upon side-effects.
| yup, you are right. I was the easiest, but not the best.
| I'll make a patch with wakeup_klogd.
| 
| >>no need to print a space and make a mess.
| > Can't say that I've ever noticed that space.
| We did. Many times.

Same here.  Thanks for cleaning it up.

| I've noticed another thing. There is a default bust_spinlocks() in 
| lib/bust_spinlocks.c. 4 architectures including x86 have their own 
| copies of it, which are exactly the same as the default one.
| 
| So do we really need lib/bust_spinlocks.c or we can move a signle copy 
| of this function to kernel/printk.c?

--
~Randy
