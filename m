Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319860AbSINIYA>; Sat, 14 Sep 2002 04:24:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319861AbSINIYA>; Sat, 14 Sep 2002 04:24:00 -0400
Received: from fungus.teststation.com ([212.32.186.211]:61701 "EHLO
	fungus.teststation.com") by vger.kernel.org with ESMTP
	id <S319860AbSINIX7>; Sat, 14 Sep 2002 04:23:59 -0400
Date: Sat, 14 Sep 2002 10:28:06 +0200 (CEST)
From: Urban Widmark <urban@teststation.com>
X-X-Sender: puw@cola.enlightnet.local
To: Andreas Steinmetz <ast@domdv.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: compile warning fix for smb_debug.h
In-Reply-To: <3D8222A9.8010409@domdv.de>
Message-ID: <Pine.LNX.4.44.0209141023420.32154-100000@cola.enlightnet.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Sep 2002, Andreas Steinmetz wrote:

> Hi,
> attached is a fix for gcc 3.2 deprecated usage warnings for __FUNCTION__ 
> in smb_debug.h. As gcc 2.95.3 doesn't issue the warning and can't handle 
> the new macro there's a macro selection based on the compiler major 
> version. Patch is against 2.4.20pre7.

Why not just take the version from 2.5?
Or is there a problem with this one too and gcc2.95.3?

#ifdef SMBFS_PARANOIA
# define PARANOIA(f, a...) printk(KERN_NOTICE "%s: " f, __FUNCTION__ , ## a)
#else
# define PARANOIA(f, a...) do { ; } while(0)
#endif

etc.

Note the extra space ...

/Urban

