Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319050AbSIDEsc>; Wed, 4 Sep 2002 00:48:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319051AbSIDEsc>; Wed, 4 Sep 2002 00:48:32 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:12550 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S319050AbSIDEsb>; Wed, 4 Sep 2002 00:48:31 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] Important per-cpu fix.
Date: 3 Sep 2002 21:52:45 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <al43it$mel$1@cesium.transmeta.com>
References: <20020903.195455.117344683.davem@redhat.com> <20020904042036.816A62C1B6@lists.samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20020904042036.816A62C1B6@lists.samba.org>
By author:    Rusty Russell <rusty@rustcorp.com.au>
In newsgroup: linux.dev.kernel
>
> In message <20020903.195455.117344683.davem@redhat.com> you write:
> >    From: Rusty Russell <rusty@rustcorp.com.au>
> >    Date: Wed, 04 Sep 2002 12:35:41 +1000
> > 
> >    This might explain the wierd per-cpu problem reports from Andrew and
> >    Dave, and also that nagging feeling that I'm an idiot...
> > 
> > Verifying...  no without the explicit initializers the per-cpu stuff
> > still ends up in the BSS with egcs-2.9X, even with your fix applied.
> 
> OK.  I really hate working around wierd toolchain bugs (I use 2.95.4
> here and it's fine), and adding an initializer to the macro is ugly.
> 
> If you're not going to upgrade your compiler, will you accept a gcc
> patch to fix this?  If so, where can I get the source to your exact
> version?
> 

gcc puts all uninitialized variables in .bss, and it apparently can't
be overridden.  This seems to be a side effect of the way gcc handles
common variables.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
