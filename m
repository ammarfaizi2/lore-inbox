Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268139AbUIWCFZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268139AbUIWCFZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 22:05:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268138AbUIWCFY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 22:05:24 -0400
Received: from fw.osdl.org ([65.172.181.6]:48105 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268139AbUIWCFS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 22:05:18 -0400
Date: Wed, 22 Sep 2004 19:03:05 -0700
From: Andrew Morton <akpm@osdl.org>
To: Nuno Ferreira <nuno.ferreira@graycell.biz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc2-mm2
Message-Id: <20040922190305.4471f6de.akpm@osdl.org>
In-Reply-To: <1095904041.4225.11.camel@taz.graycell.biz>
References: <20040922131210.6c08b94c.akpm@osdl.org>
	<1095904041.4225.11.camel@taz.graycell.biz>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nuno Ferreira <nuno.ferreira@graycell.biz> wrote:
>
> I just tried it on my laptop. I have a speedtouch usb adsl modem and
>  when it connects the computer freezes, around the same time that
>  messages are printed to the console showing that the ppp compression
>  modules were loaded.
>  Sysrq still works, I was able to get this trace form sysrq-p (sorry, no
>  other machine to dump netconsole output to), process id pppd:
> 
>  EIP fn_hash_delete
>  ipv4_doint_and_flush
>  fib_magic
>  fib_del_ifaddr
>  fib_inetaddr
>  notifier_call_chain
>  inet_del_ifa
>  inet_insert_ifa
>  devinet_ioctl
>  inet_ioctl
>  sock_ioctl
>  sys_ioctl
>  syscall_call

hrm.  Lots of changes in fib_hash.c  Could you please try just 2.6.9-rc2 plus
ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc2/2.6.9-rc2-mm2/broken-out/linus.patch

Thanks.
