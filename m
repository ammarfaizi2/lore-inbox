Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267787AbUBRVgM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 16:36:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268172AbUBRVgL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 16:36:11 -0500
Received: from sea2-f13.sea2.hotmail.com ([207.68.165.13]:23818 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S267787AbUBRVgH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 16:36:07 -0500
X-Originating-IP: [217.132.243.51]
X-Originating-Email: [zstingx@hotmail.com]
From: "sting sting" <zstingx@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: build error : drivers/char/char.o(__ksymtab+0x110): undefined reference to `
Date: Wed, 18 Feb 2004 23:35:53 +0200
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <Sea2-F133D4rGVcMNKW000372f6@hotmail.com>
X-OriginalArrivalTime: 18 Feb 2004 21:35:53.0830 (UTC) FILETIME=[2FAAE860:01C3F667]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
I am trying to add a test module to the kernel image (2.4.20).
I wrote a simple module, named test.c; I do succeed to build it as a module,
perform insmod and rmmod twith it, etc.

Now I want it to be a part of the kernel Image.
The kernel itself does pass full build successfully without this change.

I had put test.c under drivers/char;
I had added it in the makefile under drivers/char
in the follwoing way

obj-$(CONFIG_TEST) += test.o

In config.in under drivers/char I had put :
   tristate 'test' CONFIG_TEST

I had run make menuconfig and selceted this character device (test) with *.


Now when I try to compile it I have an error  about export_symbol.
Since this module that have a call to the EXPORT_SYMBOL
macro, I had tried to add it to the list of export-objs in that Makefile 
(under /drivers/char)
but Now , when running make , I have the follwoing error:

rivers/char/char.o(__ksymtab+0x110): undefined reference to `local symbols 
in discarded section .text.exit'
make: *** [vmlinux] Error 1

any idea which can help will be appreciated.
regards,
sting

_________________________________________________________________
Add photos to your messages with MSN 8. Get 2 months FREE*. 
http://join.msn.com/?page=features/featuredemail

