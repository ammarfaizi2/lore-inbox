Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263775AbTFDSQV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 14:16:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263790AbTFDSQV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 14:16:21 -0400
Received: from air-2.osdl.org ([65.172.181.6]:5804 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263775AbTFDSQU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 14:16:20 -0400
Date: Wed, 4 Jun 2003 11:31:09 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise
To: linux-kernel@vger.kernel.org
Subject: Is sys_sysfs used? 
Message-ID: <Pine.LNX.4.44.0306041124250.13077-100000@cherise>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


In fs/filesystems.c, we have sys_sysfs: 

/*
 * Whee.. Weird sysv syscall. 
 */
asmlinkage long sys_sysfs(int option, unsigned long arg1, unsigned long arg2)
{
	...
}

Which is, as advertised, kinda weird. 

I see that only one architecture defines __NR_sysfs: x86-64, though it
appears most architectures mention it in arch/*/kernel/entry.S (or 
equivalent). 

Is it used anymore? Would it be possible to remove it? 


	-pat

