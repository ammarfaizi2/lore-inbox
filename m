Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261509AbSJ2C6f>; Mon, 28 Oct 2002 21:58:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261514AbSJ2C6f>; Mon, 28 Oct 2002 21:58:35 -0500
Received: from dp.samba.org ([66.70.73.150]:39652 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S261509AbSJ2C6e>;
	Mon, 28 Oct 2002 21:58:34 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Hugh Dickins <hugh@veritas.com>
Cc: mingming cao <cmm@us.ibm.com>, Andrew Morton <akpm@digeo.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH]updated ipc lock patch 
In-reply-to: Your message of "Tue, 29 Oct 2002 00:26:27 -0000."
             <Pine.LNX.4.44.0210282357450.1315-100000@localhost.localdomain> 
Date: Tue, 29 Oct 2002 13:51:20 +1100
Message-Id: <20021029030456.F06272C259@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.44.0210282357450.1315-100000@localhost.localdomain> you 
write:
> > 2) This is a problem, because other tasks could be OOM killed during
> >    that period, and could also try to use this mempool.
> 
> They'll try to use the mempool, maybe some will be allowed to wait
> for their kmalloc(GFP_KERNEL) memory, and others will be PF_MEMDIEd and
> proceed to take a reserved mempool buffer, and others will be PF_MEMDIEd
> and have to wait for a reserved mempool buffer.  Which will be released
> to them in due course.  No worries there.

Oh.

You are (of course) correct.  Thankyou for your patience.  Your
solution is elegant and correct.

Feeling dimwitted,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
