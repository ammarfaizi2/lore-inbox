Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262326AbSK0L47>; Wed, 27 Nov 2002 06:56:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262360AbSK0L47>; Wed, 27 Nov 2002 06:56:59 -0500
Received: from gjs.xs4all.nl ([80.126.25.16]:11028 "EHLO mail.gjs.cc")
	by vger.kernel.org with ESMTP id <S262326AbSK0L4z>;
	Wed, 27 Nov 2002 06:56:55 -0500
Content-Type: text/plain; charset=US-ASCII
From: GertJan Spoelman <kl@gjs.cc>
To: Petr Baudis <pasky@ucw.cz>
Subject: Re: [PATCH] Updated Documentation/kernel-parameters.txt (resent, v3)
Date: Wed, 27 Nov 2002 13:04:11 +0100
User-Agent: KMail/1.4.3
References: <20021123093600.GV25628@pasky.ji.cz> <200211231617.08772.kl@gjs.cc> <20021124154808.GC25628@pasky.ji.cz>
In-Reply-To: <20021124154808.GC25628@pasky.ji.cz>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200211271304.11956.kl@gjs.cc>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 24 November 2002 16:48, Petr Baudis wrote:
> Dear diary, on Sat, Nov 23, 2002 at 04:17:08PM CET, I got a letter,
> where GertJan Spoelman <kl@gjs.cc> told me, that...
>
> > parameter. To me it looks like the mem parameter can now only be used to
> > specify less memory then the kernel actually recognizes.
>
> Huh.. That could be some bug actually.. try to report this in a separate
> mail with some attractive subject ;-).

I have looked further into this, but it seemes intentional, if you look at the 
comment in arch/i386/kernel/setup.c of 2.4.20-rc4 it says:
If the user specifies memory size, we limit the BIOS-provided memory map to 
that size. exactmap can be used to specify the exact map. mem=number can be 
used to trim the existing memory map.

The comment in 2.4.18 was: If the user specifies memory size, we blow away any 
automatically generated size.

If you still think it's a bug, let me know and I'll report it in a seperate 
mail.

> > Also can you add how to use the mem=exactmap parameter, it says now that
> > such lines can be constructed based on BIOS output or other requirements,
> > that doesn't tell me how such a line should look like, I only found out
> > how to use it by searching through posts on lkml, maybe you can add the
> > above append lines as an example.
>
> Thanks for the idea, done.

Thanks.
-- 

    GertJan
