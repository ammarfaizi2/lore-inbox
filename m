Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317616AbSINXQ4>; Sat, 14 Sep 2002 19:16:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317619AbSINXQ4>; Sat, 14 Sep 2002 19:16:56 -0400
Received: from khan.acc.umu.se ([130.239.18.139]:42654 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id <S317616AbSINXQz>;
	Sat, 14 Sep 2002 19:16:55 -0400
Date: Sun, 15 Sep 2002 01:21:28 +0200
From: David Weinehall <tao@acc.umu.se>
To: Urban Widmark <urban@teststation.com>
Cc: Andreas Steinmetz <ast@domdv.de>, linux-kernel@vger.kernel.org
Subject: Re: compile warning fix for smb_debug.h
Message-ID: <20020914232128.GQ2242@khan.acc.umu.se>
References: <3D8222A9.8010409@domdv.de> <Pine.LNX.4.44.0209141023420.32154-100000@cola.enlightnet.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0209141023420.32154-100000@cola.enlightnet.local>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 14, 2002 at 10:28:06AM +0200, Urban Widmark wrote:
> On Fri, 13 Sep 2002, Andreas Steinmetz wrote:
> 
> > Hi,
> > attached is a fix for gcc 3.2 deprecated usage warnings for __FUNCTION__ 
> > in smb_debug.h. As gcc 2.95.3 doesn't issue the warning and can't handle 
> > the new macro there's a macro selection based on the compiler major 
> > version. Patch is against 2.4.20pre7.
> 
> Why not just take the version from 2.5?
> Or is there a problem with this one too and gcc2.95.3?
> 
> #ifdef SMBFS_PARANOIA
> # define PARANOIA(f, a...) printk(KERN_NOTICE "%s: " f, __FUNCTION__ , ## a)
> #else
> # define PARANOIA(f, a...) do { ; } while(0)
> #endif
> 
> etc.
> 
> Note the extra space ...

I've tried to provoke this error, but been unable to; the code
works just fine even without the extra space. Can anyone
confirm if gcc-2.95.4 in Debian lacks this bug?!

Anyway, *please* can we try to avoid GCC-versioned code as much as
possible? Either we raise the required GCC-version (not possible until
the SPARC64-people become perfectly happy with gcc-3.2) or we stay at
a lower version and work around the warts.


Regards: David Weinehall
-- 
 /> David Weinehall <tao@acc.umu.se> /> Northern lights wander      <\
//  Maintainer of the v2.0 kernel   //  Dance across the winter sky //
\>  http://www.acc.umu.se/~tao/    </   Full colour fire           </
