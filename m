Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263596AbUBAAQd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jan 2004 19:16:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264437AbUBAAQd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jan 2004 19:16:33 -0500
Received: from fw.osdl.org ([65.172.181.6]:19671 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263596AbUBAAQc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jan 2004 19:16:32 -0500
Date: Sat, 31 Jan 2004 16:17:29 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Sergey S. Kostyliov" <rathamahata@php4.ru>
Cc: linux-kernel@vger.kernel.org, anton@megashop.ru
Subject: Re: 2.6.1 IO lockup on SMP systems
Message-Id: <20040131161729.04000e92.akpm@osdl.org>
In-Reply-To: <200401311940.28078.rathamahata@php4.ru>
References: <200401311940.28078.rathamahata@php4.ru>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Sergey S. Kostyliov" <rathamahata@php4.ru> wrote:
>
> I had experienced a lockups on three of my servers with 2.6.1. It doesn't
>  look like a deadlock, the box is still pingable and all tcp ports which were
>   in listen state before a lockup are remains in listen state, but I can't get
>  any data from this ports. According to sar(1) systems had not been overloaded
>  right before a lockup. And there is no log entries in all user services logs
>  for almost 10 hours after lockup.

Please ensure that CONFIG_KALLSYMS is enabled, then generate an all-tasks
backtrace or a locked machine with sysrq-T or `echo t >
/proc/sysrq-trigger'.  Then send us the resulting trace.

You may need a serial console to be able to capture all the output.

Also, it would be useful to know what sort of load the machines are under,
and what filesystems are in use.

Thanks.

