Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262642AbUKEKSk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262642AbUKEKSk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 05:18:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262644AbUKEKSk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 05:18:40 -0500
Received: from fw.osdl.org ([65.172.181.6]:25814 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262642AbUKEKSc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 05:18:32 -0500
Date: Fri, 5 Nov 2004 02:17:58 -0800
From: Andrew Morton <akpm@osdl.org>
To: Lorenzo Allegrucci <l_allegrucci@yahoo.it>
Cc: linux-kernel@vger.kernel.org, Andi Kleen <ak@muc.de>
Subject: Re: 2.6.10-rc1-mm3
Message-Id: <20041105021758.09d582bf.akpm@osdl.org>
In-Reply-To: <200411051041.17940.l_allegrucci@yahoo.it>
References: <20041105001328.3ba97e08.akpm@osdl.org>
	<200411051041.17940.l_allegrucci@yahoo.it>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lorenzo Allegrucci <l_allegrucci@yahoo.it> wrote:
>
> On Friday 05 November 2004 09:13, Andrew Morton wrote:
>  > 
>  > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.10-rc1/2.6.10-rc1-mm3/
> 
>  ------------[ cut here ]------------
>  kernel BUG at mm/memory.c:156!
>  invalid operand: 0000 [#1]
>  PREEMPT 
>  Modules linked in: ipv6 tun dm_mod emu10k1 sound soundcore ac97_codec unix
>  CPU:    0
>  EIP:    0060:[clear_page_range+276/304]    Not tainted VLI
>  EFLAGS: 00010206   (2.6.10-rc1-mm3) 
>  EIP is at clear_page_range+0x114/0x130
>  eax: daffc000   ebx: 00483fff   ecx: c03b7088   edx: daffc000
>  esi: 00000000   edi: 00080000   ebp: dca51ed0   esp: dca51ea8
>  ds: 007b   es: 007b   ss: 0068
>  Process shmt04 (pid: 4854, threadinfo=dca51000 task=de374510)

hm, I thought I ran ltp.  Andi, this is due to the 4level patches.  I can
reproduce it with non-PAE x86.  But testing was interrupted by the apparent
suicide of an IDE disk :(
