Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265667AbUBJGvJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 01:51:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265669AbUBJGvJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 01:51:09 -0500
Received: from fw.osdl.org ([65.172.181.6]:40426 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265667AbUBJGvH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 01:51:07 -0500
Date: Mon, 9 Feb 2004 22:53:36 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jeff Chua <jeffchua@silk.corp.fedex.com>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] warning: `__attribute_used__' redefined
Message-Id: <20040209225336.1f9bc8a8.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0402101434260.27213@boston.corp.fedex.com>
References: <Pine.LNX.4.58.0402101434260.27213@boston.corp.fedex.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Chua <jeffchua@silk.corp.fedex.com> wrote:
>
> Here's a small fix for linux 2.6.3-rc2 to get rid of the annoying warnings
>  while non-kernel programs ...
> 
>  /usr/include/linux/compiler-gcc2.h:15: warning: `__attribute_used__' redefined
>  /usr/include/sys/cdefs.h:170: warning: this is the location of the previous definition

It is more likely that we need to extend the __KERNEL__ coverage somewhere.

Can you please do a `gcc -H' of that application and show us the inclusion
route by which it is hitting compiler.h?

