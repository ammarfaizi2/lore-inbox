Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266135AbTLaGTb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Dec 2003 01:19:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266136AbTLaGTb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Dec 2003 01:19:31 -0500
Received: from dp.samba.org ([66.70.73.150]:15046 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S266135AbTLaGTa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Dec 2003 01:19:30 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: auntvini <auntvini@sedal.usyd.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: task_struct and uid of a task 
In-reply-to: Your message of "Wed, 31 Dec 2003 16:13:05 +1100."
             <5.1.1.5.2.20031231155606.03376908@brain.sedal.usyd.edu.au> 
Date: Wed, 31 Dec 2003 17:15:57 +1100
Message-Id: <20031231061928.944B22C08B@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <5.1.1.5.2.20031231155606.03376908@brain.sedal.usyd.edu.au> you write:
> Previously I thought that the uid in the struct task_struct
> is going to be original user id. Now I find it is not the case always as 
> child inherits parent uid
> 
> Then I used p->uid. which is not true.

It should be true for non-root users, except for setuid programs which
can alter it.

> Do you know any global structure that keeps the original user id (say 500, 
> 501 etc)?
> 
> Or I may have to introduce another variable in this regard.

I'm not sure what problem you are having.  There are only two real
ways that uids can change: setuid programs, and root calling setuid or
setreuid.

Adding another variable which contained the "original, unchanged" uid
doesn't really make sense, since it would always be 0, the uid of
init.

A little confused, but I hope that helps,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
