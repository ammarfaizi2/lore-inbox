Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265931AbSKBKz0>; Sat, 2 Nov 2002 05:55:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265932AbSKBKz0>; Sat, 2 Nov 2002 05:55:26 -0500
Received: from ns.suse.de ([213.95.15.193]:9732 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S265931AbSKBKz0>;
	Sat, 2 Nov 2002 05:55:26 -0500
Date: Sat, 2 Nov 2002 12:01:55 +0100
From: Andi Kleen <ak@suse.de>
To: Dipankar Sarma <dipankar@gamebox.net>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: dcache_rcu [performance results]
Message-ID: <20021102120155.A17591@wotan.suse.de>
References: <20021030161912.E2613@in.ibm.com.suse.lists.linux.kernel> <20021031162330.B12797@in.ibm.com.suse.lists.linux.kernel> <3DC32C03.C3910128@digeo.com.suse.lists.linux.kernel> <20021102144306.A6736@dikhow.suse.lists.linux.kernel> <p734rb0s2qb.fsf@oldwotan.suse.de> <20021102162419.A7894@dikhow>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021102162419.A7894@dikhow>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Well, on second thoughts I can't see why the path length for pwd
> would make difference for kernel compilation - it uses relative
> path and for path lookup, if the first character is not '/', then
> lookup is done relative to current->fs->pwd. I will do some more
> benchmarking on and verify.

Kernel compilation actually uses absolute pathnames e.g. for dependency
checking. TOPDIR is also specified absolutely, so an include access likely
uses an absolute pathname too.

-Andi
