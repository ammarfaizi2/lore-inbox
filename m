Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750822AbWJHGBr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750822AbWJHGBr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 02:01:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750824AbWJHGBr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 02:01:47 -0400
Received: from smtp.osdl.org ([65.172.181.4]:37853 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750822AbWJHGBq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 02:01:46 -0400
Date: Sat, 7 Oct 2006 23:01:29 -0700
From: Andrew Morton <akpm@osdl.org>
To: Wink Saville <wink@saville.com>
Cc: Arjan van de Ven <arjan@infradead.org>, Matthias Hentges <oe@hentges.net>,
       linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net
Subject: Re: Hang in fb_notifier_call_chain with nvidia framebuffer
Message-Id: <20061007230129.323ac807.akpm@osdl.org>
In-Reply-To: <4523E09C.9000609@saville.com>
References: <45206777.7020405@saville.com>
	<1159808447.4652.6.camel@mhcln03>
	<4521E326.2000406@saville.com>
	<1159882225.2891.525.camel@laptopd505.fenrus.org>
	<4523E09C.9000609@saville.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 04 Oct 2006 09:26:04 -0700
Wink Saville <wink@saville.com> wrote:

> Attached in the zip file is:
> 
> log-hang1.txt	-> log showing hang
> cfg-hang1	-> config file for hang condition
> cfg-ok		-> config file that works
> fbmem.c		-> Modifications to register_framebuffer
> 
> To possibly assist I turned on debugging in nvidia.c and found that it 
> hung in the call to register_framebuffer. I then added some additional 
> debug in that routine and it appears the hang occurs in the call to 
> fb_notifier_call_chain.
> 
> Please let me know what else maybe needed.

Please:

- get sysrq working:

	set CONFIG_MAGIC_SYSRQ=y, rebuild, reboot
	echo 1 > /proc/sys/kernel/sysrq
	dmesg -n 8

- make it hang

- Hit alt-sysrq-T

- Send us the resulting output

Thanks.
