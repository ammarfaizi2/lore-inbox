Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267518AbUBTGBl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 01:01:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267620AbUBTGBl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 01:01:41 -0500
Received: from fw.osdl.org ([65.172.181.6]:59605 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267608AbUBTGBj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 01:01:39 -0500
Date: Thu, 19 Feb 2004 22:01:49 -0800
From: Andrew Morton <akpm@osdl.org>
To: Rui Saraiva <rmps@joel.ist.utl.pt>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.2 Freeze (but SysRq works)
Message-Id: <20040219220149.17ebebcf.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0402191932340.1006@joel.ist.utl.pt>
References: <Pine.LNX.4.58.0402191932340.1006@joel.ist.utl.pt>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rui Saraiva <rmps@joel.ist.utl.pt> wrote:
>
> Hello,
> 
> I've been experiencing some of this freezes lately, but this time I could
> use SysRq to get this dump from dmesg:
> 
> ...
> 
> tvtime        R current      0  3207  27904          4102 28094 (NOTLB)
> c03f1a40 ca350000 00000001 ca351ed0 c010cb80 00000001 ca351ed8 cf44eb24
>        cb3e6d50 cda0778c ca350000 ca351f04 c03f1a58 00000001 cf44eb24 bfffe990
>        00000004 c011f7f0 ca351fb4 c010aabc bfffe990 0000007b ca351fc4 00000004
> Call Trace:
>  [<c010cb80>] do_IRQ+0x140/0x390
>  [<c011f7f0>] do_page_fault+0x0/0x57e
>  [<c010aabc>] common_interrupt+0x18/0x20
>  [<c011f7f0>] do_page_fault+0x0/0x57e
>  [<c011f817>] do_page_fault+0x27/0x57e
>  [<d1a3dbba>] bttv_irq+0x6a/0x430 [bttv]
>  [<d187b21c>] rtc_interrupt+0x21c/0x390 [rtc]
>  [<c010c54b>] handle_IRQ_event+0x3b/0x70
>  [<c010cbff>] do_IRQ+0x1bf/0x390
>  [<c011f7f0>] do_page_fault+0x0/0x57e
>  [<c011f7f0>] do_page_fault+0x0/0x57e
>  [<c010ab59>] error_code+0x2d/0x38

Looks like this is the problem.  Please wait for it to lock up again then do
sysrq-P five or ten times, send the log output.

