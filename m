Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263930AbUATEHg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 23:07:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263996AbUATEHg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 23:07:36 -0500
Received: from fw.osdl.org ([65.172.181.6]:3981 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263930AbUATEHf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 23:07:35 -0500
Date: Mon, 19 Jan 2004 20:07:47 -0800
From: Andrew Morton <akpm@osdl.org>
To: Markus Lidel <Markus.Lidel@shadowconnect.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i2o_core.c, i2o_scsi.c minor bugfixes
Message-Id: <20040119200747.6e8d63d0.akpm@osdl.org>
In-Reply-To: <400BF755.6070201@shadowconnect.com>
References: <400BF755.6070201@shadowconnect.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Markus Lidel <Markus.Lidel@shadowconnect.com> wrote:
>
> Hello,
> 
> after using the i2o modules (i2o_core and i2o_scsi), i found that there seems to be some minor problems in the 2.6.1 kernel
> version. So i have created a patch, which resolves the following issues:
> 
> 
> i2o-cleanup.patch:

I get 100% rejects applying this.  Could you resend it as an attachment?

> --- drivers/message/i2o.old/i2o_core.c	2004-01-17 22:47:00.000000000 +0100
> +++ drivers/message/i2o/i2o_core.c	2004-01-17 23:34:43.866973586 +0100

Also, this renaming arrangement breaks my scripts (at least).  Preferable
would be:

--- a/drivers/message/i2o/i2o_core.c
+++ b/drivers/message/i2o/i2o_core.c

> Also i found that the resource management in i2o_scsi is static, so i tried
> to make things a little bit dynamic by allocating the mapping tables at
> module insertion (not included in this e-mail).  Because i don't saw a
> maintainer for those module, i wrote to the kernel mailing list.  Can
> anybody tell me, who i can contact to verify if my changes are of any
> value?  I want to contribute some more code, because on my system the
> i2o_block doesn't work too.  But before, i want to be sure that my code is
> needed and also is good enough to be included into the kernel.

I think that would be Alan Cox <alan@lxorguk.ukuu.org.uk>
