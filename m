Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289573AbSAJRn6>; Thu, 10 Jan 2002 12:43:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289574AbSAJRns>; Thu, 10 Jan 2002 12:43:48 -0500
Received: from ns.suse.de ([213.95.15.193]:9747 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S289573AbSAJRnc>;
	Thu, 10 Jan 2002 12:43:32 -0500
Date: Thu, 10 Jan 2002 18:43:31 +0100 (CET)
From: Dave Jones <davej@suse.de>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Giacomo Catenazzi <cate@debian.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        <linux-kernel@vger.kernel.org>
Subject: Re: initramfs programs (was [RFC] klibc requirements)
In-Reply-To: <3C3DD011.7010309@zytor.com>
Message-ID: <Pine.LNX.4.33.0201101841050.21159-100000@wotan.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Jan 2002, H. Peter Anvin wrote:

> > (Also, some implementations allow for this string to be changed,
> >  some folks have it set to "PenguinPowered" and the likes 8-)
> Sure, but if you do that you're *asking*, in a very literal way, for
> your CPU to misidentified.  In fact, a major reason for making this
> string modifiable is due to certain vendors who hard-code CPUID strings
> in their code.

Absolutely, no argument from me there.

> > Asides from the above issues, multiple CPUs have the same
> > cpuid sometimes, meaning you have to check things like
> > cache size as well (though most (all?) of these should
> > end up with the same CONFIG_ option iirc, so this shouldn't
> > be an issue -- you should check to be sure though)
> Why -- if it doesn't change anything, all you're doing is making it
> confusing when the next derivative appears.  Remember that we *do* need,
>   as much as possible, to be forward compatible with future CPUs.

If every combination for a given cpuid translates to the same CONFIG_
option, fine. I'm just not sure from memory if thats the case or not.
The various Celeron/PIII's for example, some have SSE, some don't.
Assuming Intel cpuid xxx translates to CONFIG_PENTIUMIII would break if
thats the case.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

