Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264586AbUAaN65 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jan 2004 08:58:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264602AbUAaN65
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jan 2004 08:58:57 -0500
Received: from dp.samba.org ([66.70.73.150]:63418 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S264586AbUAaN64 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jan 2004 08:58:56 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004@gmx.net>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] [2.6.2-rc3] Fix module.c pointer arithmetics 
In-reply-to: Your message of "Sat, 31 Jan 2004 13:52:48 BST."
             <401BA520.7070204@gmx.net> 
Date: Sun, 01 Feb 2004 00:55:12 +1100
Message-Id: <20040131135910.7892A2C0A3@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <401BA520.7070204@gmx.net> you write:
> -	for (i = 0; __start___ksymtab+i < __stop___ksymtab; i++) {
> +	for (i = 0; __start___ksymtab+i*sizeof(struct kernel_symbol) < __stop___ksymtab; i++) {

Above in this file, there is the declaration:

extern const struct kernel_symbol __start___ksymtab[];

What makes you think you need to multiply here?

Puzzled,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
