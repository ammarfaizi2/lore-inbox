Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261905AbVAaDnl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261905AbVAaDnl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jan 2005 22:43:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261906AbVAaDnl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jan 2005 22:43:41 -0500
Received: from ozlabs.org ([203.10.76.45]:4753 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261905AbVAaDnj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jan 2005 22:43:39 -0500
Subject: Re: [PATCH] micro optimization in kernel/params.c; don't call
	to_module_kobject before we really have to.
From: Rusty Russell <rusty@rustcorp.com.au>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: Brian Gerst <bgerst@didntduck.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.62.0501301307260.2731@dragon.hygekrogen.localhost>
References: <Pine.LNX.4.62.0501300024110.2829@dragon.hygekrogen.localhost>
	 <41FC2693.6060601@didntduck.org>
	 <Pine.LNX.4.62.0501301307260.2731@dragon.hygekrogen.localhost>
Content-Type: text/plain
Date: Mon, 31 Jan 2005 14:43:42 +1100
Message-Id: <1107143023.28143.9.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-01-30 at 13:43 +0100, Jesper Juhl wrote:
> True, the compiler is free to be clever, but I still think it's best to 
> write the code in the most optimal way as seen from a C perspective. 
> I just took a look at the compiled object files with and without the 
> patch, and it makes no difference what-so-ever - gcc generates the exact 
> same code. So you are right, gcc is clever about it. 

If the code were not already in the kernel, I'd probably apply this.
However, cleanups this trivial are not worthwhile IMHO.

Rusty.
-- 
A bad analogy is like a leaky screwdriver -- Richard Braakman

