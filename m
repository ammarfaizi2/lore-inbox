Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932403AbWAUWKW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932403AbWAUWKW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jan 2006 17:10:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932406AbWAUWKW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jan 2006 17:10:22 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:48145 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S932403AbWAUWKV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jan 2006 17:10:21 -0500
Date: Sat, 21 Jan 2006 23:10:06 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Jari Ruusu <jariruusu@users.sourceforge.net>
Cc: linux-crypto@nl.linux.org, linux-kernel@vger.kernel.org
Subject: Re: Announce loop-AES-v3.1c file/swap crypto package
Message-ID: <20060121221006.GA7711@mars.ravnborg.org>
References: <43CE6384.284B823C@users.sourceforge.net> <20060120195035.GA9685@mars.ravnborg.org> <43D260F8.B82BCB9A@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43D260F8.B82BCB9A@users.sourceforge.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 21, 2006 at 06:27:36PM +0200, Jari Ruusu wrote:
> Sam Ravnborg wrote:
> > Either something is missing in the support for external modules in the
> > kernel or you are overdoing some stuff. If there is something missing in
> > the kernel to support external modules then please say so, so it can be
> > fixed.
> 
> Missing functionality:
> 1) "make M=/path/to/dir modules_install" does not run depmod. Pulling
>    correct depmod info from kernel Makefile needs ugly hacks.
OK, I will try to take a look at this.
The correct fix though is to upgrade module-utils to no rely on depmod.
Rusty mentioned this long time ago but no-one did it so far.

> 2) Try building external module A that exports some function, and then build
>    another external module B (separate package, only knows function
>    prototype) that uses said exported function. And I mean build it cleanly
>    without puking error messages on me. 2.4 and older kernel got that right,
>    but 2.6 is still FUBAR. Serious regression here.
OK, but I have yet to find a clean solution for it.

> Both above cases can be (and need to be) worked around using ugly hacks.
> 
> Sam,
> Please understand that loop-AES needs to work with 2.0, 2.2, 2.4 and 2.6
> kernels. Not just latest mainline, but all of them, including ones that you
> cannot retroactively change.
Fully aware ot that - my only issue was that you had to workaround some
2.6 functionality.
The objective is to provide full support for external modules in 2.6.
And you raised two valid points.

Thanks,
	Sam
