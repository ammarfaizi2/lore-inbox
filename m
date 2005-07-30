Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262761AbVG3FDw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262761AbVG3FDw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 01:03:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262808AbVG3FDw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 01:03:52 -0400
Received: from smtp.osdl.org ([65.172.181.4]:2733 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262761AbVG3FDv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 01:03:51 -0400
Date: Fri, 29 Jul 2005 22:02:48 -0700
From: Andrew Morton <akpm@osdl.org>
To: jt <jt@jtholmes.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.12 stalls at boot Andrew M. asked for this initcall dump
Message-Id: <20050729220248.049d0f48.akpm@osdl.org>
In-Reply-To: <42EAE4CE.7060908@jtholmes.com>
References: <42EAE4CE.7060908@jtholmes.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jt <jt@jtholmes.com> wrote:
>
> In one of his messages Andrew Morton asked for a dump of the stall 
>  encountered
>  in 2.6.12  using  ALT + Sys Req + P    and  ALT + Sys Req + T
> 
>  I am having the stall problem so here is the dmesg output up and 
>  including the trace
>  It is in the attachment
> 

So..  what does it all mean?  Did you hit sysrq-T in the middle of the
stall?  If so then the kernel seems to be happily running the udev startup
code.  It's a bit sucky - takes about half a minute here.

If the stall occurred before "VFS: Mounted root (ext2 filesystem)." then I
suggest you also enable CONFIG_PRINTK_TIME and regenerate the dmesg output
so we can see exactly which initcall is stalling.  
