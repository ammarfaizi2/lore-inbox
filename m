Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314138AbSIIINL>; Mon, 9 Sep 2002 04:13:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315267AbSIIINL>; Mon, 9 Sep 2002 04:13:11 -0400
Received: from dp.samba.org ([66.70.73.150]:14768 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S314138AbSIIINK>;
	Mon, 9 Sep 2002 04:13:10 -0400
Date: Mon, 9 Sep 2002 18:06:19 +1000
From: Rusty Russell <rusty@rustcorp.com.au>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Important per-cpu fix.
Message-Id: <20020909180619.7934b455.rusty@rustcorp.com.au>
In-Reply-To: <al43it$mel$1@cesium.transmeta.com>
References: <20020903.195455.117344683.davem@redhat.com>
	<20020904042036.816A62C1B6@lists.samba.org>
	<al43it$mel$1@cesium.transmeta.com>
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; powerpc-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3 Sep 2002 21:52:45 -0700
"H. Peter Anvin" <hpa@zytor.com> wrote:

> Followup to:  <20020904042036.816A62C1B6@lists.samba.org>
> By author:    Rusty Russell <rusty@rustcorp.com.au>
> In newsgroup: linux.dev.kernel
> >
> > In message <20020903.195455.117344683.davem@redhat.com> you write:
> > >    From: Rusty Russell <rusty@rustcorp.com.au>
> > >    Date: Wed, 04 Sep 2002 12:35:41 +1000
> > > 
> > >    This might explain the wierd per-cpu problem reports from Andrew and
> > >    Dave, and also that nagging feeling that I'm an idiot...
> > > 
> > > Verifying...  no without the explicit initializers the per-cpu stuff
> > > still ends up in the BSS with egcs-2.9X, even with your fix applied.
> > 
> > OK.  I really hate working around wierd toolchain bugs (I use 2.95.4
> > here and it's fine), and adding an initializer to the macro is ugly.
> 
> gcc puts all uninitialized variables in .bss, and it apparently can't
> be overridden.  This seems to be a side effect of the way gcc handles
> common variables.

Err... no, as I said, it doesn't happen with 2.95.4 or 3.0.4.

Rusty.
-- 
   there are those who do and those who hang on and you don't see too
   many doers quoting their contemporaries.  -- Larry McVoy
