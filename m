Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261785AbTFOBqf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jun 2003 21:46:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261787AbTFOBqf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jun 2003 21:46:35 -0400
Received: from dp.samba.org ([66.70.73.150]:48597 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S261785AbTFOBqe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jun 2003 21:46:34 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Luca Barbieri <lb@lb.ods.org>
Cc: Linux-Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Fix use-after-free when trying to load an invalid module 
In-reply-to: Your message of "14 Jun 2003 14:08:32 +0200."
             <1055592512.3810.12.camel@home.lb.ods.org> 
Date: Sun, 15 Jun 2003 11:00:08 +1000
Message-Id: <20030615020024.988022C089@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <1055592512.3810.12.camel@home.lb.ods.org> you write:
> mod->module_core contains the mod structure, so it must be freed after
> mod->percpu.
> However, initialization happens in the opposite order because mod is
> moved after that, so we need to initialize module_core to 0 and check it
> later.

Thanks for the fix!  This was fixed another way, though, in Linus'
tree.

Thanks,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
