Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262404AbVAPCXv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262404AbVAPCXv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jan 2005 21:23:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262393AbVAPCUB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jan 2005 21:20:01 -0500
Received: from [81.2.110.250] ([81.2.110.250]:6275 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S262395AbVAPCDy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jan 2005 21:03:54 -0500
Subject: Re: Linux 2.6.10-ac9
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Sami Farin <7atbggg02@sneakemail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050115050749.GB8456@m.safari.iki.fi>
References: <1105636996.4644.70.camel@localhost.localdomain>
	 <20050114030135.GA6032@m.safari.iki.fi>
	 <1105743716.9839.29.camel@localhost.localdomain>
	 <20050115050749.GB8456@m.safari.iki.fi>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1105831712.15835.27.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 16 Jan 2005 00:58:56 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2005-01-15 at 05:07, Sami Farin wrote:
> my drives do not support cache flushes, I guess your drives do?

Probably yes.

> cat /proc/ide/hda/settings does not work, either
> 
> cat           D C0572788     0  8016   5187                6044 (NOTLB)
> cdc97eb0 00000046 cf7f00a0 c0572788 00005699 c01fe93f 000001ad 00000023 
>        01078345 00005699 cf7f00a0 00000bbb 02ed12c3 00005699 cfec51d8 c04de020 
>        cfec5080 00000246 cdc97ee8 c0409764 c04de028 00000001 cfec5080 c011ab70 
> Call Trace:
>  [<c0409764>] __down+0x64/0xc0
>  [<c04098ba>] __down_failed+0xa/0x10
>  [<c0302acf>] .text.lock.ide_proc+0x8b/0x1fc
>  [<c018c594>] proc_file_read+0xc4/0x260
>  [<c0158fbf>] vfs_read+0xcf/0x150
>  [<c01592db>] sys_read+0x4b/0x80
>  [<c0103163>] syscall_call+0x7/0xb

Duplicated and fixed for -ac10 coming up soon. Thanks for that one,
thats was a very dumb bug 8)

