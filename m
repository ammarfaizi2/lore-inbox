Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317679AbSGUO0A>; Sun, 21 Jul 2002 10:26:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317680AbSGUO0A>; Sun, 21 Jul 2002 10:26:00 -0400
Received: from admin.nni.com ([216.107.0.51]:35851 "EHLO admin.nni.com")
	by vger.kernel.org with ESMTP id <S317679AbSGUOZ7>;
	Sun, 21 Jul 2002 10:25:59 -0400
Date: Mon, 22 Jul 2002 10:26:58 -0400
From: Andrew Rodland <arodland@noln.com>
To: Martin Josefsson <gandalf@wlug.westbo.se>
Cc: mru@users.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: memory leak?
Message-Id: <20020722102658.731a2200.arodland@noln.com>
In-Reply-To: <1027261239.785.8.camel@tux>
References: <yw1xn0sluqom.fsf@gladiusit.e.kth.se>
	<20020722100840.2599c2f3.arodland@noln.com>
	<1027261239.785.8.camel@tux>
X-Mailer: Sylpheed version 0.7.8claws55 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 21 Jul 2002 16:20:39 +0200
Martin Josefsson <gandalf@wlug.westbo.se> wrote:

> free don't know about slabcaches. take a look in /proc/slabinfo and
> see what's using that memory. it's not a leak, the memory will be
> free'd when the machine is under enough memory pressure.
> 

Yeah... look at that. looks like I've got quite a bit of memory
invested in inode_cache and dentry_cache. There's no way to have them
reported as "cache" memory anymore?

