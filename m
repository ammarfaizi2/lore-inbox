Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263942AbUAMKTb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 05:19:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263946AbUAMKTb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 05:19:31 -0500
Received: from main.gmane.org ([80.91.224.249]:23004 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S263942AbUAMKTa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 05:19:30 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: =?ISO-8859-1?Q?Sven_K=F6hler?= <skoehler@upb.de>
Subject: Re: uml-patch-2.6.0
Date: Tue, 13 Jan 2004 11:19:27 +0100
Message-ID: <bu0gnf$ief$1@sea.gmane.org>
References: <200401130505.i0D55XS4026774@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
In-Reply-To: <200401130505.i0D55XS4026774@ccure.user-mode-linux.org>
Cc: user-mode-linux-devel@lists.sourceforge.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The 2.6.0 UML patch is available at
> 	http://www.user-mode-linux.org/mirror/uml-patch-2.6.0-1.bz2

i get this error:

gcc -Wl,-T,arch/um/uml.lds.s -static -Wl,--wrap,malloc -Wl,--wrap,free 
-Wl,--wra
p,calloc \
	-o linux arch/um/main.o vmlinux -L/usr/lib -lutil
vmlinux(.text+0x5288): In function `mem_init':
: undefined reference to `phys_page'
vmlinux(.init.text+0x21f3): In function `kmap_init':
: undefined reference to `pte_offset'
collect2: ld returned 1 exit status

i applied this patch to clean 2.6.0 sources from kernel.org.
if you need more information just ask. i'm running gentoo 1.4 with a 
2.6.1 host kernel. linux 2.4.19 headers are installed in /usr/include, 
just in case it matters.


