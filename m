Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267548AbUIFHKj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267548AbUIFHKj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Sep 2004 03:10:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267549AbUIFHKi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Sep 2004 03:10:38 -0400
Received: from fw.osdl.org ([65.172.181.6]:17036 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267548AbUIFHK1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Sep 2004 03:10:27 -0400
Date: Mon, 6 Sep 2004 00:08:26 -0700
From: Andrew Morton <akpm@osdl.org>
To: Kirill Korotaev <dev@sw.ru>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [PATCH] removes unnessary print of space
Message-Id: <20040906000826.73157de6.akpm@osdl.org>
In-Reply-To: <413C0CC5.4000807@sw.ru>
References: <413C0CC5.4000807@sw.ru>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kirill Korotaev <dev@sw.ru> wrote:
>
> This patch removes unnessary print of space in bust_spinlocks().
>  printk("") wakeups klogd as well,

Until some smarty comes along and optimises printk() to skip empty strings.

An explicit wake_up_klogd() thing might make sense, rather than relying
upon side-effects.

> no need to print a space and make a mess.

Can't say that I've ever noticed that space.
