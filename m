Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261501AbSJ2Cns>; Mon, 28 Oct 2002 21:43:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261497AbSJ2Cns>; Mon, 28 Oct 2002 21:43:48 -0500
Received: from dp.samba.org ([66.70.73.150]:51682 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S261501AbSJ2Cnr>;
	Mon, 28 Oct 2002 21:43:47 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: cmm@us.ibm.com
Cc: dipankar@gamebox.net, Hugh Dickins <hugh@veritas.com>,
       Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH]updated ipc lock patch 
In-reply-to: Your message of "Mon, 28 Oct 2002 14:07:23 -0800."
             <3DBDB51B.84F97EC1@us.ibm.com> 
Date: Tue, 29 Oct 2002 12:06:49 +1100
Message-Id: <20021029025009.969372C28F@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <3DBDB51B.84F97EC1@us.ibm.com> you write:
> > Yes, this is the typical RCU model, except that in this case (IPC),
> > I am not quite sure if it is in effect that different from what Ming/Hugh
> > have done.
> 
> Rusty's patch looks good to me. I would like to replace the mempool in
> IPC with this typical RCU model. Rusty, if you like, I will make a patch
> against mm6.  There need some cleanups. One thing is that ipc_alloc()
> are called by other places(besides grow_ary()), and they don't need to
> the RCU header structure. 

Yes, I noticed that, but I'm not sure it's worth separating
ipc_alloc() and ipc_rcu_alloc() for a couple of temporary allocations.

Anyway, glad you like the patch,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
