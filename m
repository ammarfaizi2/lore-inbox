Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266118AbUAHTeL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 14:34:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266180AbUAHTeK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 14:34:10 -0500
Received: from fw.osdl.org ([65.172.181.6]:48006 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266118AbUAHTdN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 14:33:13 -0500
Date: Thu, 8 Jan 2004 11:29:03 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: bluefoxicy@linux.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: Oops 0002
Message-Id: <20040108112903.04a1b9a7.rddunlap@osdl.org>
In-Reply-To: <20040108184935.BD5E3E4B8@sitemail.everyone.net>
References: <20040108184935.BD5E3E4B8@sitemail.everyone.net>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Jan 2004 10:49:35 -0800 (PST) john moser <bluefoxicy@linux.net> wrote:

| icebox regression # ./memkmemport_test
| Testing denied write of /dev/mem... : FAILED
| Testing denied mmap write of /dev/kmem... : FAILED
| Testing denied open of /dev/port... : FAILED
| <1>Unable to handle kernel NULL pointer dereference at virtual address
| 00000000
|  printing eip:
| c0387645
| *pde = 00000000
| Oops: 0002 [#3]
| CPU:    0
| EIP:    0060:[<c0387645>]    Tainted: PF
| EFLAGS: 00010246
| eax: 00000000   ebx: 00000004   ecx: 00000004   edx: 00000000
| esi: 080487eb   edi: 00000000   ebp: 080487ef   esp: d0f55e80
| ds: 007b   es: 007b   ss: 0068
| Process memkmemport_tes (pid: 7355, threadinfo=d0f54000 task=dbdd0c80)
| Stack: 00000004 00000004 efd516c0 c02b7523 ef5aa9c0 00000004 00000000 c02b6a48
|        00000000 080487eb 00000004 e69cd140 c02b6dd0 00000004 e69cd160 080487eb
|        c02b6e39 e69cd140 00000000 00000000 080487eb 00000004 e69cd160 e69cd140
| Call Trace: [<c02b7523>]  [<c02b6a48>]  [<c02b6dd0>]  [<c02b6e39>]
| [<c02b6dd0>]  [<c01ed0e8>]  [<c01ed212>]  [<c019d417>]  [<c019d42f>]
| Code: f3 aa 58 59 e9 fc 4c f0 ff b8 f2 ff ff ff e9 b3 9e f0 ff b8
|  Segmentation fault
| 
| 
| regression tools that I pulled out of the grsecurity.net cvs and tested on a PaX patched kernel AND a kernel that I'm working a bit on (without pax), neither should oops.  I don't readily reboot to run vanillas. This is a NULL dereference INSIDE the kernel, right?  Something's broke, and it does this on 2.6.1-rc2 so whatever it is is probably still broke.

Yes, it's a NULL reference inside (some) kernel.

1.  Please wrap email lines around 70-72 characters.

2.  What kernel version is this?  What patches applied?

3.  This is the 3rd oops for this kernel.  What were the first 2?

4.  Please use CONFIG_KALLSYMS=y so that addresses will be
converted to symbols, or run the oops thru ksymoops.


--
~Randy
MOTD:  Always include version info.
