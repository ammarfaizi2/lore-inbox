Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267155AbSKMJbx>; Wed, 13 Nov 2002 04:31:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267156AbSKMJbx>; Wed, 13 Nov 2002 04:31:53 -0500
Received: from dp.samba.org ([66.70.73.150]:44202 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S267155AbSKMJbv>;
	Wed, 13 Nov 2002 04:31:51 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Zwane Mwaikambo <zwane@holomorphy.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH][2.5] smp_init 'CPUS done' looks strange 
In-reply-to: Your message of "Tue, 12 Nov 2002 22:50:38 CDT."
             <Pine.LNX.4.44.0211122246540.24523-100000@montezuma.mastecende.com> 
Date: Wed, 13 Nov 2002 20:34:25 +1100
Message-Id: <20021113093843.52D432C0B0@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.44.0211122246540.24523-100000@montezuma.mastecende.com> 
you write:
> Also, it would make sense in the future if smp_cpus_done actually gets a 
> value denoting how many cpus are online.

No.  Drop the prink by all means, but smp_cpus_done() can call
num_online_cpus() itself.  It can't know how many cpus the user
specified, however.

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
