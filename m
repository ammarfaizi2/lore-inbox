Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263333AbTAJHYq>; Fri, 10 Jan 2003 02:24:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263837AbTAJHYq>; Fri, 10 Jan 2003 02:24:46 -0500
Received: from dp.samba.org ([66.70.73.150]:3564 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S263333AbTAJHYo>;
	Fri, 10 Jan 2003 02:24:44 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Another idea for simplifying locking in kernel/module.c 
In-reply-to: Your message of "Mon, 06 Jan 2003 18:19:57 -0800."
             <200301070219.SAA12905@adam.yggdrasil.com> 
Date: Wed, 08 Jan 2003 22:46:24 +1100
Message-Id: <20030110073328.9C6A22C0D2@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <200301070219.SAA12905@adam.yggdrasil.com> you write:
> 	Here is a way to replace all of the specialized "stop CPU"
> locking code in kernel/module.c with an rw_semaphore by using
> down_read_trylock in try_module_get() and down_write when beginning to
> unload the module.

And now you can't modularize netfilter modules.

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
