Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280801AbRLFPJx>; Thu, 6 Dec 2001 10:09:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281890AbRLFPJp>; Thu, 6 Dec 2001 10:09:45 -0500
Received: from workplace.tp1.ruhr-uni-bochum.de ([134.147.240.2]:23300 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S280801AbRLFPJl>; Thu, 6 Dec 2001 10:09:41 -0500
Date: Thu, 6 Dec 2001 16:09:16 +0100 (CET)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: <kai@vaio>
To: Eric Lammerts <eric@lammerts.org>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@zip.com.au>,
        Josh McKinney <forming@home.com>, <linux-kernel@vger.kernel.org>,
        Jeff Garzik <jgarzik@mandrakesoft.com>
Subject: Re: Fwd: binutils in debian unstable is broken.
In-Reply-To: <Pine.LNX.4.43.0112051424560.1157-100000@ally.lammerts.org>
Message-ID: <Pine.LNX.4.33.0112061608110.3905-100000@vaio>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Dec 2001, Eric Lammerts wrote:

> We can get a panic() call (and remove the ugly #ifdef's) with
> something like this:
> 
> in some .h file:
> 
> #ifdef DEVEXIT_LINKED
> #define DEVEXIT_FUNC(a) (a)
> #else
> void panic_exit_code();
> #define DEVEXIT_FUNC(a) ((typeof((a)) *)panic_exit_code)
> #endif

I definitely prefer this kind of encapsulation over #ifdef DEVEXIT_LINKED
everywhere, it's still ugly, though.

However, I don't see much advantage of panic_exit_code() over a simple
NULL. Actually, NULL will only oops, but not take the machine down, which
makes it easier to catch and report the Oops. (Not everyone who's box 
crashes under X will setup a serial console).

--Kai

