Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262434AbVAPFyj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262434AbVAPFyj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 00:54:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262435AbVAPFyi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 00:54:38 -0500
Received: from mail.ocs.com.au ([202.147.117.210]:39365 "EHLO mail.ocs.com.au")
	by vger.kernel.org with ESMTP id S262434AbVAPFye (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 00:54:34 -0500
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: conglomerate objects in reference*.pl 
In-reply-to: Your message of "Sat, 15 Jan 2005 20:49:33 -0800."
             <41E9F25D.5050906@osdl.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 16 Jan 2005 16:22:11 +1100
Message-ID: <14049.1105852931@ocs3.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 15 Jan 2005 20:49:33 -0800, 
"Randy.Dunlap" <rddunlap@osdl.org> wrote:
>Hi Keith,
>
>I'm seeing some drivers/*/built-in.o that should be ignored AFAIK,
>but they are not ignored.  Any ideas?
>
>This is 2.6.11-rc1-bk3 on i386 with allmodconfig
>(except DEBUG_INFO=n) and gcc 3.3.3.
>
>Error: ./drivers/ide/built-in.o .text refers to 00000939 R_386_PC32 
>      .init.text
>Error: ./drivers/ide/legacy/built-in.o .text refers to 00000939 
>R_386_PC32        .init.text
>Error: ./drivers/ide/legacy/hd.o .text refers to 00000939 R_386_PC32 
>       .init.text

Output from these commands please.

rm drivers/ide/built-in.o drivers/ide/legacy/built-in.o
make SUBDIRS=drivers/ide V=1
objdump -s -j .comment drivers/ide/built-in.o | head -n15

