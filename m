Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265546AbUBJEbx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 23:31:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265552AbUBJEbw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 23:31:52 -0500
Received: from fw.osdl.org ([65.172.181.6]:10649 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265546AbUBJEbv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 23:31:51 -0500
Date: Mon, 9 Feb 2004 20:34:24 -0800
From: Andrew Morton <akpm@osdl.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/char/vt possible race
Message-Id: <20040209203424.3fc85842.akpm@osdl.org>
In-Reply-To: <1076386813.884.11.camel@gaston>
References: <1076386813.884.11.camel@gaston>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
>
> Hi !
> 
> I falled again on the crash in con_do_write() with driver->data
> beeing NULL. It happens during boot, when userland is playing
> open/close games with tty's, I was intentionally typing keys like
> mad during boot trying to trigger another problem when this one
> poped up.

OK.  Was this patch confirmed to prevent any reoccurrences?

> Andrew: I suggest putting that in -mm for a while, and if it
> doesn't trigger any new problem, upstream, maybe without my
> 2 printk's "argh" :)

Yup.  I'll also bring back the sysfs patch which somehow triggers
this race.


