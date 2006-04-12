Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751197AbWDLAhg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751197AbWDLAhg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 20:37:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751208AbWDLAhf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 20:37:35 -0400
Received: from mta207-rme.xtra.co.nz ([210.86.15.118]:5035 "EHLO
	mta207-rme.xtra.co.nz") by vger.kernel.org with ESMTP
	id S1751197AbWDLAhe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 20:37:34 -0400
X-Originating-IP: [139.80.27.22]
From: Zhiyi Huang <zhiyi6@xtra.co.nz>
Reply-To: hzy@cs.otago.ac.nz
Organization: Univ of Otago
To: <linux-kernel@vger.kernel.org>
CC: <zhiyi6@xtra.co.nz>
Subject: Slab corruption after unloading a module
Date: Wed, 12 Apr 2006 12:37:23 +1200
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Message-Id: <20060412003723.OFTM8268.mta4-rme.xtra.co.nz@[202.27.184.228]>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there, I am a bit timid to post a message to the list after reading the FAQ,
but I did get a problem. When reply, please cc to my email address.
My kernel info: Linux version 2.6.8 (root@zhiyi) (gcc version 3.3.5 (Debian
1:3.3.5-8)) #1
Everytime (except the first time) I unload my module (a ram device), I got the
following message. Please just indicate if it is a kernel bug or if there is any
fix patch. At the moment I have no clue. I used kmalloc and alloc_page to
allocate memory dynamically when the ram device grows. And I freed them
when the module is unloaded of course.

Hello world from Template Module
temp device MAJOR is 253
Good bye from Template Module: 618 pages
Hello world from Template Module
temp device MAJOR is 253
Good bye from Template Module: 618 pages
Slab corruption: start=c7c12d24, len=192
Redzone: 0x5a2cf071/0x5a2cf071.
Last user: [<c01ac52d>](load_elf_interp+0xdd/0x2d0)
070: 6b 6b 6b 6b 98 2d c1 c7 98 2d c1 c7 6b 6b 6b 6b
Prev obj: start=c7c12c58, len=192
Redzone: 0x5a2cf071/0x5a2cf071.
Last user: [<c01ac52d>](load_elf_interp+0xdd/0x2d0)
000: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
010: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
Next obj: start=c7c12df0, len=192
Redzone: 0x5a2cf071/0x5a2cf071.
Last user: [<00000000>](0x0)
000: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
010: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b


