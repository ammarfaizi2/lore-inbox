Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289564AbSAJR3R>; Thu, 10 Jan 2002 12:29:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289565AbSAJR3I>; Thu, 10 Jan 2002 12:29:08 -0500
Received: from ns.suse.de ([213.95.15.193]:35089 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S289564AbSAJR26>;
	Thu, 10 Jan 2002 12:28:58 -0500
Date: Thu, 10 Jan 2002 18:28:57 +0100 (CET)
From: Dave Jones <davej@suse.de>
To: Giacomo Catenazzi <cate@debian.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, "H. Peter Anvin" <hpa@zytor.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: initramfs programs (was [RFC] klibc requirements)
In-Reply-To: <3C3DCBA7.4080802@debian.org>
Message-ID: <Pine.LNX.4.33.0201101822020.21159-100000@wotan.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Jan 2002, Giacomo Catenazzi wrote:

> It is already difficult to maintain the database of CPU.
> The newer CPUs have name stored directly in CPU and no more
> in kernel :-(

It's worse than you think.
Distinguishing between XP and MP athlon for example needs
capability bit testing.  (And some XP's _are_ now multiprocessor
capable, just to confuse the issue some more), so relying on
the cpuid identity string isn't foolproof.
(Also, some implementations allow for this string to be changed,
 some folks have it set to "PenguinPowered" and the likes 8-)

> This is a call for help: how to write a table
> CPU - CONFIG_SYMBOL ?
> Now I use Vendor/Name/Family/Stepping/, but
> maybe with Vendor + flags (CPUID flags) the result
> will be more correct?

Asides from the above issues, multiple CPUs have the same
cpuid sometimes, meaning you have to check things like
cache size as well (though most (all?) of these should
end up with the same CONFIG_ option iirc, so this shouldn't
be an issue -- you should check to be sure though)

x86info's identify.c files should give you a fairly
comprehensive guide to the various types.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

