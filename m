Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261605AbTIZTzv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Sep 2003 15:55:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261615AbTIZTzv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Sep 2003 15:55:51 -0400
Received: from mail1.n1.pl ([195.114.173.155]:49389 "EHLO mail1.n1.pl")
	by vger.kernel.org with ESMTP id S261605AbTIZTzu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Sep 2003 15:55:50 -0400
Message-ID: <1064606148.3f7499c45abba@www.n1.pl>
Date: Fri, 26 Sep 2003 21:55:48 +0200
From: Piotr Roszatycki <dexter@netia.net.pl>
To: linux-kernel@vger.kernel.org
Subject: initrd compiled in kernel
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.2-cvs
X-Remote-Addr: 193.219.28.146
X-Forwarded-For: 193.219.28.146, 193.219.28.146
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm trying to use initrd on Jornada 720 with hpcboot.exe (2.4.19). It doesn't
support initrd in separate file. I have to link the initrd image with kernel
image. How can I do it? I tried to make a string with image:

unsigned char initrd_image[] = "\0x00\0x00\0xFF...[about 1MB initrd image]...";
unsigned int initrd_image_size = sizeof(initrd_image);

and use it in arch/arm/kernel/setup.c as:

phys_initrd_start = initrd_image;
phys_initrd_size = initrd_image_size; 

without success.

Another way?

-- 
Piotr Roszatycki, Netia Telekom S.A.                    .''`.
mailto:Piotr_Roszatycki@netia.net.pl                   : :' :
mailto:dexter@debian.org                               `. `'
                                                         `-


