Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261870AbUCLAxz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 19:53:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261885AbUCLAxy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 19:53:54 -0500
Received: from dp.samba.org ([66.70.73.150]:51134 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S261870AbUCLAxx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 19:53:53 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Kingsley Cheung <kingsley@aurema.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Trivial Patch] Bad tgid and tid lookup for /proc 
In-reply-to: Your message of "Mon, 09 Feb 2004 13:51:10 +1100."
             <20040209135110.H17768@aurema.com> 
Date: Fri, 12 Mar 2004 09:09:09 +1100
Message-Id: <20040312005401.DD4032C733@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20040209135110.H17768@aurema.com> you write:
> All,
> 
> On 2.6.2, one can do the following, which is clearly wrong:
> 
> gen2 02:49:45 ~: cat /proc/1/task/$$/stat
> 1669 (bash) S 1668 1669 1669 34816 1730 256 1480 6479 12 4 8 5 5 17 15 0 1 0 
8065 3252224 451 4294967295 134512640 134955932 3221225104 3221222840 429496014
4 0 65536 3686404 1266761467 3222442959 0 0 17 0 0 0
> gen2 02:50:44 ~: ls /proc/1/task
> 1

Patch was mangled, and IMHO wasn't exactly trivial.  As I understand
it, you could access any task under /proc/xxx/task.  Your patch seems to
make it that you can access any task under /proc/xxx/task if xxx is a
thread group leader.

A little confused,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
