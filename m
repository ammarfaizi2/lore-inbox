Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261764AbTIYI2B (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 04:28:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261773AbTIYI12
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 04:27:28 -0400
Received: from dp.samba.org ([66.70.73.150]:10648 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S261772AbTIYI1V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 04:27:21 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: davidm@HPL.HP.COM
Cc: akpm@zip.com.au, neilb@cse.unsw.edu.au, braam@clusterfs.com,
       davem@redhat.com, Martin Schwidefsky <schwidefsky@de.ibm.com>,
       tridge@samba.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sysctl-controlled number of groups. 
In-reply-to: Your message of "Wed, 24 Sep 2003 21:19:39 MST."
             <16242.27867.715648.392875@napali.hpl.hp.com> 
Date: Thu, 25 Sep 2003 18:08:25 +1000
Message-Id: <20030925082720.9E6542C3B6@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <16242.27867.715648.392875@napali.hpl.hp.com> you write:
> >From the ia64-side, it looks mostly fine to me.  Some minor things:
> 
>  - Typo in first sentence of patch comment (can be -> to be ?)

Thanks, fixed.

>  - If I'm reading the patch right, there will be identical sys32_getgroups16()
>    definitions in .../ia32/sys_ia32.c and and compat_linux.c; did you mean
>    to name the latter compat_getgroups16()?  (ditto for setgroups16 and s390
>    and sparc64, i think)

You're not reading it right: I didn't change the names, but since
these (your) versions call the normal ones, I added the extern decl.

>  - I suspect removing NGROUPS from param.h will break glibc and/or user-level
>    apps.  param.h is one of those kernel files that are directly exposed
>    to user-level; may want to keep NGROUPS inside an #ifndef __KERNEL__.

AFAICT, they should use NGROUPS_MAX from limits.h, which I left.

Thanks,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
