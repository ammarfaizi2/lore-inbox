Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268215AbUHaM4s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268215AbUHaM4s (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 08:56:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268325AbUHaMxT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 08:53:19 -0400
Received: from dslsmtp.struer.net ([62.242.36.21]:49937 "EHLO
	dslsmtp.struer.net") by vger.kernel.org with ESMTP id S268215AbUHaMtt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 08:49:49 -0400
Message-ID: <57438.194.237.142.7.1093956586.squirrel@194.237.142.7>
In-Reply-To: <20040831123944.38866.qmail@web50608.mail.yahoo.com>
References: <20040831123944.38866.qmail@web50608.mail.yahoo.com>
Date: Tue, 31 Aug 2004 14:49:46 +0200 (CEST)
Subject: Re: Kernel Module Compilation Error
From: "Sam Ravnborg" <sam@ravnborg.org>
To: "Jeba Anandhan A" <jeba_career@yahoo.com>
Cc: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.3a
X-Mailer: SquirrelMail/1.4.3a
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> hi,
> i am working in Fedora .
> Kernel =2.4.22-1.2115.nptl #1 Wed Oct 29 15:42:51 EST
> 2003 i686 i686 i386 GNU/Linux
>
> my kernel module program is
> #include<linux/kernel.h>
> #include<linux/module.h>
> #include<linux/mm.h>
>
>                         extern *current;
> int init_module(void){
> return 0;
> }
> void cleanup_module(void){
> }

Use a kbuld makefile:
obj-m := myfile.o

and compile using:
make -C path/to/kernel/src SUBDIRS=`pwd` modules

   Sam



