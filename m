Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289499AbSAJPbs>; Thu, 10 Jan 2002 10:31:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289501AbSAJPbc>; Thu, 10 Jan 2002 10:31:32 -0500
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:60069
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S289499AbSAJPbW>; Thu, 10 Jan 2002 10:31:22 -0500
Date: Thu, 10 Jan 2002 08:30:59 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Zygo Blaxell <uixjjji1@umail.furryterror.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Moving zlib so that others may use it
Message-ID: <20020110153059.GX13931@cpe-24-221-152-185.az.sprintbbd.net>
In-Reply-To: <24080.1010637887@kao2.melbourne.sgi.com> <3C3D22F8.1080201@acm.org> <a1jnbs$r0s$1@shippou.furryterror.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a1jnbs$r0s$1@shippou.furryterror.org>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2002 at 04:37:00AM -0500, Zygo Blaxell wrote:
> In article <3C3D22F8.1080201@acm.org>, Corey Minyard  <minyard@acm.org> wrote:
> >Keith Owens wrote:
> >
> >>On Wed, 09 Jan 2002 22:23:31 -0600, 
> >>Corey Minyard <minyard@acm.org> wrote:
> >>>Keith Owens wrote:
> [...]
> >Building zlib as a
> >>module guarantees that you cannot use it in a boot loader, forcing you
> >>to maintain multiple versions of zlib.c.  If you are going to use one
> >>version of zlib then you should try to handle bootloaders as well.
> [...]
> >I don't know about the bootloaders.  I'm not sure you can make the 
> >requirement
> >to have them compiled the same as the kernel, since they may have different
> >compilation requirements in the boot loader.
> 
> Ummm, you can't use an in-kernel anything in a bootloader.  How do you
> uncompress an in-kernel zlib.o without an out-of-kernel zlib.o lying
> around somewhere?

Well, when your 'bootloader' is in arch/$(ARCH)/boot, you can rather
easily.  I think there's a few archs which grab lib/lib.a right now.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
