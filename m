Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262756AbVGMLJ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262756AbVGMLJ4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 07:09:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262850AbVGMLHm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 07:07:42 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:61388 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S262756AbVGMLFT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 07:05:19 -0400
Date: Wed, 13 Jul 2005 13:04:38 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Arjan van de Ven <arjan@infradead.org>
cc: vacant2005@o2.pl, linux-kernel@vger.kernel.org
Subject: Re: system.map
In-Reply-To: <1121252168.3959.13.camel@laptopd505.fenrus.org>
Message-ID: <Pine.LNX.4.61.0507131302550.14635@yvahk01.tjqt.qr>
References: <200507121834.50084.vacant2005@o2.pl> 
 <Pine.LNX.4.61.0507131220360.14635@yvahk01.tjqt.qr>
 <1121252168.3959.13.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> >Jul 11 12:18:48 localhost kernel: Inspecting /boot/System.map
>> >Jul 11 12:18:48 localhost kernel: Loaded 28063 symbols from /boot/System.map.
>> >Jul 11 12:18:48 localhost kernel: Symbols match kernel version 2.6.12.
>> >Jul 11 12:18:48 localhost kernel: No module symbols loaded - kernel modules 
>> >notenabled.
>
>so whatever is spewing that is something else, but not the kernel.

These four messages are the first four ones that appear after the boot loader 
set EIP to the kernel entry point. The first four printks, if you want so. And 
apparently, the first four appearing in dmesg, obviously.

Maybe some more info helps (from /var/log/boot.msg, a copy of dmesg):

	Inspecting /boot/System.map-2.6.13-TP1
	Loaded 24854 symbols from /boot/System.map-2.6.13-TP1.
	Symbols match kernel version 2.6.13.
	No module symbols loaded - kernel modules not enabled.

	klogd 1.4.1, log source = ksyslog started.
	20: 00000000000e8000 - 00000000000ea000 (reserved)
	<4> BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
	.... BIOS-lots of more
	<5>255MB LOWMEM available.
	<7>On node 0 totalpages: 65520
	<7>  DMA zone: 4096 pages, LIFO batch:1
	...

klogd.


Jan Engelhardt
-- 
