Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277411AbRJJU2s>; Wed, 10 Oct 2001 16:28:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277410AbRJJU2d>; Wed, 10 Oct 2001 16:28:33 -0400
Received: from 157-151.nwinfo.net ([216.187.157.151]:25739 "EHLO
	mail.morcant.org") by vger.kernel.org with ESMTP id <S277414AbRJJU2Q>;
	Wed, 10 Oct 2001 16:28:16 -0400
Message-ID: <34710.24.255.76.12.1002745701.squirrel@webmail.morcant.org>
Date: Wed, 10 Oct 2001 13:28:21 -0700 (PDT)
Subject: Re: Tainted Modules Help Notices
From: "Morgan Collins [Ax0n]" <sirmorcant@morcant.org>
To: tkhoadfdsaf@hotmail.com
In-Reply-To: <OE64YU5ts1Tjkw1BzCf0000708c@hotmail.com>
In-Reply-To: <OE64YU5ts1Tjkw1BzCf0000708c@hotmail.com>
Cc: dwmw2@infradead.org, alan@lxorguk.ukuu.org.uk, viro@math.psu.edu,
        kaos@ocs.com.au, sirmorcant@morcant.org, linux-kernel@vger.kernel.org
X-Mailer: SquirrelMail (version 1.0.6)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>     I was under the same impression about the module licensing tagging.  I
> had read that it was suppose to be for maintainability (.i.e. source available so
> kernel gods can debug) and not to enforce ideological conformity.  Now I read that
> anything not licensed under the GPL, including BSD or simply public domain source
> code, will taint my kernel and modprobe complains about non-GPL stuff including
> parport_pc which apparently did not have a license.  Should I expect a Linux kernel
> KGB to show up next?
> 
I think what has happened here is a little bit of a misunderstanding.

I think that the modprobe source and the kernel source just aren't in sync with the
development of the new (re DEVELOPMENTAL) MOD_LICENSE() implementation.

Weither or not the BSD-NAC is GPL compatible has already been determined, as it's in the
kernel and the lead developers have said so. I trust them, they'll get sued if they don't
look at things like that. Modprobe told me a BSD module was tainted, I assumed that ment
it was incompatible with the kernel which is GPLed. I shouldn't trust everything I read :>

The problem lies in modprobe not having it in it's list of licenses to not mark as tainted.

When I modprobe ppp_deflate, it does not fail to load, it simply warned me that my kernel
would be tainted. What does having a tainted kernel mean? It is to tell kernel 
debuggers if this is a clean kernel or if anything unusual has occurred.

>     Furthermore I have to agree with the previous poster.  Any module could
> easily lie to MODULE_LICENSE about its licensing terms and that would not make it's
> source automatically "free" and GPLable so I am now wondering if this tainting
> mechanism is of any use at all.
> 
If the purpose was to discriminate against licensing, I would agree. But since
non-compatible source is not distributed with the kernel, and the mechanism is for
debugging, what is the purpose of lying to the kernel? To confuse debuggers? No point in that.

>     Just out of curiosity do all of these license tags in the modules take
> up any permanent kernel memory, especially in a heavily modularize system?
> 
A grep of /proc/kcore only showed the MODULE_LICESE in this email, and the scrollback
buffer in my xterm, so I don't think so.

-- 
Morgan Collins [Ax0n] http://sirmorcant.morcant.org
Software is something like a machine, and something like mathematics, and something like
language, and something like thought, and art, and information.... but software is not in
fact any of those other things.

