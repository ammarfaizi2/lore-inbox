Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267620AbUIFIcL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267620AbUIFIcL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Sep 2004 04:32:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267624AbUIFIcL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Sep 2004 04:32:11 -0400
Received: from fw.osdl.org ([65.172.181.6]:64970 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267620AbUIFIcH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Sep 2004 04:32:07 -0400
Date: Mon, 6 Sep 2004 01:29:39 -0700
From: Andrew Morton <akpm@osdl.org>
To: Kirill Korotaev <dev@sw.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] removes unnessary print of space
Message-Id: <20040906012939.65e63521.akpm@osdl.org>
In-Reply-To: <413C211D.9010301@sw.ru>
References: <413C0CC5.4000807@sw.ru>
	<20040906000826.73157de6.akpm@osdl.org>
	<413C211D.9010301@sw.ru>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kirill Korotaev <dev@sw.ru> wrote:
>
> I've noticed another thing. There is a default bust_spinlocks() in 
>  lib/bust_spinlocks.c. 4 architectures including x86 have their own 
>  copies of it, which are exactly the same as the default one.
> 
>  So do we really need lib/bust_spinlocks.c or we can move a signle copy 
>  of this function to kernel/printk.c?

I'd leave it as is - nobody's complaining.

In the more modern scheme of things we'd move that file to kernel/ and
require that per-arch Kconfigs define CONFIG_NEED_GENERIC_BUST_SPINLOCKS,
then use that in kernel/Makefile.  But doing that now would be gratuitous
noise, IMO.

