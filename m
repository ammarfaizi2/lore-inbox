Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267737AbTAXPY4>; Fri, 24 Jan 2003 10:24:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267750AbTAXPY4>; Fri, 24 Jan 2003 10:24:56 -0500
Received: from adsl-67-64-81-217.dsl.austtx.swbell.net ([67.64.81.217]:2736
	"HELO digitalroadkill.net") by vger.kernel.org with SMTP
	id <S267737AbTAXPYz>; Fri, 24 Jan 2003 10:24:55 -0500
Subject: Re: Stack overflow
From: GrandMasterLee <masterlee@digitalroadkill.net>
To: Linux Geek <bourne@ToughGuy.net>
Cc: Madhavi <madhavis@sasken.com>, linux-kernel@vger.kernel.org
In-Reply-To: <3E30F0FC.1010008@ToughGuy.net>
References: <Pine.LNX.4.33.0301241232590.3655-100000@pcz-madhavis.sasken.com>
	 <3E30F0FC.1010008@ToughGuy.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Digitalroadkill.net
Message-Id: <1043422351.17256.1.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 24 Jan 2003 09:32:31 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-01-24 at 01:53, Linux Geek wrote:
> >
> >
> >I have a functionality which works well if the code whcih performs this
> >function is embedded in the required function. If this functionality is
> >implemented as a separate function, and this function is called at the
> >required place, the system crashes. I have used KDB for debugging. But,
> >  
> >
>     I'd suggest check the args passed to the function and the sizes they 
> would consume when they are passed as 'call by value'.
> Try to pass them as pointers maybe.
> 
> Yes, i think there is a limit on kernel stack but not i'm not too sure 
> about the number.

The kernel has an 8K stack max. That said, it *could* be your stack. Do
you get any panics or oops? If so, you *could* write them down :-D And
debug them later. If it appears corrupted, then it's probably stack.
