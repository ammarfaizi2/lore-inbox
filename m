Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264838AbSKUV23>; Thu, 21 Nov 2002 16:28:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264839AbSKUV23>; Thu, 21 Nov 2002 16:28:29 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:14099 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S264838AbSKUV22>; Thu, 21 Nov 2002 16:28:28 -0500
Date: Thu, 21 Nov 2002 16:34:32 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Jeff Garzik <jgarzik@pobox.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mii module broken under new scheme
In-Reply-To: <3DDA84D2.5050009@pobox.com>
Message-ID: <Pine.LNX.3.96.1021121161848.10456G-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Nov 2002, Jeff Garzik wrote:

> However, for inclusion in the kernel, it is not needed.  Quite simply, 
> mii.c is essentially a library, and it needs absolutely no 
> initialization nor cleanup at all.  Thus, it is a bug in the module 
> loader that any code changes at all are required.

  I'm afraid it's not.

> There exists a no_module_init tag, which is in theory the proper fix for 
> this problem under rusty's system, but that is itself a bug:  it's 
> redundant just like the silly EXPORT_NO_SYMBOLS tag -- it's stating the 
> obvious.  The module loader needs to notice a lack of init_module and 
> exit_module and handle it accordingly.

  It does.

  I reread the discussion on this, and I still don't see what great
benefit the new loader brings, or why it was allowed to break all the
existing modules.

  A software interface is a contract between caller and service. As long
as it doesn't change you can rewrite either side of it without breaking
the other. That reduces maintenance and is something I thought was
standard software engineering, best practices, etc.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

