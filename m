Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263573AbUDEWiW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 18:38:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263526AbUDEWdu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 18:33:50 -0400
Received: from fw.osdl.org ([65.172.181.6]:7568 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263571AbUDEWcz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 18:32:55 -0400
Date: Mon, 5 Apr 2004 15:35:07 -0700
From: Andrew Morton <akpm@osdl.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: swsusp update: supports discontingmem/highmem
Message-Id: <20040405153507.69e3004d.akpm@osdl.org>
In-Reply-To: <20040405212354.GA3633@elf.ucw.cz>
References: <20040405212354.GA3633@elf.ucw.cz>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@ucw.cz> wrote:
>
> It makes swsusp behave correctly
> w.r.t. discontingmem, and adds highmem handling 

Some of those ENOMEM panics in save_highmem_zone() look like they might
need proper handling instead?

The 256 byte automatic array in read_swapfiles() may bring you a visit from
the stack space police, although I don't think it's really a problem.  256
bytes for a pathname may be a bit excessive though.

Please send me an update patch sometime which makes all the new code go
away again if !CONFIG_HIGHMEM.

Thanks.

