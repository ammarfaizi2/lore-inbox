Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261852AbUCBVqQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 16:46:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261989AbUCBVqP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 16:46:15 -0500
Received: from smtp01.web.de ([217.72.192.180]:60948 "EHLO smtp.web.de")
	by vger.kernel.org with ESMTP id S261852AbUCBVmU (ORCPT
	<rfc822;Linux-Kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 16:42:20 -0500
Date: Tue, 2 Mar 2004 22:39:18 +0100
From: Stefan Karrmann <sk@mathematik.uni-ulm.de>
To: Riley@Williams.Name, Linux-Kernel@vger.kernel.org, davej@codemonkey.org.uk,
       hpa@zytor.com
Subject: kernel panic at boot time
Message-ID: <20040302213918.GA807@web.de>
Reply-To: sk@mathematik.uni-ulm.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Mail-Reply-To: <sk@mathematik.uni-ulm.de>
X-MailKey: xkJ5TvOgzl4Iya5d0JvKP8S_ztRnvAgZAz
X-Passkey: b8b2906d4f8f939edc6277942ddcc3f2b97cab9774309f1ccbef5b9255c9e703
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

my 2.6.3 (and 2.6.2) kernel panics at boot time. It's last message is:

------------------------Begin-------------------------------------------------
EIP: 0060:[<c011bb74>] Not tainted
EFLAGS: 00010286
EIP is at remap_area_pages+0x34/0x1f0
eax: c0101000 [...]
esi: 17ff0000 [...]
ds: 007b es: 007b ss:0068

Process swapper (pid: 1, threadinfo=c12ba000, task=c12b698c0
Stack: c152708
       c0132782
       7b0c3000
Call Trace:
  c0152708 __get_vm_area+0x24/0x100
           get_vn_area+0x32/0x40
           __ioremap+0xaf/0x110
           shf_init+0x165/0x1a0
           do_initcalls+0x2b/0xa0
           init_workqueues+0xf/0x30
           init+0x32/0x160
           init+0x0/0x1060
           kernel_thread_helper+0x5/0xc
code: 0f 0b 51 00 40 55 34 c0 b8 00 00 ff ff 21 e0 ff 40 14 8b 54
spurious 8259A interrupt IRQ7
kernel panic: Attempted to kill init!
------------------------ END -------------------------------------------------

My .config is attached.

Hope that it helps to improve the code.

Sincerly,
-- 
Stefan

There is no delight the equal of dread.  As long as it is somebody else's.
		--Clive Barker
